//
//  DetailHeader.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-26.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DetailHeader.h"
#import "UIImage+MWB.h"
#import "Statuse.h"

@interface DetailHeader (){
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitute;
    
    UIImageView *_contentView;
    UIImageView *_arrow;
}

@end

@implementation DetailHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kGlobalBg;
        //添加界面
        [self addContentView];
        //调整位置
        [self setContentFrame];
    }
    return self;
}

#pragma mark 添加界面
-(void)addContentView{
    
    _contentView = [[UIImageView alloc]init];
    _contentView.userInteractionEnabled = YES;
    [self addSubview:_contentView];
    
    _repost = [[UIButton alloc]init];
    [_contentView addSubview:_repost];
    
    _comment = [[UIButton alloc]init];
    [_contentView addSubview:_comment];
    
    _attitute = [[UIButton alloc]init];
    [_contentView addSubview:_attitute];
    
    _arrow = [[UIImageView alloc]init];
    [_contentView addSubview:_arrow];
    
}

-(void)setContentFrame{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _contentView.frame = CGRectMake(0, kCellPaddingWidth, width, kDetailHeaderHeight);
    _contentView.image = [UIImage resizedImage:@"statusdetail_comment_top_background" xPos:0.5 yPos:0.5];
    //按钮设置
    CGFloat btnWidth = width / 3;
    _repost.frame = CGRectMake(0, 0, btnWidth, kDetailHeaderHeight);
    _comment.frame = CGRectMake(btnWidth, 0, btnWidth, kDetailHeaderHeight);
    _attitute.frame = CGRectMake(btnWidth * 2, 0 , btnWidth, kDetailHeaderHeight);
    
}

-(void)setStatus:(Statuse *)status{
    _status = status;
    [self setTitleWithBtn:_repost title:@"转发" count:status.repostsCount];
    [self setTitleWithBtn:_comment title:@"评论" count:status.commentsCount];
    [self setTitleWithBtn:_attitute title:@"赞" count:status.attitudesCount];
}

-(void)setTitleWithBtn:(UIButton *)btn title:(NSString *)btnTitle count:(NSInteger)count{
    NSString *title;
    if (count < 10000) {
        title = [NSString stringWithFormat:@"%d",count];
    }else{
        title = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
        //字符串替换
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    title = [NSString stringWithFormat:@"%@ %@",btnTitle,title];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kScreenNameColor forState:UIControlStateNormal];
    btn.titleLabel.font = kTextFont;
}


+(CGFloat)DetailHeaderHeight{
    return kDetailHeaderHeight + kCellPaddingWidth;
}

@end
