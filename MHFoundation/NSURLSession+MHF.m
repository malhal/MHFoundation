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

@end
