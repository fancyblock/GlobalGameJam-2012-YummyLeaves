//
//  HIAppDelegate.m
//  HIFramework
//
//  Created by He JiaBin on 12-5-16.
//  Copyright (c) 2012年 FancyBlockGames. All rights reserved.
//

#import "HIAppDelegate.h"
#import "TaskSet.h"
#import "LogoTask.h"
#import "BeginTask.h"
#import "GameTask.h"
#import "EndTask.h"


@implementation HIAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [application setStatusBarHidden:YES];
    
    // Override point for customization after application launch.
    
    // create the game app
    m_gameApp = [[HIApp alloc] initWithOrientation:ORIENTATION_PORTRAIT deviceType:DEVICE_IPHONE withFPS:30];
    
    // init the application
    LogoTask* logoTask = [[LogoTask alloc] init];
    BeginTask* beginTask = [[BeginTask alloc] init];
    GameTask* gameTask = [[GameTask alloc] init];
    EndTask* endTask = [[EndTask alloc] init];
    
    [TaskSet sharedInstance]._logoTask = logoTask;
    [TaskSet sharedInstance]._beginTask = beginTask;
    [TaskSet sharedInstance]._gameTask = gameTask;
    [TaskSet sharedInstance]._endTask = endTask;
    
    [logoTask release];
    [beginTask release];
    [gameTask release];
    [endTask release];
    
    [[TaskSet sharedInstance]._logoTask Start];
    
    self.window.rootViewController = m_gameApp.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}
 
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    [m_gameApp release];
}


@end
