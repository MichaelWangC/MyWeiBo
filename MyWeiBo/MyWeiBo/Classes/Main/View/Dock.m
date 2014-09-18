//
//  Dock.m
//  MyWeiBo
//
//  Created by ZYmac on 14-8-29.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "Dock.h"
#import "DockItem.h"

@interface Dock (){
    DockItem *_selectItem;
    NSInteger _selectIndex;
}

@end

@implementation Dock

#pragma mark 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title{
    
    DockItem *dockItem = [[DockItem alloc]init];
    //设置标题
    [dockItem setTitle:title forState:UIControlStateNormal];
    //图片设置
    [dockItem setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [dockItem setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    //点击事件
    [dockItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    //添加item
    [self addSubview:dockItem];
    NSInteger itemCount = self.subviews.count;
    if (itemCount == 1) {
        [self itemClick:dockItem];
    }
    CGFloat itemWidth = self.frame.size.width / itemCount;
    CGFloat itemHeight = self.frame.size.height;
    for (int i = 0; i < itemCount; i++) {
        DockItem *m = self.subviews[i];
        m.frame = (CGRect){{itemWidth * i,0},{itemWidth,itemHeight}};
        m.tag = i;
    }
}
#pragma mark 监听item点击
-(void)itemClick:(DockItem *)sender{
    
    if ([_delegate respondsToSelector:@selector(dockWithItemSelectedFrom:to:)]) {
        [_delegate dockWithItemSelectedFrom:_selectIndex to:sender.tag];
    }
    
    _selectItem.selected = NO;
    //选中
    _selectItem = sender;
    sender.selected = YES;
    _selectIndex = sender.tag;
}

-(void)selectedClickWithselectedIndex:(NSInteger)selectedIndex{
    DockItem *dockItem = self.subviews[selectedIndex];
    [self itemClick:dockItem];
}

@end
