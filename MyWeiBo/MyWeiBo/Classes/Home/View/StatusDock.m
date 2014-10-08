//
//  StatusDock.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-17.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "StatusDock.h"
#import "Statuse.h"

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
    //设置文字距离左边图片的距离
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //取消点击阴影
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_middlebottom_highlighted"] forState:UIControlStateHighlighted];
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 3;
    btn.frame = (CGRect){{btnW * index,0},{btnW,kStatusDockHeight}};
    [self addSubview:btn];

    //添加分割线
    if (index) {
        UIImage *lineImage = [UIImage imageNamed:@"timeline_card_bottom_line"];
        UIImageView *line = [[UIImageView alloc]initWithImage:lineImage];
        line.center = CGPointMake(btnW * index, kStatusDockHeight * 0.5);
        [self addSubview:line];
    }
    
    return btn;
}

-(void)setStatus:(Statuse *)status{
    [self setNumberWithBtn:_repost count:status.repostsCount];
    [self setNumberWithBtn:_comment count:status.commentsCount];
    [self setNumberWithBtn:_attitute count:status.attitudesCount];
}

-(void)setNumberWithBtn:(UIButton *)btn count:(NSInteger)count{
    if (count == 0) return;
    NSString *title;
    if (count < 10000) {
        title = [NSString stringWithFormat:@"%ld",(long)count];
    }else{
        title = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
        //字符串替换
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
