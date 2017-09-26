//
//  NSProcessInfo+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 25/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSProcessInfo (MHF)

@property (copy, readonly) NSDictionary *mhf_operationSystemVersionDictionary;

@end
