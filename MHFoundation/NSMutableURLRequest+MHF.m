//
//  NSMutableURLRequest+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 02/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSMutableURLRequest+MHF.h"
#import "MHFHTTP.h"

@implementation NSMutableURLRequest (MHF)

- (BOOL)mhf_setJSONObject:(id)JSONObject error:(NSError**)error{
    NSData* data = [NSJSONSerialization dataWithJSONObject:JSONObject options:0 error:error];
    if(!data){
        return NO;
    }
    self.HTTPBody = data;
    [self mhf_setContentTypeJSON];
    if([self.HTTPMethod isEqualToString:@"GET"]){
        [self mhf_setPOST];
    }
    return YES;
}

- (void)mhf_setAcceptJSON{
    [self setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

- (void)mhf_setContentTypeJSON{
    [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

// untested
- (void)mhf_setContentTypePropertyList{
    [self setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
}

- (void)mhf_setPOST{
    [self setHTTPMethod:MHFHTTPMethodPOST];
}

- (void)mhf_setPUT{
    [self setHTTPMethod:MHFHTTPMethodPUT];
}

- (void)mhf_contentEncodingGZIP{
    [self setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
}

- (void)mhf_setBasicAuthUsername:(NSString*)username password:(NSString*)password{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    [self setValue:authValue forHTTPHeaderField:@"Authorization"];
}

- (void)mhf_setAcceptGzip{
    [self addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
}

// untested
- (BOOL)mhf_setPropertyList:(id)propertyList error:(NSError**)error{
    NSString* errorString = nil;
    NSData* data = [NSPropertyListSerialization dataFromPropertyList:propertyList format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorString];
    if(!data){
        if(error){
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileReadCorruptFileError userInfo:[NSDictionary dictionaryWithObject:errorString forKey:NSLocalizedDescriptionKey]];
        }
        return NO;
    }
    self.HTTPBody = data;
    [self mhf_setContentTypePropertyList];
    if([self.HTTPMethod isEqualToString:@"GET"]){
        [self mhf_setPOST];
    }
    return YES;
    
    
}

@end
