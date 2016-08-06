//
//  MHFRunLoopOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 25/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFRunLoopOperation.h"

@interface MHFRunLoopOperation()

@property (readwrite, getter=isExecuting) BOOL executing;
@property (readwrite, getter=isFinished) BOOL finished;

@end

@implementation MHFRunLoopOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    // Always check for cancellation before launching the task.
    if (self.isCancelled)
    {
        // Must move the operation to the finished state if it is canceled.
        self.finished = YES;
        return;
    }
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    @try {
        // Do the main work of the operation here.
        [self willRun];
        CFRunLoopRun();
        [self completeOperation];
    }
    @catch(...) {
        // Do not rethrow exceptions.
    }
}

-(void)willRun{
}

-(void)completeOperation{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end