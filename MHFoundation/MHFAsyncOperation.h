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

@interface MHFAsyncOperation : NSOperation

// Override and return NO and set the error if custom initialization fails meaning the async operation cannot be performed.
- (BOOL)asyncOperationShouldRun:(NSError**)error;

// Override to perform the async methods. Only called if asyncOperationShouldRun returns true.
// Call finishWithError from the async methods completion handler.
- (void)performAsyncOperation;

@property (nonatomic, copy, nullable) void (^asyncOperationCompletionBlock)(NSError * __nullable operationError);

@end

NS_ASSUME_NONNULL_END