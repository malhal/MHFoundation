//
//  NSSet+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 18/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSSet<__covariant ObjectType>  (MHF)

- (BOOL)mhf_containsObjectPassingTest:(BOOL (NS_NOESCAPE ^)(ObjectType obj, BOOL *stop))predicate;
- (ObjectType)mhf_objectPassingTest:(BOOL (NS_NOESCAPE ^)(ObjectType obj, BOOL *stop))predicate;
- (NSSet<ObjectType> *)mhf_objectsOfClass:(Class)aClass;

@end
