//
//  NSOperationQueue+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSOperationQueue+MHF.h"

@implementation NSOperationQueue (MHF)

- (void)mhf_addOperationAfterLast:(NSOperation *)op
{
    if (self.maxConcurrentOperationCount != 1){
        self.maxConcurrentOperationCount = 1;
    }
    
    NSOperation* lastOp = self.operations.lastObject;
    if (lastOp){
        [op addDependency: lastOp];
    }
    
    [self addOperation:op];
}

@end
