//
//  YCViewController.m
//  YCLaunchSymbolTracker
//
//  Created by 彭雨晨 on 06/10/2020.
//  Copyright (c) 2020 彭雨晨. All rights reserved.
//

#import "YCViewController.h"

@interface YCViewController ()

@end

@implementation YCViewController

+ (void)load {
    NSLog(@"%s", __FUNCTION__);
    test();
}

void(^block)(void) = ^(void){
    
};

void test()
{
    block();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
