//
//  MHFAsyncOperation_Private.h
//  MHFoundation
//
//  Created by Malcolm Hall on 03/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFAsyncOperation.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHFAsyncOperation ()

// Call from async completion handlers to end the operation. Must not be called directly from performAsyncOperation.
// Override to do any custom clean-up, then call super.
- (void)finishWithError:(NSError * __nullable)error NS_REQUIRES_SUPER;

// Override to call custom completion blocks, then call super.
- (void)finishOnCallbackQueueWithError:(NSError * __nullable)error NS_REQUIRES_SUPER;

// Use for custom progress blocks.
- (void)performBlockOnCallbackQueue:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END