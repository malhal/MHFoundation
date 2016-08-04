//
//  MHFQueueOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFQueueOperation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFSerialQueueOperation : MHFQueueOperation

// adds a dependency on the last operation in the queue and then adds it to the queue.
-(void)addSerialOperation:(NSOperation*)op;

@end

NS_ASSUME_NONNULL_END