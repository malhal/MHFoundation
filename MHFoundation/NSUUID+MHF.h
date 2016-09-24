//
//  NSUUID+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 05/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSUUID (MHF)

// note this requires a case-sensitive database column.
- (NSString *)mhf_URLSafeBase64String;

@end
