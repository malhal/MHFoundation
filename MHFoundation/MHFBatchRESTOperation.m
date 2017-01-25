//
//  MHFBatchRESTOperation.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHFBatchRESTOperation.h"
#import "MHFRESTOperation_Private.h"
#import "MHFAsyncOperationSubclass.h"
#import "MHFError_Internal.h"
#import "NSError+MHF.h"
#import "MHFHTTPError.h"
#import "NSHTTPURLResponse+MHF.h"
#import <objc/runtime.h>

@interface MHFBatchRESTOperation()

//@property (nonatomic, strong) NSArray<NSDictionary *> *responseJSONDictionaries;

@property (nonatomic, strong) NSDictionary<NSURLRequest *, NSError *> *partialErrors;

@end

@implementation MHFBatchRESTOperation

- (instancetype)initWithURLRequest:(nullable NSURLRequest *)request batchRequests:(nullable NSArray <NSURLRequest *> *)batchRequests{
    
    self = [self initWithURLRequest:request];
    if (self) {
        _batchRequests = batchRequests.copy;
    }
    return self;
}

- (BOOL)asyncOperationShouldRun:(NSError**)error{
    if(!self.batchRequests.count) {
        *error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorInvalidArguments descriptionFormat:@"batchRequests must be provided for %@", self.class];
        return NO;
    }
    
    
    NSMutableArray* requests = [NSMutableArray array];
    for(NSURLRequest* batchRequest in self.batchRequests){
        [requests addObject:@{@"path" : batchRequest.URL.absoluteString,
                              @"method" : batchRequest.HTTPMethod,
                              @"body" : batchRequest.mhf_JSONBody}];
    }
    
    self.request.mhf_JSONBody = requests;
    
    return [super asyncOperationShouldRun:error];
}

-(void)performAsyncOperation{
    [super performAsyncOperation];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSArray* responses = (NSArray *)self.JSONObject;
        
        if(![responses isKindOfClass:[NSArray class]]){
            return [self finishWithError:[NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorUnknown descriptionFormat:@"An array of responses was not received for %@", self.class]];
        }
        
        NSMutableDictionary* partialErrors = [NSMutableDictionary dictionary];
        [responses enumerateObjectsUsingBlock:^(NSDictionary *rd, NSUInteger idx, BOOL *stop)
        {
             NSURLRequest *request = self.batchRequests[idx];
             NSNumber *status = rd[@"status"];
             id JSONObject = rd[@"body"];
             NSHTTPURLResponse *HTTPURLResponse = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:status.integerValue HTTPVersion:nil headerFields:nil];
             NSError *error;
             if(!([JSONObject isKindOfClass:[NSDictionary class]] || [JSONObject isKindOfClass:[NSArray class]])){
                error = [NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorUnknown descriptionFormat:@"The response body JSON was not a dictionary or an array for %@", self.class];
             }
             else if(!HTTPURLResponse.mhf_isSuccessful){
                 partialErrors[request] = [self errorFromJSONObject:JSONObject response:HTTPURLResponse];
             }
             if(self.perRequestCompletionBlock){
                 self.perRequestCompletionBlock(request, JSONObject, HTTPURLResponse, error);
             }
         }];
         self.partialErrors = partialErrors.copy;
    }];
    [self addOperation:op];
}

- (void)finishOnCallbackQueueWithError:(NSError*)error{
    if(!error){
        if(self.partialErrors.count){
            error = [MHFError errorWithCode:MHFErrorPartialFailure userInfo:@{MHFPartialErrorsByItemIDKey : self.partialErrors}];
        }
    }
    if(self.batchCompletionBlock){
        self.batchCompletionBlock(error);
    }
    [super finishOnCallbackQueueWithError:error];
}

@end

//@implementation NSMutableURLRequest (MHFBatchRESTOperation)
//
//-(id)mhf_identifier{
//    return objc_getAssociatedObject(self, @selector(mhf_identifier));
//}
//
//-(void)mhf_setIdentifier:(NSString *)identifier{
//    objc_setAssociatedObject(self, @selector(identifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//@end
