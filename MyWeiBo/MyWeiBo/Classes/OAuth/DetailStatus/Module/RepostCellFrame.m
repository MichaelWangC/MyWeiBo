//
//  RepostCellFrame.m
//  MyWeiBo
//
//  Created by ZYmac on 14-10-8.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "RepostCellFrame.h"
#import "IconView.h"
#import "Statuse.h"
#import "User.h"

@implementation RepostCellFrame

-(void)setStatuse:(Statuse *)statuse{
    _statuse = statuse;
    // 利用微博数据，计算所有子控件的frame
    
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 头像
    CGFloat iconX = kCellPaddingWidth;
    CGFloat iconY = kCellPaddingWidth;
    CGSize iconSize = [IconView IconViewSize];
    _iconFrame = (CGRect){iconX, iconY, iconSize};
    
    // 昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellPaddingWidth;
    CGFloat screenNameY = iconY;
    CGSize screenNameSize = [statuse.user.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    //会员头像
    CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellPaddingWidth;
    CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) / 2;
    _MBIconFrame = (CGRect){{mbIconX,mbIconY},{kMBIconW,kMBIconH}};
    
    // 时间
    CGSize timeSize = [statuse.createAt sizeWithFont:kTimeFont];
    CGFloat timeX = screenNameX;
    CGFloat timeY = iconY + iconSize.height / 2;
    _timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_timeFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellPaddingWidth;
    CGSize textSize = [statuse.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth - 2 * kCellPaddingWidth, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    _cellHeight = kCellMargin;
    _cellHeight += CGRectGetMaxY(_textFrame);
}

@end
