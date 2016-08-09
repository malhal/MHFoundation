//
//  MHFQueueOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 03/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>
#import <MHFoundation/MHFAsyncOperation.h>

@interface MHFQueueOperation : MHFAsyncOperation

- (void)addOperation:(NSOperation *)operation;

// add your methods to the queue then call super to unsuspend the queue.
- (void)performAsyncOperation NS_REQUIRES_SUPER;

@end
