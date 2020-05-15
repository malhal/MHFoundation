//
//  NSMutableDictionary+Nulls.h
//  DataStoreDemo
//
//  Created by Malcolm Hall on 10/11/2014.
//  Copyright (c) 2014 Dynamically Loaded Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (MHF)

- (BOOL)mhf_setObjectOrNull:(id)anObject forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
