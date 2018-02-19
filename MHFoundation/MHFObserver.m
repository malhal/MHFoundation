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
    for(NSString *keyPath in self.keyPaths){
        [self objectChangedKeyPath:keyPath];
    }
}

- (void)objectChangedKeyPath:(NSString *)keyPath{
    [self.delegate observer:self objectChangedKeyPath:keyPath];
}

- (void)setKeyPaths:(NSArray<NSString *> *)keyPaths{
    if(_keyPaths == keyPaths){
        return;
    }
    else if(_keyPaths){
        for(NSString *key in _keyPaths){
            [self.object removeObserver:self forKeyPath:key context:kObserverContext];
        }
    }
    for(NSString *key in keyPaths){
        [self.object addObserver:self forKeyPath:key options:0 context:kObserverContext];
    }
    _keyPaths = keyPaths;
}

- (void)removeObserversForObject:(id)object{
    for(NSString *key in self.keyPaths){
        [self.object addObserver:self forKeyPath:key options:0 context:kObserverContext];
    }
}

- (void)addObserversForObject:(id)object{
    for(NSString *key in self.keyPaths){
        [self.object removeObserver:self forKeyPath:key context:kObserverContext];
    }
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    if(context != kObserverContext){
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    [self objectChangedKeyPath:keyPath];
}

- (void)dealloc
{
    self.object = nil;
}

@end
