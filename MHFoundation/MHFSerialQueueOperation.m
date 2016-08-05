//
//  MHFQueueOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFSerialQueueOperation.h"
#import "MHFQueueOperation_Internal.h"

@implementation MHFSerialQueueOperation

-(void)addOperation:(NSOperation*)op{
    self.operationQueue.maxConcurrentOperationCount = 1;
    NSOperation* lastOp = self.operationQueue.operations.lastObject;
    if (lastOp){
        [op addDependency: lastOp];
    }
    [super addOperation:op];
}


@end
