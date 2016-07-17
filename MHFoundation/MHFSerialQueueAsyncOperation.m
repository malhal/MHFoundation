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

@interface MHFSerialQueueAsyncOperation()

@property (strong, nonatomic) NSOperationQueue* operationQueue;

@property (strong, nonatomic) NSError* error;

@end

@implementation MHFSerialQueueAsyncOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.suspended = YES;
        
        [self.operationQueue addObserver:self
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
            [self finishWithError:self.error];
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
        self.operationQueue.suspended = NO;
    }];
}

// also cancel any data task associated to this task
- (void)cancel{
    [super cancel];
    self.error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:@{NSLocalizedDescriptionKey : @"The queue operation was cancelled"}];
    [self.operationQueue cancelAllOperations];    
}

-(void)addOperation:(NSOperation*)op{
    [self.operationQueue mhf_addOperationAfterLast:op];
}

- (void)dealloc
{
    //NSLog(@"queue dealloc");
}

@end
