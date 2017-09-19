//
//  NSArray+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 04/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (MHF)

// Enumerates each object in an array and allows you to call an asyncronous method and call next when done.
// Next must be called from the same thread so that the index can be incrememnted safely.
// To stop just don't call next.
// Check isLast to see if it the last object.
- (void)mhf_asyncEnumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL isLast, dispatch_block_t next))block;

//- (void)mhf_asyncEnumerateBatchesUsingBlock:(void (^)(NSArray<ObjectType> *batch, NSUInteger idx, BOOL isLast, void (^nextBatch)(NSUInteger count)))block;

- (NSArray *)mhf_arrayByGroupingIntoArraysWithMaxCount:(NSUInteger)maxCount;

- (BOOL)mhf_containsObjectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate;

- (BOOL)mhf_indexIsValid:(NSUInteger)index;

//- (NSUInteger)mhf_indexOfSortedObject:(id)object insertionIndex:(out NSUInteger *)insertionIndex usingComparator:(NSComparator NS_NOESCAPE)cmptr;

- (id)mhf_objectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate;

//- (id)mhf_objectsOfClass:(Class)aClass;

- (NSArray *)mhf_objectsPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate;

@end

NS_ASSUME_NONNULL_END
