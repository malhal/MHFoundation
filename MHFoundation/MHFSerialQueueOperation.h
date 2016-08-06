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

/**
 The serial queue sets the number of simultaneous operations to 1 and 
 it adds a dependency on the last operation before adding to the queue.
 */
@interface MHFSerialQueueOperation : MHFQueueOperation

@end

NS_ASSUME_NONNULL_END