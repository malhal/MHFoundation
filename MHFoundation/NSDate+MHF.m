//
//  NSDate+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 23/07/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSDate+MHF.h"

@implementation NSDate (MHF)

- (BOOL)mhf_isLaterThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedAscending);
}

- (BOOL)mhf_isEarlierThanOrEqualTo:(NSDate*)date {
    return !([self compare:date] == NSOrderedDescending);
}
- (BOOL)mhf_isLaterThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedDescending);
    
}
- (BOOL)mhf_isEarlierThan:(NSDate*)date {
    return ([self compare:date] == NSOrderedAscending);
}

@end
