//
//  MHFUtilities.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

MHF_EXTERN id MHFDynamicCast(Class aClass, id object);
MHF_EXTERN id MHFCheckedDynamicCast(Class aClass, id object);
MHF_EXTERN id MHFProtocolCast(Protocol *protocol, id object);

MHF_EXTERN float MHFDispatchMainAfterDelay(dispatch_block_t block);
MHF_EXTERN void MHFPerformBlockOnMainThread(dispatch_block_t block);

@interface MHFUtilities : NSObject

+ (struct _NSRange)range:(struct _NSRange)arg1 liesWithinRange:(struct _NSRange)arg2 assert:(BOOL)arg3;

@end

NS_ASSUME_NONNULL_END
