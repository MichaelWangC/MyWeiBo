//
//  DetailHeader.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-26.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Statuse,DetailHeader;
typedef enum {
    DetailHeaderBtnTypeRepost, // 转发
    DetailHeaderBtnTypeComment, // 评论
} DetailHeaderBtnType;

@protocol DetailHeadDelegate <NSObject>
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index;
@end

@interface DetailHeader : UIView

@property (nonatomic,strong) Statuse *status;
@property (nonatomic,assign) DetailHeaderBtnType currentBtnType;
@property (nonatomic,assign) id<DetailHeadDelegate> delegate;

+(CGFloat)DetailHeaderHeight;

@end
