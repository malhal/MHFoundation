//
//  MHFBatchRESTOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>
#import <MHFoundation/MHFRESTOperation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFBatchRESTOperation : MHFRESTOperation

- (instancetype)init NS_DESIGNATED_INITIALIZER;

// each request in the batch should have a mhf_JSONBody that is an NSDictionary
// the url should be the path under http://host/api/ e.g. venue
- (instancetype)initWithURLRequest:(nullable NSURLRequest *)request batchRequests:(nullable NSArray <NSURLRequest *> *)batchRequests;

@property (nonatomic, copy, nullable) NSArray <NSURLRequest *> *batchRequests;

// Determines whether the batch should fail atomically or not. YES by default.
@property (nonatomic, assign) BOOL atomic;

/* Called on success or failure for each request in the batch. The callback is called in order of the batch requests. */
@property (nonatomic, copy, nullable) void (^perRequestCompletionBlock)(NSURLRequest *request, NSDictionary * __nullable JSON, NSHTTPURLResponse * __nullable response, NSError * __nullable error);

@property (nonatomic, copy, nullable) void (^batchCompletionBlock)(NSError * __nullable error);

@end

//@interface NSURLRequest (MHFBatchRESTOperation)
//
//@property (nullable, copy, setter=mhf_setIdentifier:) id mhf_identifier;
//
//@end

NS_ASSUME_NONNULL_END