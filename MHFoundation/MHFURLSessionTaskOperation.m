//
//  MHFURLSessionTaskOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 03/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFURLSessionTaskOperation.h"
#import "MHFError.h"
#import "NSError+MHF.h"

@interface MHFURLSessionTaskOperation()

@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation MHFURLSessionTaskOperation

- (instancetype)init
{
    return [super init];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request
{
    self = [self init];
    if (self) {
        _request = request.copy;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url
{
    self = [self init];
    if (self) {
        _url = url.copy;
    }
    return self;
}

- (NSURLSession *)session{
    if(!_session){
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

-(void)cancel{
    [super cancel];
    [self.task cancel]; // the completion handler is called with cancel.
}

- (BOOL)asyncOperationShouldRun:(NSError**)error{
    if(!self.task){
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"A task must be provided for %@ usually via a subclass", NSStringFromClass(self.class)];
        return NO;
    }
    
    return [super asyncOperationShouldRun:error];
}

-(void)performAsyncOperation{
    [super performAsyncOperation];
    [self.task resume];
}

@end

@interface MHFURLSessionDataTaskOperation()

@property (nonatomic, strong) NSData *data;

@end

@implementation MHFURLSessionDataTaskOperation

- (BOOL)asyncOperationShouldRun:(NSError**)error{
    void(^completionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^void(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        self.data = data;
        [self finishWithError:error];
    };
    
    if(self.request) {
        self.task = [self.session dataTaskWithRequest:self.request completionHandler:completionHandler];
    }
    else if(self.url){
        self.task = [self.session dataTaskWithURL:self.url completionHandler:completionHandler];
    }
    else{
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"Either a URL or request must be provided for %@", NSStringFromClass(self.class)];
        return NO;
    }

    return [super asyncOperationShouldRun:error];
}

- (void)finishOnCallbackQueueWithError:(NSError*)error{
    if(self.dataTaskCompletionBlock){
        self.dataTaskCompletionBlock(self.data, self.task.response, error);
    }
    [super finishOnCallbackQueueWithError:error];
}

@end

@interface MHFURLSessionDownloadTaskOperation()

@property (strong, nonatomic) NSURL *location;

@end

@implementation MHFURLSessionDownloadTaskOperation

- (instancetype)initWithResumeData:(NSData *)resumeData{
    self = [self init];
    if (self) {
        _resumeData = resumeData.copy;
    }
    return self;
}

- (BOOL)asyncOperationShouldRun:(NSError**)error{
    void(^completionHandler)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) = ^void(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error){
        self.location = location;
        [self finishWithError:error];
    };
    
    if(self.resumeData){
        self.task = [self.session downloadTaskWithResumeData:self.resumeData completionHandler:completionHandler];
    }
    else if(self.request){
        self.task = [self.session downloadTaskWithRequest:self.request completionHandler:completionHandler];
    }
    else if(self.url){
        self.task = [self.session downloadTaskWithURL:self.url completionHandler:completionHandler];
    }
    else{
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"Either a URL, request or resumeData must be provided for %@", NSStringFromClass(self.class)];
        return NO;
    }
    
    return [super asyncOperationShouldRun:error];
}

- (void)finishOnCallbackQueueWithError:(NSError*)error{
    if(self.downloadTaskCompletionBlock){
        self.downloadTaskCompletionBlock(self.location, self.task.response, error);
    }
    [super finishOnCallbackQueueWithError:error];
}

@end