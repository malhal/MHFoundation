//
//  NSException+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 18/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

//MHF_EXTERN NSString * const MHFNotImplementedException;

@interface NSException (MHF)

+ (NSException *)mhf_notImplementedException;
+ (NSException *)mhf_abstractException;
+ (NSException *)mhf_designatedInitializerException;
+ (void)mhf_crashThisApp;

@end

NS_ASSUME_NONNULL_END
