//
//  MHFAsyncOperation_Private.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 14/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFAsyncOperation.h>

NS_ASSUME_NONNULL_BEGIN

// the extensions in this header are to be used only by subclasses of MHFAsyncOperation
// code that uses MHFAsyncOperations must never call these

@interface MHFAsyncOperation (MHFAsyncOperationProtected)

// Called before the operation is performed, if a required property is not set set the error and return NO.
// Should not be called directly.
- (BOOL)asyncOperationShouldRun:(NSError**)error NS_REQUIRES_SUPER;

// Begin the async methods. Only called if asyncOperationShouldRun returns true.
// Call finishWithError from the async methods completion handler.
// Should not be called directly.
- (void)performAsyncOperation;

// Call from async completion handlers to end the operation. Must not be called directly from performAsyncOperation.
// Override to do any custom clean-up, then call super.
- (void)finishWithError:(NSError * __nullable)error NS_REQUIRES_SUPER;

// Override to call custom completion blocks, then call super last (since this is tear down).
// Should not be called directly.
- (void)finishOnCallbackQueueWithError:(nullable NSError *)error NS_REQUIRES_SUPER;

// Call to invoke something on the callback queue, like a call to progress block.
- (void)performBlockOnCallbackQueue:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END
