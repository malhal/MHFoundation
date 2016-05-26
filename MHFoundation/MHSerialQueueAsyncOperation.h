//
//  MHQueueAsyncOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHAsyncOperation.h"

@interface MHSerialQueueAsyncOperation : MHAsyncOperation

// Do not add operations directly to the queue, instead use addQueueOperation
//@property (strong, readonly) NSOperationQueue* operationQueue;

// the operation that is dependent on all other operations on the queue. Dependencies are added when operation starts.
// exposed here for adding dependencies after the operation has started.
//@property (strong, readonly) MHAsyncOperation* finishedOperation;

// adds an operation to the queue and adds a dependency on queueFinishedOperation.
-(void)addOperation:(NSOperation*)op;

// calling super adds the finished operation to the queue, call first.
-(void)performAsyncOperation NS_REQUIRES_SUPER;

@end
