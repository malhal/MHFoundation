//
//  MHFoundationErrors.m
//  MHFoundation
//
//  Created by Malcolm Hall on 12/06/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFError_Internal.h"
#import "NSDictionary+MHF.h"

NSString * const MHFoundationErrorDomain = @"MHFoundationErrorDomain";

NSString * const MHFPartialErrorsByItemIDKey = @"MHFPartialErrorsByItemIDKey";

@implementation MHFError

+ (instancetype)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)userInfo{
    // add the description using a workaround for NSError's description method not calling localizedDescription.
    if(!userInfo[NSLocalizedDescriptionKey]){
        NSString* description;
        switch (code) {
            case MHFErrorUnknown:
                description = @"unknown error";
                break;
            case MHFErrorOperationCancelled:
                description = @"operation cancelled";
                break;
            case MHFErrorInvalidArguments:
                description = @"invalid arguments";
                break;
            case MHFErrorPartialFailure:
                description = @"partial failure";
                break;
        }
        if(description){
            NSDictionary* descriptionDictionary = @{NSLocalizedDescriptionKey : description};
            if(userInfo){
                userInfo = [userInfo mhf_dictionaryByAddingEntriesFromDictionary:descriptionDictionary];
            }else{
                userInfo = descriptionDictionary;
            }
        }
    }
    return [self errorWithDomain:MHFoundationErrorDomain code:code userInfo:userInfo];
}

@end