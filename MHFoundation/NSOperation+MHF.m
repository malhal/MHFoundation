//
//  NSOperation+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 03/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSOperation+MHF.h"

@implementation NSOperation (MHF)

- (void)mhf_addDependencyOnLastInQueue:(NSOperationQueue *)queue{
    NSOperation* lastOp = queue.operations.lastObject;
    if (lastOp){
        [self addDependency: lastOp];
    }
}

@end
