//
//  RepostCell.m
//  MyWeiBo
//
//  Created by ZYmac on 14-10-8.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "RepostCell.h"
#import "IconView.h"
#import "Statuse.h"
#import "RepostCellFrame.h"
#import "User.h"

@interface RepostCell (){
    IconView *_headerIcon;//头像
    UILabel *_screenName;//昵称
    UILabel *_createTime;//创建时间
    UILabel *_statuseText;//内容
    UIImageView *_MBIcon;
}

@end

@implementation RepostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addStatuseView];
    }
    return self;
}

#pragma mark 添加微博内容
-(void)addStatuseView{
    _headerIcon = [[IconView alloc]init];
    [self.contentView addSubview:_headerIcon];
    
    _screenName = [[UILabel alloc]init];
    _screenName.font = kScreenNameFont;
    [self.contentView addSubview:_screenName];
    
    _MBIcon = [[UIImageView alloc]init];
    [self.contentView addSubview:_MBIcon];
    
    _createTime = [[UILabel alloc]init];
    _createTime.font = kTimeFont;
    [self.contentView addSubview:_createTime];
    
    _statuseText = [[UILabel alloc]init];
    _statuseText.font = kTextFont;
    _statuseText.numberOfLines = 0;
    [self.contentView addSubview:_statuseText];
    
}

-(void)setRepostCellFrame:(RepostCellFrame *)repostCellFrame{
    
    Statuse *statuse = repostCellFrame.statuse;
    
    _headerIcon.frame = repostCellFrame.iconFrame;
    _headerIcon.user = statuse.user;
    
    //昵称
    if (statuse.user.mbrank) {
        _screenName.textColor = kMBScreenNameColor;
        _MBIcon.hidden = NO;
        _MBIcon.frame = repostCellFrame.MBIconFrame;
        _MBIcon.image = [UIImage imageNamed:@"common_icon_membership"];
    }else{
        _MBIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    }
    _screenName.frame = repostCellFrame.screenNameFrame;
    _screenName.text = statuse.user.screenName;
    
    _createTime.frame = repostCellFrame.timeFrame;
    _createTime.text = statuse.createAt;
    
    _statuseText.frame = repostCellFrame.textFrame;
    _statuseText.text = statuse.text;
}

@end
