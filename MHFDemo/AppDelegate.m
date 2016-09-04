//
//  AppDelegate.m
//  MHFDemo
//
//  Created by Malcolm Hall on 05/08/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MyOperation.h"
#import <MHFoundation/MHFoundation.h>


@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;

    MyOperation* op = [[MyOperation alloc] init];
    [op setAsyncOperationCompletionBlock:^(NSError * _Nullable error) {
        NSLog(@"async complete");
    }];
    //[op start];
    
    NSDate* date = [NSDate date];
    //NSData* d = [NSJSONSerialization dataWithJSONObject:@[date] options:0 error:nil];
   // NSString* s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    
    //[self jsonTest];
    [self jsonTest2];
    
    return YES;
}

-(NSURLSession*)session{
    if(!_session){
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        //config.HTTPMaximumConnectionsPerHost = 1;
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[[NSOperationQueue alloc] init]];
        
    }
    return _session;
}

- (NSMutableURLRequest*)request{
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/~mh/wfff-passwords/api/venue?api_token=aaa"]];
    NSError* error;
    [req mhf_setMethodPOST];
    if(![req mhf_setBodyJSONObject:@{@"name":@"malc"} error:&error]){
        NSLog(@"error %@", error);
        return nil;
    }
    return req;
}

-(void)jsonTest{

//    NSURLSessionDataTask* task = [NSURLSessionDataTask mhf_stringTaskWithSession:self.session request:req completionHandler:^(NSString * _Nullable string, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"error %@", error);
//            return;
//        }
//        NSLog(@"done %@", string);
//    }];
    //[task resume];
    
    NSURLSessionDataTask* task2 = [NSURLSessionDataTask mhf_JSONTaskWithSession:self.session request:self.request completionHandler:^(id _Nullable JSONObject, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"error2 %@", error);
            return;
        }
        NSLog(@"done2 %@", JSONObject);
        
        NSDate* d = [NSDate mhf_dateFromMySQLString:JSONObject[@"created_at"]];
        NSLog(@"2 %@", d);
        
        
        
        
        //[self.session mhf_cancelAllTasks];
        
        
    }];
    [task2 resume];
    
    [self.session.delegateQueue addOperationWithBlock:^{
        NSLog(@"block");
    }];
    
    NSURLSessionDataTask* task3 = [NSURLSessionDataTask mhf_JSONTaskWithSession:self.session request:self.request completionHandler:^(id _Nullable JSONObject, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            NSLog(@"error3 %@", error);
            return;
        }
        NSLog(@"done3 %@", JSONObject);
        
        NSDate* d = [NSDate mhf_dateFromMySQLString:JSONObject[@"created_at"]];
        NSLog(@"3 %@", d);
    }];
    [task3 resume];
    
}

-(void)jsonTest2{
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    __block NSData *data2;
    MHFURLRequestOperation* op = [[MHFURLRequestOperation alloc] initWithURLRequest:self.request];
    [op setRequestCompletionBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"complete1");
        data2 = data;
        //[queue cancelAllOperations];
    }];
    [queue addOperation:op];
    
    MHFURLRequestOperation* op2 = [[MHFURLRequestOperation alloc] initWithURLRequest:self.request];
    [op2 setRequestCompletionBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"complete2");
    }];
    [queue addOperation:op2];
    
    [queue addOperationWithBlock:^{
        NSString* s = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@", s);
        return;
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
