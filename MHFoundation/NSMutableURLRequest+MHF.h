//
//  NSURLRequest+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 02/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSMutableURLRequest (MHF)

// Sets the content type to application/json, json encodes the object, returning an error if fails, and sets it on the HTTPBody
// Also sets method to POST.
- (BOOL)mhf_setJSONObject:(id)JSONObject error:(NSError **)error;

- (void)mhf_setPOST;

- (void)mhf_setPUT;

// you must gzip the body too.
- (void)mhf_contentEncodingGZIP;

- (void)mhf_setAcceptJSON;

- (void)mhf_setContentTypeJSON;

- (void)mhf_setBasicAuthUsername:(NSString *)username password:(NSString *)password;

- (void)mhf_setAcceptGzip;

- (BOOL)mhf_setPropertyList:(id)propertyList error:(NSError**)error;

- (void)mhf_setContentTypePropertyList;

@end
