//
//  NSHTTPURLResponse+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSHTTPURLResponse (MHF)

- (BOOL)mhf_isSuccessful;

- (NSError *)mhf_HTTPErrorWithUserInfo:(NSDictionary *)userInfo;

@end
