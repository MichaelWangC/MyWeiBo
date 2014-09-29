//
//  BaseCellFrame.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-29.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Statuse;
@interface BaseCellFrame : NSObject{
    Statuse *_statuse;
    CGFloat _cellHeight;
}

@property (nonatomic,strong) Statuse *statuse;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect iconFrame; // 头像的frame

@property (nonatomic, readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic, readonly) CGRect MBIconFrame; // 会员图标
@property (nonatomic, readonly) CGRect timeFrame; // 时间
@property (nonatomic, readonly) CGRect textFrame; // 内容
@property (nonatomic, readonly) CGRect picFrame; // 配图

@property (nonatomic, readonly) CGRect retweetedFrame; // 被转发微博的父控件
@property (nonatomic, readonly) CGRect retweetedScreenNameFrame; // 被转发微博作者的昵称
@property (nonatomic, readonly) CGRect retweetedTextFrame; // 被转发微博的内容
@property (nonatomic, readonly) CGRect retweetedpicFrame; // 被转发微博的配图

@end
