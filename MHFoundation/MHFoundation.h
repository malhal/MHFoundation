//
//  MHFoundation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 07/06/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for MHFoundation.
FOUNDATION_EXPORT double MHFoundationVersionNumber;

//! Project version string for MHFoundation.
FOUNDATION_EXPORT const unsigned char MHFoundationVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MHFoundation/PublicHeader.h>
#import <MHFoundation/MHFDefines.h>
#import <MHFoundation/MHFError.h>

#import <MHFoundation/NSDictionary+MHF.h>
#import <MHFoundation/NSArray+MHF.h>
#import <MHFoundation/NSError+MHF.h>
#import <MHFoundation/NSDate+MHF.h>
#import <MHFoundation/NSMutableURLRequest+MHF.h>
#import <MHFoundation/NSURLSessionDataTask+MHF.h>
#import <MHFoundation/NSURLSession+MHF.h>
#import <MHFoundation/NSUUID+MHF.h>

#import <MHFoundation/MHFSerialQueueOperation.h>
#import <MHFoundation/MHFRunLoopOperation.h>
#import <MHFoundation/MHFAsyncOperation.h>
#import <MHFoundation/MHFURLSessionTaskOperation.h>