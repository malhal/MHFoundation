//
//  MyOperation.m
//  MHFDemo
//
//  Created by Malcolm Hall on 05/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MyOperation.h"
#import <MHFoundation/MHFAsyncOperationSubclass.h>


@implementation MyOperation

-(void)performAsyncOperation{
    
    [self performSelectorInBackground:@selector(background) withObject:nil];
}

-(void)background{
    sleep(1);
    [self finishWithError:nil];
}

-(void)malc{
    NSLog(@"changed");
}

-(void)dealloc{
    NSLog(@"dealloc");
}

@end
