//
//  NSDate+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 23/07/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSDate+MHF.h"

@implementation NSDate (MHF)

- (BOOL)isLaterThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedAscending);
}

- (BOOL)isEarlierThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedDescending);
}
- (BOOL)isLaterThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedDescending);
    
}
- (BOOL)isEarlierThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedAscending);
}

@end
