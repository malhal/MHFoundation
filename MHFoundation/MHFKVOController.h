//
//  MHFKVOController.h
//  MHFoundation
//
//  Created by Malcolm Hall on 19/02/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@protocol MHFKVOControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MHFKVOController : NSObject

@property (weak, nonatomic) id object;
@property (nullable, nonatomic, strong) NSArray<NSString *> *keysToObserve;
@property (weak, nonatomic) id<MHFKVOControllerDelegate> delegate;

@end

@protocol MHFKVOControllerDelegate <NSObject>

@required
- (void)KVOControllerObjectChanged:(MHFKVOController *)controller;

@end

NS_ASSUME_NONNULL_END
