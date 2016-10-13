//
//  MHFQueueOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFSerialQueueOperation.h"
#import "MHFQueueOperation_Internal.h"
#import "NSOperationQueue+MHF.h"

@implementation MHFSerialQueueOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        // this makes one operation run at a time but it does not ensure order.
        self.operationQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

-(void)addOperation:(NSOperation*)op{
    [self.operationQueue mhf_addSerialOperation:op];
}

@end