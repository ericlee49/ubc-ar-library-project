//
//  AppDelegate.m
//  UBC-AR-Explore
//
//  Created by Eric Lee on 2017-07-04.
//  Copyright © 2017 Erics App House. All rights reserved.
//

#import "AppDelegate.h"

#import <easyar/engine.oc.h>

#import "ubcArExplore-Swift.h"

// EasyAR Developer Key
// add you own key here: (NSString * key)


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    if (![easyar_Engine initialize:key]) {
        NSLog(@"Initialization Failed.");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen ] bounds]];
    [[self window] makeKeyAndVisible];
    

    SplashViewController *splashVC = [[SplashViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:splashVC];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:233.0f/255.0f green:73.0f/255.0f blue:36.0f/255.0f alpha:1.0f];
    nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:20.0],NSFontAttributeName,
                                             [UIColor whiteColor], NSForegroundColorAttributeName,
                                             nil];
    
    self.window.rootViewController = nav;
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    if (self.blockRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    (void)application;
    [easyar_Engine onPause];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    (void)application;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    (void)application;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    (void)application;
    [easyar_Engine onResume];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    (void)application;
}



@end
