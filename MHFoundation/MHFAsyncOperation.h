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
// a default completion block, usually replaced by subclasses with a block that includes params.
// The [NSOperation completionBlock] will also be called if both are set.
@property (nonatomic, copy, nullable) void (^asyncOperationCompletionBlock)(NSError * __nullable operationError);

@end


NS_ASSUME_NONNULL_END
