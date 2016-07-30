//
//  MHFDefines.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/05/2016.
//
//

#import <MHFoundation/MHFNamespaceDefines.h>

#ifndef MHFOUNDATION_EXTERN
    #ifdef __cplusplus
        #define MHFOUNDATION_EXTERN   extern "C" __attribute__((visibility ("default")))
    #else
        #define MHFOUNDATION_EXTERN   extern __attribute__((visibility ("default")))
    #endif
#endif