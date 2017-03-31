//
//  AppDelegate.m
//  SNWindowTest
//
//  Created by sunDong on 2017/3/27.
//  Copyright © 2017年 snlo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSString*)getBundleID
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        NSString *sn_url_str = [[NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId%@",[self getBundleID]]stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        NSURL *sn_url = [NSURL URLWithString:sn_url_str];
        NSMutableURLRequest *sn_request = [[NSMutableURLRequest alloc]initWithURL:sn_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        sn_request.timeoutInterval = 7;
        NSError *sn_error;
        NSData *sn_received = [NSURLConnection sendSynchronousRequest:sn_request returningResponse:nil error:&sn_error];
        if (sn_error) {
        } else {
            NSDictionary *sn_jsonDict = [NSJSONSerialization JSONObjectWithData:sn_received options:NSJSONReadingMutableLeaves error:nil];
            if(sn_jsonDict){
                NSLog(@"sn_jsonDict - - %@",sn_jsonDict);
                
                if ([[NSString stringWithFormat:@"%@",sn_jsonDict[@"resultCount"]] integerValue] > 0) {
                    //APP已上线了的
                    NSLog(@"//APP已上线了的");
                } else {
                    //app没有上线
                    NSLog(@"//app没有上线");
                }
            }
        }
        
    });
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
