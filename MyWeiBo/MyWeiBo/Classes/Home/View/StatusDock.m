//
//  StatusDock.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-17.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "StatusDock.h"

@interface StatusDock (){
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitute;
}

@end

@implementation StatusDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _repost = [self addButtonWithTitle:@"转发" imageName:@"timeline_icon_retweet" index:0];
        _comment = [self addButtonWithTitle:@"评论" imageName:@"timeline_icon_comment" index:1];
        _attitute = [self addButtonWithTitle:@"赞" imageName:@"timeline_icon_unlike" index:2];
        
    }
    return self;
}

-(UIButton *)addButtonWithTitle:(NSString *)title imageName:(NSString *)imageName index:(NSInteger)index{
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColor(100, 100, 100) forState:UIControlStateNormal];
    btn.titleLabel.font = kTextFont;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 3;
    btn.frame = (CGRect){{btnW * index,0},{btnW,kStatusDockHeight}};
    [self addSubview:btn];

    return btn;
}

@end
