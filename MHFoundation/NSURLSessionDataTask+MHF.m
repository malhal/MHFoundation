//
//  NSURLSessionDataTask+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 03/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSURLSessionDataTask+MHF.h"

@implementation NSURLSessionDataTask (MHF)

+ (NSURLSessionDataTask *)mhf_stringTaskWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(NSString * __nullable string, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler{
    return [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            completionHandler(nil, response, error);
            return;
        }
        NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        completionHandler(string, response, error);
    }];
}

+ (NSURLSessionDataTask *)mhf_JSONTaskWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(id __nullable JSONObject, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler{
    return [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            completionHandler(nil, response, error);
            return;
        }
        id JSONObject;
        // parse will fail if there is no data.
        if(data.length){
            JSONObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        }
        completionHandler(JSONObject, response, error);
    }];
}

@end
