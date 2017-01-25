//
//  MHFAsyncOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

/*
 MHFAsyncOperation is a generic operation base class that works asyncronously.  It has methods that are called
 when an operation begins and ends.
 
 Subclasses can override -performAsyncOperation to call their custom async methods, then call finishWithError when done.
 */

@interface MHFAsyncOperation : NSOperation

// Convenience generic completion block. See private header for how to implement custom completion blocks.
// a default completion block, usually replaced by subclasses with a block that includes params.
// The [NSOperation completionBlock] will also be called if both are set.
@property (nonatomic, copy, nullable) void (^asyncOperationCompletionBlock)(NSError * __nullable operationError);

// Begin the async methods. Only called if asyncOperationShouldRun returns true.
// Call finishWithError from the async methods completion handler.
// Should not be called directly.
- (void)performAsyncOperation;

// Call from async completion handlers to end the operation.
// Override to do any custom clean-up, then call super.
// Must not be called directly from performAsyncOperation.
- (void)finishWithError:(NSError * __nullable)error NS_REQUIRES_SUPER;

// Called before the operation is performed, if a required property is not set set the error and return NO.
// Should not be called directly.
- (BOOL)asyncOperationShouldRun:(NSError**)error NS_REQUIRES_SUPER;

// Override to call custom completion blocks, then call super last (since this is tear down).
// Should not be called directly.
- (void)finishOnCallbackQueueWithError:(nullable NSError *)error NS_REQUIRES_SUPER;

// Call to invoke something on the callback queue, like a call to progress block.
- (void)performBlockOnCallbackQueue:(dispatch_block_t)block;

@end


NS_ASSUME_NONNULL_END
