//
//  NSOperation+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 03/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSOperation (MHF)

- (void)mhf_addDependencyOnLastInQueue:(NSOperationQueue *)queue;

@end

NS_ASSUME_NONNULL_END