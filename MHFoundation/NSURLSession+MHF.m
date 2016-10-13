//
//  NSURLSession+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 04/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSURLSession+MHF.h"

@implementation NSURLSession (MHF)

- (void)mhf_cancelAllTasks{
    [self getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        for(NSURLSessionDataTask* task in dataTasks){
            [task cancel];
        }
        for(NSURLSessionDataTask* task in uploadTasks){
            [task cancel];
        }
        for(NSURLSessionDataTask* task in downloadTasks){
            [task cancel];
        }
    }];
}

+ (NSURLSession *)mhf_sharedSessionMainQueueAllowInvalidSSL{
    static NSURLSession* sharedSessionMainQueueAllowInvalidSSL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSessionMainQueueAllowInvalidSSL = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:[[MHFURLSessionAllowInvalidSSLDelegate alloc] init] delegateQueue:[NSOperationQueue mainQueue]];
    });
    return sharedSessionMainQueueAllowInvalidSSL;
}

+ (NSURLSession *)mhf_sharedSessionMainQueue{
    static NSURLSession *sharedSessionMainQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSessionMainQueue = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    });
    return sharedSessionMainQueue;
}

@end

@implementation MHFURLSessionAllowInvalidSSLDelegate

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler{
    //this is how you accept anything, I believe.
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}

@end