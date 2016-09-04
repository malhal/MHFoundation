//
//  MHFNamespaceDefines.h
//  MHFoundation
//
//  Generated using MHNamespaceGenerator on 04/09/2016
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
    #define MHFURLRequestOperation __MHFOUNDATION_NS_SYMBOL(MHFURLRequestOperation)
// Categories
    #define mhf_JSONTaskWithSession __MHFOUNDATION_NS_SYMBOL(mhf_JSONTaskWithSession)
    #define mhf_MySQLString __MHFOUNDATION_NS_SYMBOL(mhf_MySQLString)
    #define mhf_allKeysSet __MHFOUNDATION_NS_SYMBOL(mhf_allKeysSet)
    #define mhf_asyncEnumerateObjectsUsingBlock __MHFOUNDATION_NS_SYMBOL(mhf_asyncEnumerateObjectsUsingBlock)
    #define mhf_cancelAllTasks __MHFOUNDATION_NS_SYMBOL(mhf_cancelAllTasks)
    #define mhf_dateFromMySQLString __MHFOUNDATION_NS_SYMBOL(mhf_dateFromMySQLString)
    #define mhf_errorWithDomain __MHFOUNDATION_NS_SYMBOL(mhf_errorWithDomain)
    #define mhf_fractionalMySQLString __MHFOUNDATION_NS_SYMBOL(mhf_fractionalMySQLString)
    #define mhf_gzipBody __MHFOUNDATION_NS_SYMBOL(mhf_gzipBody)
    #define mhf_isEarlierThan __MHFOUNDATION_NS_SYMBOL(mhf_isEarlierThan)
    #define mhf_isEarlierThanOrEqualTo __MHFOUNDATION_NS_SYMBOL(mhf_isEarlierThanOrEqualTo)
    #define mhf_isLaterThan __MHFOUNDATION_NS_SYMBOL(mhf_isLaterThan)
    #define mhf_isLaterThanOrEqualTo __MHFOUNDATION_NS_SYMBOL(mhf_isLaterThanOrEqualTo)
    #define mhf_setAcceptJSON __MHFOUNDATION_NS_SYMBOL(mhf_setAcceptJSON)
    #define mhf_setBasicAuthWithUsername __MHFOUNDATION_NS_SYMBOL(mhf_setBasicAuthWithUsername)
    #define mhf_setBodyJSONObject __MHFOUNDATION_NS_SYMBOL(mhf_setBodyJSONObject)
    #define mhf_setContentTypeJSON __MHFOUNDATION_NS_SYMBOL(mhf_setContentTypeJSON)
    #define mhf_setMethodPOST __MHFOUNDATION_NS_SYMBOL(mhf_setMethodPOST)
    #define mhf_setMethodPUT __MHFOUNDATION_NS_SYMBOL(mhf_setMethodPUT)
    #define mhf_stringTaskWithSession __MHFOUNDATION_NS_SYMBOL(mhf_stringTaskWithSession)
    #define mhf_unflattenDictionary __MHFOUNDATION_NS_SYMBOL(mhf_unflattenDictionary)
// Externs
    #define MHFoundationErrorDomain __MHFOUNDATION_NS_SYMBOL(MHFoundationErrorDomain)
    #define MHFoundationVersionNumber __MHFOUNDATION_NS_SYMBOL(MHFoundationVersionNumber)
    #define MHFoundationVersionString __MHFOUNDATION_NS_SYMBOL(MHFoundationVersionString)
#endif
