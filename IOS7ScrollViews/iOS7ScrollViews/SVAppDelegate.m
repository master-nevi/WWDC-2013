//
//  SVAppDelegate.m
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import "SVAppDelegate.h"
#import "SVViewController.h"

@implementation SVAppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    SVViewController * viewController = [[SVViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = viewController;
    [viewController release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
