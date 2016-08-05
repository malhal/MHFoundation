//
//  MyOperation.m
//  MHFDemo
//
//  Created by Malcolm Hall on 05/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

-(void)performAsyncOperation{
    [self performSelectorInBackground:@selector(background) withObject:nil];
}

-(void)background{
    sleep(3);
    [self finishWithError:nil];
}

@end
