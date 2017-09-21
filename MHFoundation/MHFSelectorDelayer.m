//
//  MHFSelectorDelayer.m
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "MHFSelectorDelayer.h"
#import "NSDate+MHF.h"
#import "NSException+MHF.h"
#import "MHFUtilities.h"

@implementation MHFSelectorDelayer

- (void)cancelPreviousFireRequests{
    if(self.forceMainThread){
        MHFPerformBlockOnMainThread(^{
            [self internalCancelFireRequests];
        });
    }else{
        [self internalCancelFireRequests];
    }
}

- (void)fireImmediately{
    if(self.forceMainThread){
        MHFPerformBlockOnMainThread(^{
            [self internalFireImmediately];
        });
    }else{
        [self internalFireImmediately];
    }
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector delay:(double)delay waitToFireUntilRequestsStop:(BOOL)waitToFireUntilRequestsStop{
    return [self initWithTarget:target selector:selector delay:delay waitToFireUntilRequestsStop:waitToFireUntilRequestsStop forceMainThread:NO];
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector delay:(double)delay waitToFireUntilRequestsStop:(BOOL)waitToFireUntilRequestsStop forceMainThread:(BOOL)forceMainThread{
    self = [super init];
    if (self) {
        self.target = target;
        self.selector = selector;
        self.delay = delay;
        self.waitToFireUntilRequestsStop = waitToFireUntilRequestsStop;
        self.forceMainThread = forceMainThread;
    }
    return self;
}

- (void)internalCancelFireRequests{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)internalFireImmediately{
    [self internalCancelFireRequests];
    void (*imp)(id, SEL) = (void(*)(id, SEL))[self.target methodForSelector:self.selector];
    if(imp){
        imp(self.target, self.selector);
    }
    else{
        NSLog(@"invalid nil value for '%s'", "imp");
    }
}

- (BOOL)internalIsScheduledToFire{
    if(!self.timer || !self.timer.isValid) {
        return NO;
    }
    return [self.timer.fireDate mhf_isLaterThanDate:[NSDate date]];
}

- (void)internalRequestFire{
    if(!self.isScheduledToFire || self.waitToFireUntilRequestsStop){
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.delay target:self.target selector:self.selector userInfo:nil repeats:nil];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (BOOL)isScheduledToFire{
    __block BOOL b;
    if(self.forceMainThread){
        MHFPerformBlockOnMainThread(^{
            b = [self internalIsScheduledToFire];
        });
    }
    else{
        b = [self internalIsScheduledToFire];
    }
    return b;
}

- (void)requestFire{
    if(self.forceMainThread){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self internalRequestFire];
        });
    }else{
        [self internalRequestFire];
    }
}

@end
