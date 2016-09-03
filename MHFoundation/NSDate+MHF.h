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

// e.g. "2014-11-14 17:47:33"
- (NSString *)mhf_MySQLString;

// for new MySQL TIMESTAMP(6) e.g. "2014-11-14 17:47:33.326594" that's 6 decimal places
- (NSString *)mhf_fractionalMySQLString;

// handles fractional and not e.g. "2014-11-14 17:47:33" and "2014-11-14 17:47:33.326594"
+ (NSDate *)mhf_dateFromMySQLString:(NSString *)utcString;

@end
