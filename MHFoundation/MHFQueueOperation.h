//
//  MHFQueueOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 03/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFAsyncOperation.h"

@interface MHFQueueOperation : MHFAsyncOperation

// You can add directly to the queue if you want an operation to not be run after last.
@property (strong, readonly) NSOperationQueue* operationQueue;

// add your methods to the queue then call super to unsuspend the queue.
-(void)performAsyncOperation NS_REQUIRES_SUPER;

@end
