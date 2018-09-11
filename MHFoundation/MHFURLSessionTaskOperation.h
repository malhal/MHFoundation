//
//  MHFURLSessionTaskOperation.h
//  MHFoundation
//
//  Created by Malcolm Hall on 03/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MHFoundation/MHFDefines.h>
#import <MHFoundation/MHFAsyncOperation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHFURLSessionTaskOperation : MHFAsyncOperation

//- (instancetype)init NS_DESIGNATED_INITIALIZER; // not needed yet

- (instancetype)initWithURLRequest:(NSURLRequest *)request;

- (instancetype)initWithURL:(NSURL *)url;

// if no session is set the shared session is used.
@property (nonatomic, strong, nullable) NSURLSession *session;

@property (nonatomic, copy, nullable) NSURLRequest *request;

@property (nonatomic, copy, nullable) NSURL *url;

@end

@interface MHFURLSessionDataTaskOperation : MHFURLSessionTaskOperation

/*  This block is called when the operation completes.
 The [NSOperation completionBlock] will also be called if both are set. */
@property (nonatomic, copy, nullable) void (^dataTaskCompletionBlock)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);

@end

@interface MHFURLSessionDownloadTaskOperation : MHFURLSessionTaskOperation

@property (nonatomic, copy, nullable) NSData *resumeData;

- (instancetype)initWithResumeData:(NSData *)resumeData;

/*  This block is called when the operation completes.
 The [NSOperation completionBlock] will also be called if both are set. */
@property (nonatomic, copy, nullable) void (^downloadTaskCompletionBlock)(NSURL * __nullable location, NSURLResponse * __nullable response, NSError * __nullable error);

@end

NS_ASSUME_NONNULL_END
