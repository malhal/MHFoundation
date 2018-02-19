//
//  MHFObserver.m
//  MHFoundation
//
//  Created by Malcolm Hall on 19/02/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MHFObserver.h"

static void * const kObserverContext = (void *)&kObserverContext;

@implementation MHFObserver

- (void)setObject:(id)object{
    if(_object != object) {
        if(_object){
            [self removeObserversForObject:_object];
        }
        if(object){
            [self addObserversForObject:object];
        }
        _object = object;
        [self objectChanged];
    }
}

- (void)objectChanged{
    [self.delegate observerObjectChanged:self];
}

- (void)setKeysToObserve:(NSArray<NSString *> *)keysToObserve{
    if(_keysToObserve != keysToObserve){
        if(_keysToObserve){
            for(NSString *key in _keysToObserve){
                [self.object removeObserver:self forKeyPath:key];
            }
        }
        if(keysToObserve){
            for(NSString *key in keysToObserve){
                [self.object addObserver:self forKeyPath:key options:0 context:kObserverContext];
            }
        }
        _keysToObserve = keysToObserve;
    }
}

- (void)removeObserversForObject:(id)object{
    for(NSString *key in self.keysToObserve){
        [self.object addObserver:self forKeyPath:key options:0 context:kObserverContext];
    }
}

- (void)addObserversForObject:(id)object{
    for(NSString *key in self.keysToObserve){
        [self.object removeObserver:self forKeyPath:key];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if(context != kObserverContext){
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    [self objectChanged];
}

- (void)dealloc
{
    self.object = nil;
}

@end
