//
//  NSURLSession+MHF.h
//  MHFoundation
//
//  Created by Malcolm Hall on 04/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>

@interface NSURLSession (MHF)

// convenience for cancelling tasks but not invalidating session like invalidateAndCancel does.
- (void)mhf_cancelAllTasks;

/*
 Simply use as a replacement for [NSURLSession sharedSession] as follows:
 
 [[NSURLSession sharedSessionAllowInvalidSSL] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {}];
 
 Please not if using this in the main operation queue you'll get a dead lock so the delegates won't fire.
 
 */
+ (NSURLSession *)mhf_sharedSessionMainQueueAllowInvalidSSL;
+ (NSURLSession *)mhf_sharedSessionMainQueue;

@end

@interface MHFURLSessionAllowInvalidSSLDelegate : NSObject<NSURLSessionDelegate>
@end
