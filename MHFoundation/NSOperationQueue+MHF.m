//
//  NSOperationQueue+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSOperationQueue+MHF.h"

@implementation NSOperationQueue (MHF)

- (void)mhf_addSerialOperation:(NSOperation *)op{
    // ensure the operation will not start until the previous has finished.
    NSOperation* lastOp = self.operations.lastObject;
    if (lastOp){
        [op addDependency: lastOp];
    }
    [self addOperation:op];
}

@end
