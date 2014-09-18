//
//  IconView.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-16.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "IconView.h"
#import "HttpTool.h"
#import "User.h"

@interface IconView (){
    UIImageView *_iconView;
    UIImageView *_verifiedView;
}

@end

@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconview = [[UIImageView alloc]init];
        [self addSubview:iconview];
        _iconView = iconview;
        
        UIImageView *verfView = [[UIImageView alloc]init];
        [self addSubview:verfView];
        _verifiedView = verfView;
    }
    return self;
}

-(void)setUser:(User *)user{
    
    _user = user;
    //设置图片
    [HttpTool loadImageWithUrl:user.profileImageUrl place:[UIImage imageNamed:@"avatar_default"] imageView:_iconView];
    
    NSString *verfImage = nil;
    switch (user.verifiedType) {
        case kVerifiedTypeNone:
            _verifiedView.hidden = YES;
            break;
        case kVerifiedTypePersonal:
            verfImage = @"avatar_vip.png";
            break;
        case kVerifiedTypeDaren:
            verfImage = @"avatar_grassroot.png";
            break;
        default:
            verfImage = @"avatar_enterprise_vip.png";
            break;
    }
    
    if (verfImage) {
        _verifiedView.hidden = NO;
        _verifiedView.image = [UIImage imageNamed:verfImage];
    }
    
    //设置frame
    _iconView.frame = (CGRect){CGPointZero,{kIconSmallW,kIconSmallH}};
    
    CGFloat verfX = kIconSmallW - kMBIconW * 0.5;
    CGFloat verfY = kIconSmallH - kMBIconH * 0.5;
    _verifiedView.frame = (CGRect){{verfX,verfY},{kMBIconW,kMBIconH}};

}

+(CGSize)IconViewSize{ 
    CGFloat iconW = kIconSmallW + kMBIconW * 0.5;
    CGFloat iconH = kIconSmallH + kMBIconH * 0.5;
    return (CGSize){iconW,iconH};
}

@end
