//
//  NSArray+MH.h
//  MHFoundation
//
//  Created by Malcolm Hall on 04/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (MH)

// Enumerates each object in an array and allows you to call an asyncronous method and call next when done.
// Next must be called from the same thread so that the index can be incrememnted safely.
// To stop just don't call next.
// Check isLast to see if it the last object.
- (void)mh_asyncEnumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL isLast, dispatch_block_t next))block;

//- (void)mh_asyncEnumerateBatchesUsingBlock:(void (^)(NSArray<ObjectType> *batch, NSUInteger idx, BOOL isLast, void (^nextBatch)(NSUInteger count)))block;

@end

NS_ASSUME_NONNULL_END