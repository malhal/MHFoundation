//
//  MHFHTTPError.h
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

MHFOUNDATION_EXTERN NSString * const MHFHTTPErrorDomain;

@interface MHFHTTPError : NSError

// adds a description to the userInfo using the statusCode.
- (instancetype)initWithStatusCode:(NSInteger)statusCode userInfo:(NSDictionary*)userInfo;
+ (instancetype)HTTPErrorWithStatusCode:(NSInteger)statusCode userInfo:(NSDictionary*)userInfo;

@end

NS_ASSUME_NONNULL_END