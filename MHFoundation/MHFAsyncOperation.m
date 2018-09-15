//
//  MHFAsyncOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFAsyncOperation.h"
#import "MHFError.h"
#import "NSError+MHF.h"

@interface MHFAsyncOperation()

@property (readonly, strong) dispatch_queue_t callbackQueue;
@property (readwrite, assign, getter=isExecuting) BOOL executing;
@property (readwrite, assign, getter=isFinished) BOOL finished;

@end

@implementation MHFAsyncOperation

@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize callbackQueue = _callbackQueue;

- (BOOL)isAsynchronous{
    return YES;
}

// called either manually or from an operation queue's background thread.
- (void)start{
    // Always check for cancellation before launching the task.
    if (self.isCancelled && self.isFinished)
    {
        NSLog(@"Not starting already cancelled operation");
        return;
    }
    if(self.isExecuting || self.isFinished){
        [NSException raise:NSInvalidArgumentException format:@"You can't restart an executing or finished %@", self.class];
    }
    self.executing = YES;
    if(self.isCancelled){
        // Must move the operation to the finished state if it is canceled.
        NSError* error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorOperationCancelled descriptionFormat:@"The %@ was cancelled before it started", self.class];
        [self finishWithError:error];
        return;
    }
    // If the operation is not cancelled, begin executing the task.
    // By using the callback queue we get easy access to a thread to support non-queued operations,
    // and also it allows us to finish with error if shouldn't run.
    [self performBlockOnCallbackQueue:^{
        [self main];
    }];
}

- (void)performBlockOnCallbackQueue:(dispatch_block_t)block {
    dispatch_async(self.callbackQueue, block);
}

- (dispatch_queue_t)callbackQueue{
    @synchronized (self) {
        if(!_callbackQueue){
            _callbackQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
        }
    }
    return _callbackQueue;
}

// on the call back queue
- (void)main{
    if(self.isCancelled){
        return;
    }
    NSError* error = nil;
    if(![self asyncOperationShouldRun:&error]){
        [self finishOnCallbackQueueWithError:error];
        return;
    }
    [self performAsyncOperation];
}

// Overridden by subclasses for property validation
- (BOOL)asyncOperationShouldRun:(NSError **)error{
    return YES;
}

// overriden by subclasses.
// on the call back queue
- (void)finishOnCallbackQueueWithError:(NSError *)error{
    if(self.asyncOperationCompletionBlock){
        self.asyncOperationCompletionBlock(error);
    }
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    _finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

// overriden by subclasses to run the operation.
- (void)performAsyncOperation{
}

// may be called from any thread, either from subclasses in async results, or from cancel
- (void)finishWithError:(NSError *)error{ // _handleCompletionCallback
    [self performBlockOnCallbackQueue:^{
        [self finishInternalOnCallbackQueueWithError:error]; // using self here has side effect that operation is retained while it is working.
    }];
}

- (void)finishInternalOnCallbackQueueWithError:(NSError *)error{
    // Prevents duplicate callbacks.
    if(!self.isExecuting){
        return;
    }
    if(!self.isFinished){
        [self finishOnCallbackQueueWithError:error];
        return;
    }
    NSLog(@"The operation operation %@ didn't start or is already finished", self);
}

- (void)cancel{
    [super cancel];
    NSError* error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorOperationCancelled descriptionFormat:@"The %@ was cancelled", self.class];
    [self finishWithError:error];
}

@end

