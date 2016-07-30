//
//  MHFDefines.h
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

// Tweak class clash safety, when using in a tweak define MHFOUNDATION_PREFIX_TO_ADD as the tweak name in caps.
#if !defined(MHFOUNDATION_ADD_PREFIX) && defined(MHFOUNDATION_PREFIX_TO_ADD)
    #define __MHFOUNDATION_PASTE__(a, b) a ## _ ## b
    #define __MHFOUNDATION_ADD_PREFIX_IMPL__(a, b) __MHFOUNDATION_PASTE__(a, b)
    #define MHFOUNDATION_ADD_PREFIX(name) __MHFOUNDATION_ADD_PREFIX_IMPL__(MHFOUNDATION_PREFIX_TO_ADD, name)

// Classes
    #define MHFSerialQueueAsyncOperation MHFOUNDATION_ADD_PREFIX(MHFSerialQueueAsyncOperation)
    #define MHFRunLoopOperation MHFOUNDATION_ADD_PREFIX(MHFRunLoopOperation)
    #define MHFAsyncOperation MHFOUNDATION_ADD_PREFIX(MHFAsyncOperation)

// NSDictionary+MHF
    #define mhf_allKeysSet MHFOUNDATION_ADD_PREFIX(mhf_allKeysSet)
    #define mhf_unflattenDictionary MHFOUNDATION_ADD_PREFIX(mhf_unflattenDictionary)

// NSArray+MHF
    #define mhf_asyncEnumerateObjectsUsingBlock MHFOUNDATION_ADD_PREFIX(mhf_asyncEnumerateObjectsUsingBlock)

// NSOperationQueue+MHF
    #define mhf_addOperationAfterLast MHFOUNDATION_ADD_PREFIX(mhf_addOperationAfterLast)

#endif

