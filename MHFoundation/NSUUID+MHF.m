//
//  NSUUID+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 05/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSUUID+MHF.h"

@implementation NSUUID (MHF)

- (NSString *)mhf_base64String{
    uuid_t bytes;
    [self getUUIDBytes:bytes];
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)];
    // Convert the byte string to a base64 string
    
    // wont bother with ios 6 compat since it doesnt even have blocks.
    //     if([data respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
    NSString* s = [data base64EncodedStringWithOptions:0];
    //     }else{
    //         s = [data base64Encoding];
    //     }
    // Replace the "/" and "+" for URL compatibility
    s = [s stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    s = [s stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    // remove trailing ==
    //s = [s substringToIndex:s.length - 2];
    s = [s stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return s;
}

@end
