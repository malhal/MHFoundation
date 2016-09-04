//
//  NSMutableURLRequest+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 02/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSMutableURLRequest+MHF.h"
#import "NSData+GZIP.h"

@implementation NSMutableURLRequest (MHF)

-(BOOL)mhf_setJSONObject:(id)JSONObject error:(NSError**)error{
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

-(void)mhf_setAcceptJSON{
    [self setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

-(void)mhf_setContentTypeJSON{
    [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

-(void)mhf_setPOST{
    [self setHTTPMethod:@"POST"];
}

-(void)mhf_setPUT{
    [self setHTTPMethod:@"PUT"];
}

-(void)mhf_gzipBody{
    NSData* data = self.HTTPBody;
    [self setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
#ifdef DEBUG
    NSLog(@"Original length %ld",(unsigned long)data.length);
    NSLog(@"Compressing...");
#endif
    data = data.gzippedData;
#ifdef DEBUG
    NSLog(@"Compressed length %ld",(unsigned long)data.length);
#endif
    self.HTTPBody = data;
}

-(void)mhf_setBasicAuthUsername:(NSString*)username password:(NSString*)password{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    [self setValue:authValue forHTTPHeaderField:@"Authorization"];
}

@end
