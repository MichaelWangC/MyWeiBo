//
//  DetailHeader.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-26.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>



@class Statuse;
@interface DetailHeader : UIView

@property (nonatomic,strong) Statuse *status;
+(CGFloat)DetailHeaderHeight;

@end
