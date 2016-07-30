//
//  NSError+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 30/07/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSError (MHF)

+ (instancetype)mhf_errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString*)description;

+ (instancetype)mhf_errorWithDomain:(NSString *)domain code:(NSInteger)code descriptionFormat:(NSString*)descriptionFormat arguments:(va_list)arguments NS_FORMAT_FUNCTION(3,0);

+ (instancetype)mhf_errorWithDomain:(NSString *)domain code:(NSInteger)code descriptionFormat:(NSString*)descriptionFormat, ... NS_FORMAT_FUNCTION(3,4);

@end
