//
//  Dock.h
//  MyWeiBo
//
//  Created by ZYmac on 14-8-29.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dock;

@protocol DockDelegate <NSObject>
@optional
- (void)dockWithItemSelectedFrom:(NSInteger)from to:(NSInteger)to;
@end

@interface Dock : UIView

// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;

@property (weak,nonatomic) id<DockDelegate> delegate;
-(void)selectedClickWithselectedIndex:(NSInteger)selectedIndex;

@end
