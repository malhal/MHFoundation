//
//  MHFRESTOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//
//  Best practice is to use dictionaries with REST so we enforce that here.

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>
#import <MHFoundation/MHFSerialQueueOperation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFRESTOperation : MHFSerialQueueOperation

// Supply a request that has a URL and a method.
// The request must have a JSONBody set using the category, it must only contain
// items that can be converted to JSON otherwise it will complete with error if cannot encode.
// The request will have contents and accept set to JSON.
- (instancetype)initWithURLRequest:(nullable NSURLRequest *)request;

@property (nonatomic, copy, nullable) NSURLRequest *request;
// if no session is set, a new epheremal session is created.
@property (nonatomic, strong, nullable) NSURLSession* session;

// responseJSONDictionary is nil if there is an error.
// If there is a http status error then the error will contain the error dictionary as the userInfo.
// If the error is MHFErrorPartialFailure, the error's userInfo dictionary contains
// a dictionary of requests to errors keyed off of MHFPartialErrorsByItemIDKey.
@property (nonatomic, copy, nullable) void (^RESTCompletionBlock)(NSDictionary* __nullable JSON, NSHTTPURLResponse * __nullable response, NSError * __nullable error);

@end

@interface NSURLRequest (MHFRESTOperation)

@property (nullable, copy, setter=mhf_setJSONBody:) id mhf_JSONBody;

@end

NS_ASSUME_NONNULL_END