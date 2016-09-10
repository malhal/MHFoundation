//
//  MHFHTTPError.m
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFHTTPError.h"

NSString * const MHFHTTPErrorDomain = @"MHFHTTPErrorDomain";

@implementation MHFHTTPError

- (instancetype)initWithStatusCode:(NSInteger)statusCode userInfo:(NSDictionary*)userInfo{
    NSMutableDictionary* dict;
    if(userInfo){
        dict = userInfo.mutableCopy;
    }else{
        dict = [NSMutableDictionary dictionary];
    }
    dict[NSLocalizedDescriptionKey] = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
    return [super initWithDomain:MHFHTTPErrorDomain code:statusCode userInfo:dict];
}

+ (instancetype)HTTPErrorWithStatusCode:(NSInteger)statusCode userInfo:(NSDictionary*)userInfo{
    return [[MHFHTTPError alloc] initWithStatusCode:statusCode userInfo:userInfo];
}

@end
