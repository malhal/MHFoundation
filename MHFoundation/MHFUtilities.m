//
//  MHFUtilities.m
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "MHFUtilities.h"
#import "MHFReachability.h"
#import "NSException+MHF.h"

id MHFDynamicCast(Class aClass, id object){
    if([object isKindOfClass:aClass]){
        return object;
    }
    return nil;
}

float MHFDispatchMainAfterDelay(dispatch_block_t block){
    float f = dispatch_time(DISPATCH_TIME_NOW, 0);
    dispatch_after(f, dispatch_get_main_queue(), block);
    return f;
}

void MHFPerformBlockOnMainThread(dispatch_block_t block){
    if ([NSThread isMainThread]){
        block();
    }else{
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@implementation MHFUtilities

// missing reachability
+ (BOOL)isInternetReachable{
    NetworkStatus status = ICReachability.sharedReachabilityForInternetConnection.currentReachabilityStatus;
    if(status > 2){
        return NO;
    }
    return 0x6 >> (status & 0x7) & 0x1;
}

+ (struct _NSRange)range:(struct _NSRange)arg1 liesWithinRange:(struct _NSRange)arg2 assert:(BOOL)arg3{
    @throw [NSException mhf_notImplementedException];
}


@end
