//
//  AppDelegate.m
//  Stickers
//
//  Created by Tomi De Lucca on 3/24/18.
//  Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "AppDelegate.h"

#import "MainStickersCollectionViewController.h"

#import <DKNightVersion/DKNightVersion.h>

static NSString * const kThemeFile = @"Themes.txt";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupTheme];
    
    UIViewController *root = [MainStickersCollectionViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupTheme
{
    [[DKNightVersionManager sharedManager] setThemeVersion:DKThemeVersionNormal];
    [[DKColorTable sharedColorTable] setFile:kThemeFile];
}

@end
