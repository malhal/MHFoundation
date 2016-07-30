//
//  NSDate+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 23/07/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSDate (MHF)

- (BOOL)mhf_isLaterThanOrEqualTo:(NSDate*)date;

- (BOOL)mhf_isEarlierThanOrEqualTo:(NSDate*)date;

- (BOOL)mhf_isLaterThan:(NSDate*)date;

- (BOOL)mhf_isEarlierThan:(NSDate*)date;

@end
