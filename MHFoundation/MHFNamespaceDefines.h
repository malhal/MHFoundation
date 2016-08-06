//
//  MHFNamespaceDefines.h
//  MHFoundation
//
//  Generated using MHNamespaceGenerator on 07/08/2016
//

#if !defined(__MHFOUNDATION_NS_SYMBOL) && defined(MHFOUNDATION_NAMESPACE)
    #define __MHFOUNDATION_NS_REWRITE(ns, symbol) ns ## _ ## symbol
    #define __MHFOUNDATION_NS_BRIDGE(ns, symbol) __MHFOUNDATION_NS_REWRITE(ns, symbol)
    #define __MHFOUNDATION_NS_SYMBOL(symbol) __MHFOUNDATION_NS_BRIDGE(MHFOUNDATION_NAMESPACE, symbol)
// Classes
    #define MHFAsyncOperation __MHFOUNDATION_NS_SYMBOL(MHFAsyncOperation)
    #define MHFQueueOperation __MHFOUNDATION_NS_SYMBOL(MHFQueueOperation)
    #define MHFRunLoopOperation __MHFOUNDATION_NS_SYMBOL(MHFRunLoopOperation)
    #define MHFSerialQueueOperation __MHFOUNDATION_NS_SYMBOL(MHFSerialQueueOperation)
// Categories
    #define mhf_allKeysSet __MHFOUNDATION_NS_SYMBOL(mhf_allKeysSet)
    #define mhf_asyncEnumerateObjectsUsingBlock __MHFOUNDATION_NS_SYMBOL(mhf_asyncEnumerateObjectsUsingBlock)
    #define mhf_errorWithDomain __MHFOUNDATION_NS_SYMBOL(mhf_errorWithDomain)
    #define mhf_isEarlierThan __MHFOUNDATION_NS_SYMBOL(mhf_isEarlierThan)
    #define mhf_isEarlierThanOrEqualTo __MHFOUNDATION_NS_SYMBOL(mhf_isEarlierThanOrEqualTo)
    #define mhf_isLaterThan __MHFOUNDATION_NS_SYMBOL(mhf_isLaterThan)
    #define mhf_isLaterThanOrEqualTo __MHFOUNDATION_NS_SYMBOL(mhf_isLaterThanOrEqualTo)
    #define mhf_unflattenDictionary __MHFOUNDATION_NS_SYMBOL(mhf_unflattenDictionary)
// Externs
    #define MHFoundationErrorDomain __MHFOUNDATION_NS_SYMBOL(MHFoundationErrorDomain)
    #define MHFoundationVersionNumber __MHFOUNDATION_NS_SYMBOL(MHFoundationVersionNumber)
    #define MHFoundationVersionString __MHFOUNDATION_NS_SYMBOL(MHFoundationVersionString)
#endif
