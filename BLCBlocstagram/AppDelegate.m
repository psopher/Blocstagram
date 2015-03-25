//
//  AppDelegate.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "AppDelegate.h"
#import "BLCImagesTableViewController.h"

#import "BLCLoginViewController.h"
#import "BLCDataSource.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [BLCDatasource sharedInstance]; // create the data source (so it can receive the access token notification)
    UINavigationController *navVC = [[UINavigationController alloc] init];
    
    if (![BLCDatasource sharedInstance].accessToken) {

    BLCLoginViewController *loginVC = [[BLCLoginViewController alloc] init];
    [navVC setViewControllers:@[loginVC] animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:BLCLoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        BLCImagesTableViewController *imagesVC = [[BLCImagesTableViewController alloc] init];
        [navVC setViewControllers:@[imagesVC] animated:YES];
    }];
    
    } else {
        BLCImagesTableViewController *imagesVC = [[BLCImagesTableViewController alloc] init];
        [navVC setViewControllers:@[imagesVC] animated:YES];
    };
    
    self.window.rootViewController = navVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
