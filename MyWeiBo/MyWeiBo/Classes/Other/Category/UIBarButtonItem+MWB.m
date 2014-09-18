//
//  UIBarButtonItem+MWB.m
//  MyWeiBo
//
//  Created by ZYmac on 14-8-30.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "UIBarButtonItem+MWB.h"

@implementation UIBarButtonItem (MWB)

- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //图片设置
    UIImage *image = [UIImage imageNamed:icon];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    
    btn.frame = (CGRect){CGPointZero,image.size};
    
    //添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action{
    return [[UIBarButtonItem alloc]initWithIcon:icon highlightedIcon:highlighted target:target action:action];
}

@end
