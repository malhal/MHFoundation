//
//  MHFRESTOperation_Private.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 23/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFRESTOperation.h>

NS_ASSUME_NONNULL_BEGIN

// the extensions in this header are to be used only by subclasses of MHFRESTOperation
// code that uses MHFRESTOperation must never call these

@interface MHFRESTOperation (MHFRESTOperationProtected)

@property (nonatomic, strong) id JSONObject;

@property (nonatomic, strong) NSHTTPURLResponse *response;

// override to parse the error from the JSON when the response code was a fail.
- (NSError *)errorFromJSONObject:(id)JSONObject response:(NSHTTPURLResponse *)response;

@end

NS_ASSUME_NONNULL_END
