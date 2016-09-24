//
//  MHFBatchRESTOperation.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Dynamically Loaded. All rights reserved.
//

#import "MHFBatchRESTOperation.h"
#import "MHFRESTOperation_Internal.h"
#import "MHFError.h"
#import "NSError+MHF.h"
#import "MHFHTTPError.h"
#import "NSHTTPURLResponse+MHF.h"

@interface MHFBatchRESTOperation()

//@property (nonatomic, strong) NSArray<NSDictionary *> *responseJSONDictionaries;

@end

@implementation MHFBatchRESTOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _atomic = YES;
    }
    return self;
}

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
    
    self.request.mhf_JSONBody = @{@"atomic" : @(self.atomic),
                                  @"requests" : requests
                                  };
    
    return [super asyncOperationShouldRun:error];
}

-(void)performAsyncOperation{
    [super performAsyncOperation];
    
    NSBlockOperation* op = [NSBlockOperation blockOperationWithBlock:^{
        NSArray* responses = self.responseJSON[@"responses"];
        if(!responses){
            return [self finishWithError:[NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorUnknown descriptionFormat:@"responses key was not contained in the response for %@", self.class]];
        }
        else if(![responses isKindOfClass:[NSArray class]]){
            return [self finishWithError:[NSError mhf_errorWithDomain:MHFoundationErrorDomain code:MHFErrorUnknown descriptionFormat:@"responses must be an array for %@", self.class]];
        }
        [responses enumerateObjectsUsingBlock:^(NSDictionary *rd, NSUInteger idx, BOOL *stop)
         {
             NSURLRequest* request = self.batchRequests[idx];
             NSNumber* status = rd[@"status"];
             NSDictionary* JSON = rd[@"body"];
             NSHTTPURLResponse* HTTPURLResponse = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:status.integerValue HTTPVersion:nil headerFields:nil];
             NSError* error;
             [self validateResponse:HTTPURLResponse JSON:JSON error:&error];
             if(self.perResponseBlock){
                 self.perResponseBlock(JSON, HTTPURLResponse, error);
             }
         }];
    }];
    [self addOperation:op];
}

@end
