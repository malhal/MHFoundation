//
//  NSURLRequest+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 02/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (MHF)

-(void)mhf_setJSONObject:(id)JSONObject error:(NSError**)error;

-(void)mhf_postMethod;

-(void)mhf_gzipBody;

@end
