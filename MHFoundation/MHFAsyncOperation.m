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

@property (strong, nonatomic) dispatch_queue_t callbackQueue;

@end

@implementation MHFAsyncOperation{
    BOOL _isFinished;
    BOOL _isExecuting;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _callbackQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (BOOL)isAsynchronous{
    return YES;
}

- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}

-(void)cancel{
    [super cancel];
    NSError* error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorOperationCancelled descriptionFormat:@"The %@ was cancelled", self.class];
    [self finishWithError:error];
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
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    if(self.isCancelled){
        // Must move the operation to the finished state if it is canceled.
        NSError* error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorOperationCancelled descriptionFormat:@"The %@ was cancelled before it started", self.class];
        [self finishWithError:error];
        return;
    }
    
    // If the operation is not cancelled, begin executing the task.

    [self performBlockOnCallbackQueue:^{
        [self main];
    }];
}


// on the call back queue
-(void)main{
    NSError* error = nil;
    if([self asyncOperationShouldRun:&error]){
        [self performAsyncOperation];
    }else{
        [self finishOnCallbackQueueWithError:error];
    }
}

- (void)finishInternalOnCallbackQueueWithError:(NSError *)error{
    // Prevents duplicate callbacks.
    if(self.isExecuting){
        [self finishOnCallbackQueueWithError:error];
    }
}

// overriden by subclasses.
// on the call back queue
//- (void)_finish{
- (void)finishOnCallbackQueueWithError:(NSError *)error{
    if(self.asyncOperationCompletionBlock){
        self.asyncOperationCompletionBlock(error);
    }
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

// can be overridden by subclasses
-(BOOL)asyncOperationShouldRun:(NSError**)error{
    return YES;
}

// overriden by subclasses to run the operation.
-(void)performAsyncOperation{
}

// called by subclasses to complete the operation
- (void)finishWithError:(NSError*)error{ // _handleCompletionCallback
    [self performBlockOnCallbackQueue:^{
        [self finishInternalOnCallbackQueueWithError:error]; // using self here has side effect that operation is retained while it is working.
    }];
}

- (void)performBlockOnCallbackQueue:(dispatch_block_t)block {
    dispatch_async(self.callbackQueue, block);
}

@end

