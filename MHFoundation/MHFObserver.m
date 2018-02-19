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
    _object = object;
    if(object){
        [self addObserversForObject:object];
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
        [self.object addObserver:self forKeyPath:key options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:kObserverContext];
    }
    _keyPaths = keyPaths;
}

- (void)addObserversForObject:(id)object{
    for(NSString *key in self.keyPaths){
        [self.object addObserver:self forKeyPath:key options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:kObserverContext];
    }
}

- (void)removeObserversForObject:(id)object{
    for(NSString *key in self.keyPaths){
        [self.object removeObserver:self forKeyPath:key context:kObserverContext];
    }
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    if(context != kObserverContext){
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    else if([change[NSKeyValueChangeNewKey] isEqual:change[NSKeyValueChangeOldKey]]){
        return;
    }
    [self objectChangedKeyPath:keyPath];
}

- (void)dealloc
{
    self.object = nil;
}

@end
