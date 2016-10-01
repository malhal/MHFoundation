//
//  MHFRESTOperation_Internal.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Dynamically Loaded. All rights reserved.
//

#import <MHFoundation/MHFRESTOperation.h>

@interface MHFRESTOperation()

@property (nonatomic, strong) NSData *HTTPBody;

@property (nonatomic, strong) id JSONObject;

@property (nonatomic, strong) NSHTTPURLResponse *response;

- (BOOL)validateResponse:(NSHTTPURLResponse *)response JSONObject:(id)JSONObject error:(NSError **)error;

@end