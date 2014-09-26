//
//  StatuseCell.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "StatuseCell.h"
#import "HttpTool.h"
#import "IconView.h"
#import "ImageListView.h"
#import "StatusDock.h"

@interface StatuseCell (){
    IconView *_headerIcon;//头像
    UILabel *_screenName;//昵称
    UILabel *_createTime;//创建时间
    UILabel *_statuseText;//内容
    ImageListView *_pics;//配图
    UIImageView *_MBIcon;
    StatusDock *_statusDock;
    
    UIView *_retweetedView;//转发界面
    UILabel *_retweetedScreenName;//转发昵称
    UILabel *_retweetedText;
    ImageListView *_retweetedPics;//配图
}

@end

@implementation StatuseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加微博内容
        [self addStatuseView];
        //添加转发微博内容
        [self addRewteetedView];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
//    NSLog(@"setCellFrame------",nil);
//    NSLog(@"%f,%f",frame.origin.y,frame.size.height);
//    frame.origin.x = kTableBorderWidth;
    frame.origin.y += kTableBorderWidth;//整体向下 移动
//    frame.size.width -= kTableBorderWidth * 2;
    frame.size.height -= kCellMargin;
    [super setFrame:frame];
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
    
    _pics = [[ImageListView alloc]init];
    [self.contentView addSubview:_pics];
    
    _statusDock = [[StatusDock alloc]init];
    [self.contentView addSubview:_statusDock];
}

#pragma mark 添加转发内容
-(void)addRewteetedView{
    _retweetedView = [[UIView alloc]init];
    [self.contentView addSubview:_retweetedView];
    
    _retweetedScreenName = [[UILabel alloc]init];
    _retweetedScreenName.font = kRetweetedScreenNameFont;
    [_retweetedView addSubview:_retweetedScreenName];
    
    _retweetedText = [[UILabel alloc]init];
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.numberOfLines = 0;
    [_retweetedView addSubview:_retweetedText];
    
    _retweetedPics = [[ImageListView alloc]init];
    [_retweetedView addSubview:_retweetedPics];
}

//设置frame 同事设置内容
-(void)setCellFrame:(StatusCellFrame *)cellFrame{
    
    Statuse *statuse = cellFrame.statuse;
    
    _headerIcon.frame = cellFrame.iconFrame;
    _headerIcon.user = statuse.user;
    
    //昵称
    if (statuse.user.mbrank) {
        _screenName.textColor = kMBScreenNameColor;
        _MBIcon.hidden = NO;
        _MBIcon.frame = cellFrame.MBIconFrame;
        _MBIcon.image = [UIImage imageNamed:@"common_icon_membership"];
    }else{
        _MBIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    }
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = statuse.user.screenName;
    
    _createTime.frame = cellFrame.timeFrame;
    _createTime.text = statuse.createAt;
    
    _statuseText.frame = cellFrame.textFrame;
    _statuseText.text = statuse.text;

    if (statuse.picUrls.count) {
        _pics.hidden = NO;
        _pics.picUrls = statuse.picUrls;
        _pics.frame = cellFrame.picFrame;
    }else{
        _pics.hidden = YES;
    }
    
    if (statuse.retweetedStatus) {
        _retweetedView.hidden = NO;
        _retweetedView.frame = cellFrame.retweetedFrame;
        //设置转发背景
        _retweetedView.backgroundColor = kRetweetedBg;
        
        _retweetedScreenName.frame = cellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = [NSString stringWithFormat:@"@%@",statuse.retweetedStatus.user.screenName];
        _retweetedScreenName.textColor = kRetweetedScreenNameColor;
        _retweetedScreenName.backgroundColor = [UIColor clearColor];
        
        _retweetedText.frame = cellFrame.retweetedTextFrame;
        _retweetedText.text = statuse.retweetedStatus.text;
        _retweetedText.backgroundColor = [UIColor clearColor];
        
        if (statuse.retweetedStatus.picUrls.count) {
            _retweetedPics.hidden = NO;
            _retweetedPics.frame = cellFrame.retweetedpicFrame;
            _retweetedPics.picUrls = statuse.retweetedStatus.picUrls;
        }else{
            _retweetedPics.hidden = YES;
        }
    }else{
        _retweetedView.hidden = YES;
    }
    
    //statusDock
    _statusDock.frame = cellFrame.statusDockFrame;
    _statusDock.status = statuse;
}

@end
