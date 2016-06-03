//
//  MHRunLoopOperation.m
//  MALFoundation
//
//  Created by Malcolm Hall on 25/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MALRunLoopOperation.h"

@interface MALRunLoopOperation()

@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, assign) BOOL isFinished;

@end

@implementation MALRunLoopOperation

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    // Always check for cancellation before launching the task.
    if (self.isCancelled)
    {
        // Must move the operation to the finished state if it is canceled.
        self.isFinished = YES;
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _isExecuting = YES;
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
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


@end
