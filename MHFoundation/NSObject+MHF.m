//
//  NSObject+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 30/10/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "NSObject+MHF.h"

#pragma clang diagnostic ignored "-Wincomplete-implementation" // for className
@implementation NSObject (MHF)

- (void)mhf_addObserver:(NSObject *)observer forKeyPaths:(NSArray <NSString *> *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context{
    [keyPaths enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addObserver:observer forKeyPath:obj options:options context:context];
    }];
}

@end
