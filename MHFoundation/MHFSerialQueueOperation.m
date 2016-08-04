//
//  MHFQueueOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFSerialQueueOperation.h"
#import "NSOperation+MHF.h"
#import "MHFError.h"
#import "NSError+MHF.h"

@implementation MHFSerialQueueOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

-(void)addSerialOperation:(NSOperation*)op{
    [op mhf_addDependencyOnLastInQueue:self.operationQueue];
    [self.operationQueue addOperation:op];
}


@end
