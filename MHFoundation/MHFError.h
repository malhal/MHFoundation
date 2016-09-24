//
//  MHFoundationErrors.h
//  MHFoundation
//
//  Created by Malcolm Hall on 12/06/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

MHFOUNDATION_EXTERN NSString * const MHFoundationErrorDomain;

MHFOUNDATION_EXTERN NSString * const MHFPartialErrorsByItemIDKey;

typedef NS_ENUM(NSInteger, MHFErrorCode) {
    MHFErrorUnknown                = 1,  /* Unknown or generic error */
    MHFErrorOperationCancelled     = 2,  /* A MHF operation was explicitly cancelled */
    MHFErrorInvalidArguments       = 3,  /* Things needed were not set */
    MHFErrorPartialFailure         = 4   /* Some items failed, but the operation succeeded overall */
};

NS_ASSUME_NONNULL_END