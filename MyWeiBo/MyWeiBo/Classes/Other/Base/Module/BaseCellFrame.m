//
//  BaseCellFrame.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-29.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "BaseCellFrame.h"
#import "IconView.h"
#import "ImageListView.h"
#import "Statuse.h"
#import "User.h"

@implementation BaseCellFrame

-(void)setStatuse:(Statuse *)status{
    
    _statuse = status;
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
    CGSize screenNameSize = [status.user.screenName sizeWithFont:kScreenNameFont];
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    //会员头像
    CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellPaddingWidth;
    CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) / 2;
    _MBIconFrame = (CGRect){{mbIconX,mbIconY},{kMBIconW,kMBIconH}};
    
    // 时间
    CGSize timeSize = [status.createAt sizeWithFont:kTimeFont];
    CGFloat timeX = screenNameX;
    CGFloat timeY = iconY + iconSize.height / 2;
    _timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_timeFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellPaddingWidth;
    CGSize textSize = [status.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth - 2 * kCellPaddingWidth, MAXFLOAT)];
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    if (status.picUrls.count) { // 有配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textFrame) + kCellPaddingWidth;
        CGSize picSize = [ImageListView imageListSizeWithCount:status.picUrls.count];
        _picFrame = (CGRect){{imageX,imageY},picSize};
    } else if (status.retweetedStatus) { // 有转发的微博
        // 被转发微博整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) + kCellPaddingWidth;
        CGFloat retweetWidth = cellWidth;
        CGFloat retweetHeight = kCellPaddingWidth;
        
        // 被转发微博的昵称
        CGFloat retweetedScreenNameX = kCellPaddingWidth;
        CGFloat retweetedScreenNameY = kCellPaddingWidth;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweetedStatus.user.screenName];
        CGSize retweetedScreenNameSize = [name sizeWithFont:kRetweetedScreenNameFont];
        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameX, retweetedScreenNameY}, retweetedScreenNameSize};
        
        // 被转发微博的内容
        CGFloat retweetedTextX = retweetedScreenNameX;
        CGFloat retweetedTextY = CGRectGetMaxY(_retweetedScreenNameFrame) + kCellPaddingWidth;
        CGSize retweetedTextSize = [status.retweetedStatus.text sizeWithFont:kRetweetedTextFont constrainedToSize:CGSizeMake(retweetWidth - 2 * kCellPaddingWidth, MAXFLOAT)];
        _retweetedTextFrame = (CGRect){{retweetedTextX, retweetedTextY}, retweetedTextSize};
        
        // 被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextFrame) + kCellPaddingWidth;
            CGSize picSize = [ImageListView imageListSizeWithCount:status.retweetedStatus.picUrls.count];
            _retweetedpicFrame = (CGRect){{retweetedImageX,retweetedImageY},picSize};
            
            retweetHeight += CGRectGetMaxY(_retweetedpicFrame);
        } else {
            retweetHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        
        _retweetedFrame = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }

    // 整个cell的高度
    _cellHeight = kCellMargin;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_picFrame);
    } else if (status.retweetedStatus) {
        _cellHeight += CGRectGetMaxY(_retweetedFrame);
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
    
}


@end
