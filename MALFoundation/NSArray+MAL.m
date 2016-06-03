//
//  NSArray+MAL.m
//  MALFoundation
//
//  Created by Malcolm Hall on 04/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSArray+MAL.h"

@implementation NSArray (MAL)

- (void)mal_asyncEnumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL isLast, dispatch_block_t next))block{
    __block NSUInteger index = 0;
    
    void (^next)();
    __block __weak typeof(next) weakNext;
    weakNext = next = ^void() {
        void (^strongNext)() = weakNext;
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

@end
