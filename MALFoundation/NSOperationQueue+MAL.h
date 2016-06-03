//
//  NSOperationQueue+MAL.h
//  MALFoundation
//
//  Created by Malcolm Hall on 11/04/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (MAL)

// Adds an operation and makes the last one in the queue dependent on it so it runs afterwards.
// It also ensures the queue's maxConcurrentOperationCount to 1.
- (void)mal_addOperationAfterLast:(NSOperation *)op;

@end
