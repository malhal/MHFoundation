//
//  NSObject+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 30/10/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MHF)

- (void)mhf_addObserver:(NSObject *)observer forKeyPaths:(NSArray <NSString *> *)keyPaths options:(NSKeyValueObservingOptions)options context:(void *)context;
- (NSString *)className;

@end
