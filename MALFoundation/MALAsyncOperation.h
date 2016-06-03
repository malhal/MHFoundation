//
//  MHAsyncOperation.h
//  MALFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MALAsyncOperation : NSOperation

// Override and return NO and set the error if custom initialization fails meaning the async operation cannot be performed.
- (BOOL)asyncOperationShouldRun:(NSError**)error;

// Override to perform the async methods. Only called if asyncOperationShouldRun returns true.
- (void)performAsyncOperation;

// Call from async completion handlers to end the operation. Must not be called directly from performAsyncOperation.
- (void)finishWithError:(NSError * __nullable)error;

// Use for custom progress blocks.
- (void)performBlockOnCallbackQueue:(dispatch_block_t)block;

@property (nonatomic, copy, nullable) void (^asyncOperationCompletionBlock)(NSError * __nullable operationError);

@end

@interface MALAsyncOperation (Private)

// Override to call custom completion blocks then call super last.
- (void)_finishOnCallbackQueueWithError:(NSError * __nullable)error NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END