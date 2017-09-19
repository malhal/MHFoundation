//
//  MHFUtilities.m
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "MHFUtilities.h"

id MHFDynamicCast(Class aClass, id object){
    if([object isKindOfClass:aClass]){
        return object;
    }
    return nil;
}

@implementation MHFUtilities

@end
