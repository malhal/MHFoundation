//
//  NSURL+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 21/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSURL+MHF.h"

@implementation NSURL (MHF)

+ (NSURL *)mhf_URLWithString:(NSString *)URLString query:(NSDictionary<NSString *, NSString *> *)query{
    NSMutableArray<NSURLQueryItem *> *items = [NSMutableArray array];
    for (NSString *key in query.allKeys) {
        id value = query[key];
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:[value description]];
        [items addObject:queryItem];
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:URLString];
    components.queryItems = items;
    return components.URL;
}

@end
