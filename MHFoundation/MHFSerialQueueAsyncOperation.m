//
//  MHFQueueAsyncOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFSerialQueueAsyncOperation.h"
#import "NSOperationQueue+MHF.h"

static NSString* kOperationCountChanged = @"kOperationCountChanged";

@implementation MHFSerialQueueAsyncOperation{
    NSOperationQueue* _operationQueue;
    NSError* _error;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.suspended = YES;
        [_operationQueue addObserver:self
                              forKeyPath:@"operationCount"
                                 options:NSKeyValueObservingOptionNew
                                 context:&kOperationCountChanged];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    // if it was our observation
    if(context == &kOperationCountChanged){
        if([[change objectForKey:NSKeyValueChangeNewKey] isEqual:@0]){
            [self finishWithError:_error];
        }
    }
    else{
        // if necessary, pass the method up the subclass hierarchy.
        if([super respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)]){
            [super observeValueForKeyPath:keyPath
                                 ofObject:object
                                   change:change
                                  context:context];
        }
    }
}

-(void)performAsyncOperation{
    // start the queue after the operations have been added by the subclass.
    [self performBlockOnCallbackQueue:^{
        _operationQueue.suspended = NO;
    }];
}

// also cancel any data task associated to this task
- (void)cancel{
    [super cancel];
    _error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:@{NSLocalizedDescriptionKey : @"The queue operation was cancelled"}];
    [_operationQueue cancelAllOperations];
}

-(void)addOperation:(NSOperation*)op{
    [_operationQueue mhf_addOperationAfterLast:op];
}

- (void)dealloc
{
    [_operationQueue removeObserver:self forKeyPath:@"operationCount"];
    //NSLog(@"queue dealloc");
}

@end
