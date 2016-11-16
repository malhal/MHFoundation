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

// This class is intended to be subclassed.

@interface MHFAsyncOperation : NSOperation

// Convenience generic completion block. See private header for how to implement custom completion blocks.
// The [NSOperation completionBlock] will also be called if both are set.
@property (nonatomic, copy, nullable) void (^asyncOperationCompletionBlock)(NSError * __nullable operationError);

// Override and return NO and set the error if custom initialization fails meaning the async operation cannot be performed.
// Either call super before or after depending on how you would like to design your subclass inheritance.
// This can also be used to configure a super class's properties.
- (BOOL)asyncOperationShouldRun:(NSError**)error;

// Override to perform the async methods. Only called if asyncOperationShouldRun returns true.
// Call finishWithError from the async methods completion handler.
- (void)performAsyncOperation;

// Call from async completion handlers to end the operation. Must not be called directly from performAsyncOperation.
// Override to do any custom clean-up, then call super.
- (void)finishWithError:(NSError * __nullable)error NS_REQUIRES_SUPER;

// Override to call custom completion blocks, then call super last, since this is tearing down.
- (void)finishOnCallbackQueueWithError:(nullable NSError *)error NS_REQUIRES_SUPER;

// Use for custom progress blocks.
- (void)performBlockOnCallbackQueue:(dispatch_block_t)block;

@end

NS_ASSUME_NONNULL_END