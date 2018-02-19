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
    if(_object == object) {
        return;
    }
    else if(_object){
        [self removeObserversForObject:_object];
    }
    if(object){
        [self addObserversForObject:object];
    }
    _object = object;
    [self objectChanged];
}

- (void)setOptions:(NSKeyValueObservingOptions)options{
    if(_options == options){
        return;
    }
    _options = options;
    if(self.object){
        [self removeObserversForObject:self.object];
        [self addObserversForObject:self.object];
    }
}

- (void)objectChanged{
    [self.delegate observerObjectChanged:self];
}

- (void)setKeysToObserve:(NSArray<NSString *> *)keysToObserve{
    if(_keysToObserve == keysToObserve){
        return;
    }
    else if(_keysToObserve){
        for(NSString *key in _keysToObserve){
            [self.object removeObserver:self forKeyPath:key];
        }
    }
    for(NSString *key in keysToObserve){
        [self.object addObserver:self forKeyPath:key options:self.options context:kObserverContext];
    }
    _keysToObserve = keysToObserve;
}

- (void)removeObserversForObject:(id)object{
    for(NSString *key in self.keysToObserve){
        [self.object addObserver:self forKeyPath:key options:self.options context:kObserverContext];
    }
}

- (void)addObserversForObject:(id)object{
    for(NSString *key in self.keysToObserve){
        [self.object removeObserver:self forKeyPath:key];
    }
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
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
