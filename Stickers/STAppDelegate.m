//
// STAppDelegate.m
// Stickers
//
// Created by Tomi De Lucca on 3/24/18.
// Copyright © 2018 Tomi De Lucca. All rights reserved.
//

#import "STAppDelegate.h"

#import "STMainStickersCollectionViewController.h"

@implementation STAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	UIViewController *root = [STMainStickersCollectionViewController new];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	[self.window setRootViewController:nav];
	[self.window makeKeyAndVisible];

	return YES;
}

@end
