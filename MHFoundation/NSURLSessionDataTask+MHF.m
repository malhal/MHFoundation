//
//  NSURLSessionDataTask+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 03/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSURLSessionDataTask+MHF.h"
#import "NSError+MHF.h"
#import "MHFError.h"

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

+ (NSURLSessionDataTask *)mhf_PropertyListTaskWithSession:(NSURLSession *)session request:(NSURLRequest *)request completionHandler:(void (^)(id __nullable propertyList, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler{
    return [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            completionHandler(nil, response, error);
            return;
        }
        id receivedPropertyList;
        // parse will fail if there is no data.
        if(data.length){
            NSString* parseErrorString = nil;
            receivedPropertyList = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:&parseErrorString];
            if(parseErrorString){
                NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:parseErrorString, NSLocalizedFailureReasonErrorKey, nil];
                error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadCorruptFileError userInfo:userInfo];
            }
        }
        completionHandler(receivedPropertyList, response, error);
    }];
}

@end
