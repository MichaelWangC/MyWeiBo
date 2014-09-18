//
//  IconView.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-16.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@interface IconView : UIView

@property (nonatomic,strong) User *user;

-(void)setUser:(User *)user;
+(CGSize)IconViewSize;

@end
