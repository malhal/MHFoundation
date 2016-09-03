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

-(void)mhf_setJSONObject:(id)JSONObject error:(NSError**)error{
    NSData* data = [NSJSONSerialization dataWithJSONObject:JSONObject options:0 error:error];
    if(!data){
        return;
    }
    [self setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    self.HTTPBody = data;
}

-(void)mhf_postMethod{
    [self setHTTPMethod:@"POST"];
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

@end
