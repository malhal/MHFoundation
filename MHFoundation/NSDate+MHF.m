//
//  NSDate+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 23/07/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSDate+MHF.h"

@implementation NSDate (MHF)

- (BOOL)mhf_isLaterThanOrEqualToDate:(NSDate*)date {
    return [self compare:date] != NSOrderedAscending;
}

- (BOOL)mhf_isEarlierThanOrEqualToDate:(NSDate*)date {
    return [self compare:date] != NSOrderedDescending;
}

- (BOOL)mhf_isLaterThanDate:(NSDate*)date {
    return [self compare:date] == NSOrderedDescending;
}

- (BOOL)mhf_isEarlierThanDate:(NSDate*)date {
    return [self compare:date] == NSOrderedAscending;
}

//used to send a utc date to the server.
- (NSString*)mhf_MySQLString{
    static NSDateFormatter *df = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [[NSDateFormatter alloc] init];
        [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        // [df setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSS"]; can't use this because three S's
        // is the maximum and rest are 0, e.g. 1415986217.544384 with six S's becomes .544000
        // so missing some of the fraction.
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
    });
    return [df stringFromDate:self];
}

- (NSString*)mhf_fractionalMySQLString{
    double d = [self timeIntervalSince1970];
    d = d - floor(d); // extract fraction
    d*=1000000; // convert to micros
    d = round(d);
    return [NSString stringWithFormat:@"%@.%06d", [self mhf_MySQLString], (int)d];
}

//used for dates from the server
+(NSDate*)mhf_dateFromMySQLString:(NSString *)utcString{
    if(!utcString){
        return nil;
    }
    static NSDateFormatter *df = nil;
    if (df == nil) {
        df = [[NSDateFormatter alloc] init];
        [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // @"yyyy-MM-dd HH:mm:ss.SSSSSS" More than 3 'S' not supported see below.
        [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    
    // overcome NSDateFormatter limitation that has a max three S, since we have six microseconds need to parse manually.
    NSArray* parts = [utcString componentsSeparatedByString:@"."];
    NSDate *utcDate = [df dateFromString:parts[0]];
    if(parts.count > 1){
        double microseconds = [parts[1] doubleValue];
        utcDate = [utcDate dateByAddingTimeInterval: microseconds / 1000000];
    }
    //should be nil if it failed to parse
    return utcDate;
}

@end
