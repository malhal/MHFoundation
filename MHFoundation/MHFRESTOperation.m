//
//  MHFRESTOperation.m
//  MHFoundation
//
//  Created by Malcolm Hall on 10/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFRESTOperation.h"
#import "MHFError.h"
#import "NSError+MHF.h"
#import "MHFURLSessionTaskOperation.h"
#import "NSHTTPURLResponse+MHF.h"

@interface MHFRESTOperation()

@property (nonatomic, strong) NSData *HTTPBody;

@property (nonatomic, strong) NSDictionary *responseJSONDictionary;

@property (nonatomic, strong) NSHTTPURLResponse *response;

@end

@implementation MHFRESTOperation

- (instancetype)initWithURLRequest:(nullable NSURLRequest *)request bodyJSONDictionary:(nullable NSDictionary *)bodyJSONDictionary
{
    self = [super init];
    if (self) {
        _request = request.copy;
        _bodyJSONDictionary = bodyJSONDictionary.copy;
    }
    return self;
}

- (NSURLSession *)session{
    if(!_session){
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    }
    return _session;
}

- (BOOL)asyncOperationShouldRun:(NSError**)error{
    if(!self.request) {
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"A request must be provided for %@", self.class];
        return NO;
    }
    else if(self.request.HTTPBody) {
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"The request must not have a HTTPBody for %@", self.class];
        return NO;
    }
    
    if(self.bodyJSONDictionary){
        
        if(![self.bodyJSONDictionary isKindOfClass:NSDictionary.class]){
            *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"The bodyJSONDictionary must be an NSDictionary for %@", self.class];
            return NO;
        }
        
        @try {
            self.HTTPBody = [NSJSONSerialization dataWithJSONObject:self.bodyJSONDictionary options:0 error:error]; // todo wrap this error
        }
        @catch (NSException *exception) {
            NSDictionary* userInfo = @{NSLocalizedDescriptionKey : [NSString stringWithFormat:@"The bodyJSONDictionary must be JSON compatible for %@", self.class],
                                       NSLocalizedFailureReasonErrorKey : exception.reason};
            
            *error = [NSError errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments userInfo:userInfo];
        }
        @finally{
            // if we errored or exceptioned either way we didn't get a HTTPBody.
            if(!self.HTTPBody){
                return NO;
            }
        }
    }
    
    return [super asyncOperationShouldRun:error];
}

-(void)performAsyncOperation{
    [super performAsyncOperation];
    
    NSMutableURLRequest* request = self.request.mutableCopy;
    request.HTTPBody = self.HTTPBody;
    MHFURLSessionDataTaskOperation* dataTask = [[MHFURLSessionDataTaskOperation alloc] initWithURLRequest:request];
    dataTask.session = self.session;
    
    __block NSData* taskData;
    
    [dataTask setDataTaskCompletionBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            [self finishOnCallbackQueueWithError:error];
            return;
        }
        taskData = data;
        self.response = (NSHTTPURLResponse *)response;
    }];
    [self addOperation:dataTask];
    
    NSBlockOperation *decodeOperation = [NSBlockOperation blockOperationWithBlock:^{
        // we parse the json regardless of if there is an error code or not.
        NSError* error;
        id JSONObject;
        if(taskData.length){
            JSONObject = [NSJSONSerialization JSONObjectWithData:taskData options:0 error:&error];
            if(!JSONObject){
                // todo wrap error
            }
            else if(![JSONObject isKindOfClass:[NSDictionary class]]){
                error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorUnknown descriptionFormat:@"The response was not a NSDictionary for %@", self.class];
            }
        }
        // if we don't have a parse error we can now check for an http error code
        if(!error){
           if(!self.response.mhf_isSuccessful){
               error = [self.response mhf_HTTPErrorWithUserInfo:JSONObject];
           }else{
               self.responseJSONDictionary = JSONObject;
           }
        }
        [self finishOnCallbackQueueWithError:error];
    }];
    
    [self addOperation:decodeOperation];
}

- (void)finishOnCallbackQueueWithError:(NSError*)error{
    if(self.RESTCompletionBlock){
        self.RESTCompletionBlock(self.responseJSONDictionary, self.response, error);
    }
    [super finishOnCallbackQueueWithError:error];
}

@end
