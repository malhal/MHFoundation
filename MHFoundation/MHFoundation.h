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
#import <MHFoundation/MHFoundationDefines.h>
#import <MHFoundation/MHFoundationErrors.h>

#import <MHFoundation/NSDictionary+MHF.h>
#import <MHFoundation/NSArray+MHF.h>
#import <MHFoundation/NSOperationQueue+MHF.h>

#import <MHFoundation/MHFSerialQueueAsyncOperation.h>
#import <MHFoundation/MHFRunLoopOperation.h>
#import <MHFoundation/MHFAsyncOperation.h>