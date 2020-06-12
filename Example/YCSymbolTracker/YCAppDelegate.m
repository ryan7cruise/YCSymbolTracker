//
//  YCAppDelegate.m
//  YCSymbolTracker
//
//  Created by 彭雨晨 on 06/12/2020.
//  Copyright (c) 2020 彭雨晨. All rights reserved.
//

#import "YCAppDelegate.h"
#import "YCViewController.h"
#import "Demo-Swift.h"
#import <YCSymbolTracker/YCSymbolTracker.h>
#import <SDWebImage/SDWebImage.h>
//#import "SDWebImage.h"

@implementation YCAppDelegate

+ (void)load {
    NSLog(@"%s", __FUNCTION__);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YCViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [SwiftDemo swiftTestLoad];
    
    [SDWebImageManager.sharedManager cancelAll];
    
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"demo.order"];
    NSLog(@"%@", filePath);
    [YCSymbolTracker exportSymbolsWithFilePath:filePath];
    
    return YES;
}
@end
