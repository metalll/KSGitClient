//
//  AppDelegate.m
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#import "AppDelegate.h"
#import "NSDNavigatorController.h"
#import "NSDMenuViewController.h"
#import "NSDNotificationsViewController.h"
#import "NSDNewsViewController.h"
#import "NSDBaseViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    NSDMenuViewController *leftMenu = (NSDMenuViewController*)[mainStoryboard                                                                 instantiateViewControllerWithIdentifier: @"Menu"];
    
    NSDNotificationsViewController * rightMenu = (NSDNotificationsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"Notifications"];
    
    NSDNavigatorController * navigatorVC =  [NSDNavigatorController sharedInstance];
    
    navigatorVC.rightMenu = rightMenu;
    navigatorVC.leftMenu = leftMenu;
    navigatorVC.menuRevealAnimationDuration = .18;
    
    
    UIButton *buttonMenu  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [buttonMenu setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [buttonMenu addTarget:[NSDNavigatorController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonMenu];
    navigatorVC.leftBarButtonItem = leftBarButtonItem;
    
    UIButton *buttonNotif  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [buttonNotif setImage:[UIImage imageNamed:@"notif"] forState:UIControlStateNormal];
    [buttonNotif addTarget:[NSDNavigatorController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonNotif];
    navigatorVC.rightBarButtonItem = rightBarButtonItem;

    

    
  
    return YES;
}




- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    
    return NO;
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

@end
