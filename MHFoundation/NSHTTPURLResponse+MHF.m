//
//  NSHTTPURLResponse+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSHTTPURLResponse+MHF.h"
#import "MHFHTTPError.h"

@implementation NSHTTPURLResponse (MHF)

- (BOOL)mhf_isSuccessful{
    return self.statusCode >= 200 && self.statusCode < 300;
}

- (NSError *)mhf_HTTPErrorWithUserInfo:(NSDictionary *)userInfo{
    return [MHFHTTPError HTTPErrorWithStatusCode:self.statusCode userInfo:userInfo];
}

@end
