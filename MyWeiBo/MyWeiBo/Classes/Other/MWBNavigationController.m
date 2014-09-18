//
//  MWBNavigationController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-1.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "MWBNavigationController.h"

@interface MWBNavigationController ()

@end

@implementation MWBNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationBar *nvBar = [UINavigationBar appearance];
    [nvBar setTitleTextAttributes:@{
                                   UITextAttributeTextColor : [UIColor blackColor],
                            UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]//包装成对象，dictionary不能有结构体
                                    }];
    
    NSString *imageName;
    if (IOS7) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else{
        imageName = @"navigationbar_background";
        [nvBar setBackgroundImage:[UIImage imageNamed:imageName] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    self.navigationBar.translucent = NO;
    
}

@end
