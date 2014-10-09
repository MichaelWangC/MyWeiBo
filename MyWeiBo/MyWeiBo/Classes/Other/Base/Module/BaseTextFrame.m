//
//  BaseTextFrame.m
//  MyWeiBo
//
//  Created by ZYmac on 14-10-9.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "BaseTextFrame.h"
#import "IconView.h"
#import "Comment.h"
#import "User.h"

@implementation BaseTextFrame

-(void)setBaseText:(BaseText *)baseText{
    _baseText = baseText;
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
    CGSize screenNameSize = [baseText.user.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    //会员头像
    CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellPaddingWidth;
    CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) / 2;
    _MBIconFrame = (CGRect){{mbIconX,mbIconY},{kMBIconW,kMBIconH}};
    
    // 时间
    CGSize timeSize = [baseText.createAt sizeWithFont:kTimeFont];
    CGFloat timeX = screenNameX;
    CGFloat timeY = iconY + iconSize.height / 2;
    _timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_timeFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellPaddingWidth;
    CGSize textSize = [baseText.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth - 2 * kCellPaddingWidth, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    _cellHeight = kCellMargin;
    _cellHeight += CGRectGetMaxY(_textFrame);
}

@end
