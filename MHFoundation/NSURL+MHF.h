//
//  NSURL+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 21/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (MHF)

+ (NSURL *)mhf_URLWithString:(NSString *)URLString query:(NSDictionary<NSString *, NSString *> *)query;

@end

NS_ASSUME_NONNULL_END