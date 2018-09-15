//
//  NSUndoManager+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUndoManager (MHF)

@property (nonatomic, assign, readonly) BOOL mhf_isUndoingOrRedoing;

@end

NS_ASSUME_NONNULL_END
