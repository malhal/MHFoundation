//
//  NSURLRequest+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 02/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (MHF)

// Sets the content type to application/json, json encodes the object, returning an error if fails, and sets it on the HTTPBody
// Also sets method to POST.
-(BOOL)mhf_setBodyJSONObject:(id)JSONObject error:(NSError**)error;

-(void)mhf_setMethodPOST;

-(void)mhf_setMethodPUT;

-(void)mhf_gzipBody;

-(void)mhf_setAcceptJSON;

-(void)mhf_setContentTypeJSON;

-(void)mhf_setBasicAuthWithUsername:(NSString*)username password:(NSString*)password;

@end
