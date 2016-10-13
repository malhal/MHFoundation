//
//  NSDictionary+MHF.m
//  MHFoundation
//
//  Created by Malcolm Hall on 23/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "NSDictionary+MHF.h"
#import "NSString+MHF.h"

@implementation NSDictionary (MHF)

-(NSSet*)mhf_allKeysSet{
    return [NSSet setWithArray:self.allKeys];
}

//- (NSArray*)mhf_objectsForKnownKeys:(NSArray*)keys{
//    return [self objectsForKeys:keys notFoundMarker:[NSNull null]];
//}

- (NSDictionary *)mhf_unflattenDictionary{
    // create the new dict we will fill
    NSMutableDictionary* d = [NSMutableDictionary dictionary];
    for(NSString* key in self.allKeys){ // app.name, app.date etc.
        // copy a reference to a variable that we will change as we go through the tree.
        NSMutableDictionary* d2 = d;
        NSArray* parts = [key componentsSeparatedByString:@"."]; //e.g. key1,key2,key3
        NSArray* partsExceptLast = [parts subarrayWithRange:NSMakeRange(0, parts.count - 1)]; // e.g. key1,key2
        for(NSString* part in partsExceptLast){
            NSMutableDictionary* d3 = d2[part];
            if(!d3){
                d3 = [NSMutableDictionary dictionary];
            }
            d2[part] = d3;
            d2 = d3; // change the main dict to this sub dict so we can go deeper.
        }
        d2[parts.lastObject] = self[key]; // set the final value
    }
    return d;
}

 - (instancetype)mhf_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary{
     NSMutableDictionary *combinedDictionary = self.mutableCopy;
     [combinedDictionary addEntriesFromDictionary:dictionary];
     return combinedDictionary;
 }

- (id)mhf_nilIfNSNullObjectForKey:(id)aKey{
    id obj = [self objectForKey:aKey];
    if(obj == [NSNull null]){
        return nil;
    }
    return obj;
}

-(NSString*)mhf_URLEncodedString{
    NSMutableArray* params = [NSMutableArray array];
    for(NSDictionary* key in self.allKeys){
        NSString* val = [self[key] description]; // description in case NSNumber
        //ecode the val so that equals can be in it.
        [params addObject:[NSString stringWithFormat:@"%@=%@", key, val.mhf_URLEncodedString]];
    }
    return [params componentsJoinedByString:@"&"];
}

@end
