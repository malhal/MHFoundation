//
//  NSDictionary+MAL.h
//  MALFoundation
//
//  Created by Malcolm Hall on 23/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MALFoundation/MALFoundationDefines.h>

#define mal_allKeysSet MALFOUNDATION_ADD_PREFIX(mal_allKeysSet)
#define mal_unflattenDictionary MALFOUNDATION_ADD_PREFIX(mal_unflattenDictionary)

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (MH)

@property (readonly, copy) NSArray<KeyType> *mal_allKeysSet;

// when fetching related data from core data using NSDictionaryResultType the dictionary keys are flat key paths
// e.g. {app.bundleIdentifier : ...} instead of {app : {bundleIdentifier : ...}}
// this method converts the flat keys into nested dictionaries.
@property (readonly, copy) NSDictionary<KeyType, ObjectType> *mal_unflattenDictionary;

//- (NSArray<ObjectType> *)mal_objectsForKnownKeys:(NSArray<KeyType> *)keys;

@end
