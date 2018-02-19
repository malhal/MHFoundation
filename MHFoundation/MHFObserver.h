//
//  MHFObserver.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/02/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@protocol MHFObserverDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MHFObserver : NSObject

@property (weak, nonatomic) id object;
@property (nullable, nonatomic, strong) NSArray<NSString *> *keyPaths;
@property (weak, nonatomic) id<MHFObserverDelegate> delegate;

// subclassing
//- (void)addObserversForObject:(id)object NS_REQUIRES_SUPER;
//- (void)removeObserversForObject:(id)object NS_REQUIRES_SUPER;
//- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context NS_REQUIRES_SUPER;

@end

@protocol MHFObserverDelegate <NSObject>

@required
- (void)observer:(MHFObserver *)observer objectChangedKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
