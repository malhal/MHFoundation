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

- (instancetype)initWithURLRequest:(nullable NSURLRequest *)request bodyJSONDictionary:(nullable NSDictionary *)bodyJSONDictionary;

@property (nonatomic, copy, nullable) NSDictionary *bodyJSONDictionary;
@property (nonatomic, copy, nullable) NSURLRequest *request;
// if no session is set, a new epheremal session is created.
@property (nonatomic, strong, nullable) NSURLSession* session;

// responseJSONDictionary is nil if there is an error.
// if there is a error http status code then the error will contain the JSONDictionary.
@property (nonatomic, copy, nullable) void (^RESTCompletionBlock)(NSDictionary * __nullable responseJSONDictionary, NSHTTPURLResponse * __nullable response, NSError * __nullable error);

@end

NS_ASSUME_NONNULL_END