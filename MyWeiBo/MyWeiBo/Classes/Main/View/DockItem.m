//
//  DockItem.m
//  MyWeiBo
//
//  Created by ZYmac on 14-8-29.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DockItem.h"

#define kDockItemSelectedBG @"tabbar_slider.png"
#define kTitleRatio 0.3 // 文字的高度比例

@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.shadowOffset = CGSizeZero;
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置选中时的背景
        [self setBackgroundImage:[UIImage imageNamed:kDockItemSelectedBG] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{
    
}
#pragma mark 调整内部ImageView的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * (1 - kTitleRatio);
    return CGRectMake(0, 0, imageWidth, imageHeight);
}
#pragma mark 调整内部UILabel的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * (1 - kTitleRatio);
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    return CGRectMake(0, titleY, titleWidth, titleHeight);
}
@end
