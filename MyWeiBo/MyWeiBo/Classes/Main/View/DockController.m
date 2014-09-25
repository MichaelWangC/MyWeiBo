//
//  DockController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-1.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DockController.h"

@interface DockController ()<DockDelegate>

@end

@implementation DockController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dock = [[Dock alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight)];
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    [self.view addSubview:_dock];
    _dock.delegate = self;
    
}

#pragma mark dock代理
-(void)dockWithItemSelectedFrom:(NSInteger)from to:(NSInteger)to{
    
    if (to < 0 || to >=self.childViewControllers.count) return;
    
    //移除旧控制器
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    //添加新控制器
    UIViewController *new = self.childViewControllers[to];
    new.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kDockHeight);
    [self.view addSubview:new.view];
    _selectedIndex = to;
}

-(void)setSelecteIndexToController:(NSInteger)selecteIndexToController{
    
    if (selecteIndexToController < 0 || selecteIndexToController > self.childViewControllers.count) return;
    
    [_dock selectedClickWithselectedIndex:selecteIndexToController];
    _selectedIndex = selecteIndexToController;
}

@end
