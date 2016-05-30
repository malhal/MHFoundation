//
//  MHFoundationDefines.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/05/2016.
//
//

#import <Foundation/Foundation.h>

#ifndef MHFOUNDATION_EXTERN
    #ifdef __cplusplus
        #define MHFOUNDATION_EXTERN   extern "C" __attribute__((visibility ("default")))
    #else
        #define MHFOUNDATION_EXTERN   extern __attribute__((visibility ("default")))
    #endif
#endif

// Tweak class clash safety, when using in a tweak define MHDATA_PREFIX_TO_ADD as the tweak name in caps.
#ifndef MHDATA_ADD_PREFIX
#ifdef MHDATA_PREFIX_TO_ADD
#define __MHDATA_PASTE__(a, b) a ## _ ## b
#define __MHDATA_ADD_PREFIX_IMPL__(a, b) __MHDATA_PASTE__(a, b)
#define MHDATA_ADD_PREFIX(name) __MHDATA_ADD_PREFIX_IMPL__(MHDATA_PREFIX_TO_ADD, name)
#else
#define MHDATA_ADD_PREFIX(name) name
#endif
#endif

NS_ASSUME_NONNULL_BEGIN

MHFOUNDATION_EXTERN NSString * const MHFoundationErrorDomain;

NS_ASSUME_NONNULL_END