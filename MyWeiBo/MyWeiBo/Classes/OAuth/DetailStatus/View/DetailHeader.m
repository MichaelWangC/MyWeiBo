//
//  DetailHeader.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-26.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DetailHeader.h"

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
    UIImage *headerBg = [UIImage imageNamed:@"statusdetail_comment_top_background"];
    headerBg = [headerBg stretchableImageWithLeftCapWidth:headerBg.size.width * 0.5 topCapHeight:headerBg.size.height * 0.5];
    _contentView.image = headerBg;
}

+(CGFloat)DetailHeaderHeight{
    return kDetailHeaderHeight + kCellPaddingWidth;
}

@end
