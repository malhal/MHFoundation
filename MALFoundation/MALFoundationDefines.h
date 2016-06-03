//
//  MALFoundationDefines.h
//  MALFoundation
//
//  Created by Malcolm Hall on 19/05/2016.
//
//

#import <Foundation/Foundation.h>

#ifndef MALFOUNDATION_EXTERN
    #ifdef __cplusplus
        #define MALFOUNDATION_EXTERN   extern "C" __attribute__((visibility ("default")))
    #else
        #define MALFOUNDATION_EXTERN   extern __attribute__((visibility ("default")))
    #endif
#endif

// Tweak class clash safety, when using in a tweak define MALDATA_PREFIX_TO_ADD as the tweak name in caps.
#ifndef MALFOUNDATION_ADD_PREFIX
#ifdef MALFOUNDATION_PREFIX_TO_ADD
#define __MALFOUNDATION_PASTE__(a, b) a ## _ ## b
#define __MALFOUNDATION_ADD_PREFIX_IMPL__(a, b) __MALFOUNDATION_PASTE__(a, b)
#define MALFOUNDATION_ADD_PREFIX(name) __MALFOUNDATION_ADD_PREFIX_IMPL__(MALFOUNDATION_PREFIX_TO_ADD, name)
#else
#define MALFOUNDATION_ADD_PREFIX(name) name
#endif
#endif

NS_ASSUME_NONNULL_BEGIN

MALFOUNDATION_EXTERN NSString * const MALFoundationErrorDomain;

NS_ASSUME_NONNULL_END