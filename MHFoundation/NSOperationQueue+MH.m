//
//  NSOperationQueue+MH.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSOperationQueue+MH.h"

@implementation NSOperationQueue (MH)

- (void)mh_addOperationAfterLast:(NSOperation *)op
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
