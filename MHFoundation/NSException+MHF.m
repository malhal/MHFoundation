//
//  NSException+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 18/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "NSException+MHF.h"

// todo: get this name into the string with a macro.
//NSString * const MHFNotImplementedException = @"";

@implementation NSException (MHF)

+ (NSException *)mhf_notImplementedException{
    return [NSException exceptionWithName:@"NotImplementedException" reason:[[NSThread callStackSymbols] description] userInfo:nil];
}

+ (NSException *)mhf_abstractException{
    return [NSException exceptionWithName:@"AbstractException" reason:[[NSThread callStackSymbols] description] userInfo:nil];
}

@end
