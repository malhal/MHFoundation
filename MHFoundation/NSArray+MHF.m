//
//  NSArray+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 04/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSArray+MHF.h"

@implementation NSArray (MHF)

- (void)mhf_asyncEnumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL isLast, dispatch_block_t next))block{
    __block NSUInteger index = 0;
    void (^next)(void);
    __block __weak typeof(next) weakNext;
    weakNext = next = ^void() {
        void (^strongNext)(void) = weakNext;
        // check if finished
        if(index == self.count){
            return;
        }
        id obj = self[index];
        index++;
        block(obj, index - 1, index == self.count, strongNext);
    };
    next();
}

- (NSArray *)mhf_arrayByGroupingIntoArraysWithMaxCount:(NSUInteger)maxCount{
    NSMutableArray *groups = NSMutableArray.new;
    NSMutableArray *group;
    for(id object in self){
        if(!group || group.count >= maxCount){
            group = [NSMutableArray.alloc initWithCapacity:maxCount];
        }
        [group addObject:object];
    }
    return groups;
}

- (BOOL)mhf_containsObjectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate{
    return [self mhf_objectPassingTest:predicate] != nil;
}

- (BOOL)mhf_indexIsValid:(NSUInteger)index{
    return index < self.count;
}

//- (NSUInteger)mhf_indexOfSortedObject:(id)object insertionIndex:(out NSUInteger *)insertionIndex usingComparator:(NSComparator NS_NOESCAPE)cmptr{
//}

- (id)mhf_objectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate{
    NSUInteger index = [self indexOfObjectPassingTest:predicate];
    if(index == NSNotFound){
        return nil;
    }
    return [self objectAtIndex:index];
}

//- (id)mhf_objectsOfClass:(Class)aClass{
//}

- (NSArray *)mhf_objectsPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate{
    NSIndexSet *set = [self indexesOfObjectsPassingTest:predicate];
    return [self objectsAtIndexes:set];
}

@end
