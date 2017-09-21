//
//  MHFSelectorDelayer.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSTimer;

@interface MHFSelectorDelayer : NSObject

@property double delay; // @synthesize delay=_delay;
@property (nonatomic) BOOL forceMainThread; // @synthesize forceMainThread=_forceMainThread;
@property (nonatomic) SEL selector; // @synthesize selector=_selector;
@property (weak, nonatomic) id target; // @synthesize target=_target;
@property (strong) NSTimer *timer; // @synthesize timer=_timer;
@property (nonatomic) BOOL waitToFireUntilRequestsStop; // @synthesize waitToFireUntilRequestsStop=_waitToFireUntilRequestsStop;

- (void)cancelPreviousFireRequests;
- (void)fireImmediately;
- (id)initWithTarget:(id)arg1 selector:(SEL)arg2 delay:(double)arg3 waitToFireUntilRequestsStop:(BOOL)arg4;
- (id)initWithTarget:(id)arg1 selector:(SEL)arg2 delay:(double)arg3 waitToFireUntilRequestsStop:(BOOL)arg4 forceMainThread:(BOOL)arg5;
- (void)internalCancelFireRequests;
- (void)internalFireImmediately;
- (BOOL)internalIsScheduledToFire;
- (void)internalRequestFire;
- (BOOL)isScheduledToFire;
- (void)requestFire;

@end

