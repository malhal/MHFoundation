//
//  NSURLSessionDataTask+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 03/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLSessionDataTask (MHF)

+ (NSURLSessionDataTask *)mhf_stringTaskWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSString * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

// parses the JSON and does not allow fragments, i.e. must be an array or dictionary.
+ (NSURLSessionDataTask *)mhf_JSONTaskWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(id __nullable JSONObject, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

@end


NS_ASSUME_NONNULL_END