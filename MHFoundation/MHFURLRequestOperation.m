//
//  MHFURLRequestOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 03/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFURLRequestOperation.h"
#import "MHFError.h"
#import "NSError+MHF.h"

@interface MHFURLRequestOperation()

@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong) NSURLResponse *response;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation MHFURLRequestOperation

- (instancetype)initWithURLRequest:(NSURLRequest *)request
{
    self = [super init];
    if (self) {
        _request = request.copy;
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
    [self.dataTask cancel]; // the completion handler is called with cancel.
}

-(BOOL)asyncOperationShouldRun:(NSError**)error{
    // we cannot sync up if they are not logged in.
    if(!self.request){
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"a request must be provided for %@", NSStringFromClass(self.class)];
        return NO;
    }
    return [super asyncOperationShouldRun:error];
}

-(void)performAsyncOperation{
    [super performAsyncOperation];
    
    self.dataTask = [self.session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.data = data;
        self.response = response;
        [self finishWithError:error];
    }];
    [self.dataTask resume];
}

- (void)finishOnCallbackQueueWithError:(NSError*)error{
    if(self.requestCompletionBlock){
        self.requestCompletionBlock(self.data, self.response, error);
    }
    [super finishOnCallbackQueueWithError:error];
}


@end
