//
//  EXAppDelegate.m
//  ExReport
//
//  Created by a289458845 on 02/04/2021.
//  Copyright (c) 2021 a289458845. All rights reserved.
//

#import "EXAppDelegate.h"
#import <ExService.h>
@implementation EXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
http://api2.ztc.comlbs.com 44D1AA4E6E204BBE9BB17CE5C2E95FCB
//http://120.221.95.146:10001  8761051B4D8D47A5A02213330F13BC54
    [ExService manager].baseUrl = @"http://api2.ztc.comlbs.com";
    [ExService manager].token = @"44D1AA4E6E204BBE9BB17CE5C2E95FCB";
    [[ExService manager] getReginData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
