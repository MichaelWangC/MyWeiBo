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
        
        UIButton *repost = [[UIButton alloc]init];
        [repost setTitle:@"转发" forState:UIControlStateNormal];
        [repost setTitleColor:kColor(235, 235, 235) forState:UIControlStateNormal];
        repost.titleLabel.font = kTextFont;
        [repost setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 3;
        repost.frame = (CGRect){{0,0},{btnW,kStatusDockHeight}};
        [self addSubview:repost];
        _repost = repost;
        
    }
    return self;
}



@end
