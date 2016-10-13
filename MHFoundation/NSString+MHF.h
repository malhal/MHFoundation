//
//  NSString+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MHF)

- (NSString *)mhf_URLEncodedString;

@end

NS_ASSUME_NONNULL_END