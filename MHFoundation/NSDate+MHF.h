//
//  NSDate+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 23/07/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MHF)

- (BOOL)isLaterThanOrEqualTo:(NSDate*)date;

- (BOOL)isEarlierThanOrEqualTo:(NSDate*)date;

- (BOOL)isLaterThan:(NSDate*)date;

- (BOOL)isEarlierThan:(NSDate*)date;

@end
