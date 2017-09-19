//
//  NSSet+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 04/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSSet+MHF.h"

@implementation NSSet (MHF)

- (BOOL)mhf_containsObjectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, BOOL *stop))predicate{
    return [self mhf_objectPassingTest:predicate];
}

- (id)mhf_objectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, BOOL *stop))predicate{
    return [self objectsPassingTest:predicate].anyObject;
}

- (NSSet *)mhf_objectsOfClass:(Class)aClass{
    return [self objectsPassingTest:^BOOL(id _Nonnull obj, BOOL * _Nonnull stop) {
        return [obj isKindOfClass:aClass];
    }];
}

@end
