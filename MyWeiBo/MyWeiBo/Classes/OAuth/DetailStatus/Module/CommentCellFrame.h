//
//  CommentCellFrame.h
//  MyWeiBo
//
//  Created by ZYmac on 14-10-8.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comment;
@interface CommentCellFrame : NSObject

@property (nonatomic,strong) Comment *comment;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度

@property (nonatomic, readonly) CGRect iconFrame; // 头像的frame

@property (nonatomic, readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic, readonly) CGRect MBIconFrame; // 会员图标
@property (nonatomic, readonly) CGRect timeFrame; // 时间
@property (nonatomic, readonly) CGRect textFrame; // 内容

@end
