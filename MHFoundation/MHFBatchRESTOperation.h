//
//  MHFBatchRESTOperation.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Dynamically Loaded. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>
#import <MHFoundation/MHFRESTOperation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFBatchRESTOperation : MHFRESTOperation

- (instancetype)init NS_DESIGNATED_INITIALIZER;

// each batchRequest should have a mhf_JSONBody that is an NSDictionary
// the url should be the path under http://host/api/ e.g. venue
- (instancetype)initWithURLRequest:(nullable NSURLRequest *)request batchRequests:(nullable NSArray <NSURLRequest *> *)batchRequests;

@property (nonatomic, copy, nullable) NSArray <NSURLRequest *> *batchRequests;

// Determines whether the batch should fail atomically or not. YES by default.
@property (nonatomic, assign) BOOL atomic;

/* Called on success or failure for each response in the batch. */
@property (nonatomic, copy, nullable) void (^perResponseBlock)(NSDictionary * __nullable JSON, NSHTTPURLResponse * __nullable response, NSError * __nullable error);

@end

NS_ASSUME_NONNULL_END