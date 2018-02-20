//
//  MHFObserver.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/02/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
// This class can be used by UI that displays an object by allowing a single method that updates views intially and for any change.

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@protocol MHFObserverDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MHFObserver : NSObject

- (instancetype)initWithDelegate:(id<MHFObserverDelegate>)delegate;

@property (weak, nonatomic, readonly) id<MHFObserverDelegate> delegate;
@property (weak, nonatomic) id object;
@property (nullable, nonatomic, strong) NSArray<NSString *> *keyPaths;

@end

@protocol MHFObserverDelegate <NSObject>

@required
// called when the object or keyPaths property are changed but more importantly when the keyPath of the object value changes to a new value.
- (void)observer:(MHFObserver *)observer objectChangedKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
