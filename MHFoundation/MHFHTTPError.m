//
//  MHFHTTPError.m
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFHTTPError.h"
#import "NSDictionary+MHF.h"

NSString * const MHFHTTPErrorDomain = @"MHFHTTPErrorDomain";

@implementation MHFHTTPError

- (instancetype)initWithStatusCode:(NSInteger)statusCode userInfo:(NSDictionary*)userInfo{
    // add a default description based on code if none exists.
    if(!userInfo[NSLocalizedDescriptionKey]){
        NSDictionary* descriptionDict = @{NSLocalizedDescriptionKey : [NSHTTPURLResponse localizedStringForStatusCode:statusCode]};
        if(userInfo){
            userInfo = [userInfo mhf_dictionaryByAddingEntriesFromDictionary:descriptionDict];
        }else{
            userInfo = descriptionDict;
        }
    }
    return [super initWithDomain:MHFHTTPErrorDomain code:statusCode userInfo:userInfo];
}

+ (instancetype)HTTPErrorWithStatusCode:(NSInteger)statusCode userInfo:(NSDictionary*)userInfo{
    return [[MHFHTTPError alloc] initWithStatusCode:statusCode userInfo:userInfo];
}

@end
