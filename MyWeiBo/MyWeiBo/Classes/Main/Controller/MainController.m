//
//  MainController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-8-28.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "HomeController.h"
#import "MessageController.h"
#import "DiscoverController.h"
#import "MeController.h"
#import "MoreController.h"
#import "MWBNavigationController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //添加控制器
    [self addViewController];
    self.selectedIndex = 2;
}

#pragma mark 添加控制器
-(void)addViewController{

    HomeController *home = [[HomeController alloc]initWithStyle:UITableViewStylePlain];
    MWBNavigationController *nv = [[MWBNavigationController alloc]initWithRootViewController:home];
    [self addChildViewController:nv];
    [self.dock addItemWithIcon:@"tabbar_home" selectedIcon:@"tabbar_home_selected" title:@"首页"];
    
    MessageController *msg = [[MessageController alloc]init];
    MWBNavigationController *nv1 = [[MWBNavigationController alloc]initWithRootViewController:msg];
    [self addChildViewController:nv1];
    [self.dock addItemWithIcon:@"tabbar_message_center" selectedIcon:@"tabbar_message_center_selected" title:@"消息"];
    
    MeController *me = [[MeController alloc]init];
    MWBNavigationController *nv2 = [[MWBNavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:nv2];
    [self.dock addItemWithIcon:@"tabbar_profile" selectedIcon:@"tabbar_profile_selected" title:@"我"];
    
    DiscoverController *dis = [[DiscoverController alloc]init];
    MWBNavigationController *nv3 = [[MWBNavigationController alloc]initWithRootViewController:dis];
    [self addChildViewController:nv3];
    [self.dock addItemWithIcon:@"tabbar_discover" selectedIcon:@"tabbar_discover_selected" title:@"发现"];
    
    MoreController *more = [[MoreController alloc]initWithStyle:UITableViewStyleGrouped];
    MWBNavigationController *nv4 = [[MWBNavigationController alloc]initWithRootViewController:more];
    [self addChildViewController:nv4];
    [self.dock addItemWithIcon:@"tabbar_more" selectedIcon:@"tabbar_more_selected" title:@"更多"];
}

@end
