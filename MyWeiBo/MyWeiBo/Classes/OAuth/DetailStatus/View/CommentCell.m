//
//  CommentCell.m
//  MyWeiBo
//
//  Created by ZYmac on 14-10-8.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "CommentCell.h"
#import "IconView.h"
#import "Comment.h"
#import "CommentCellFrame.h"
#import "User.h"

@interface CommentCell (){
    IconView *_headerIcon;//头像
    UILabel *_screenName;//昵称
    UILabel *_createTime;//创建时间
    UILabel *_statuseText;//内容
    UIImageView *_MBIcon;
}

@end

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加评论内容控件
        [self addCommentView];
    }
    return self;
}

-(void)addCommentView{
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

-(void)setCommentCellFrame:(CommentCellFrame *)commentCellFrame{
    
    Comment *comment = commentCellFrame.comment;
    
    _headerIcon.frame = commentCellFrame.iconFrame;
    _headerIcon.user = comment.user;
    
    //昵称
    if (comment.user.mbrank) {
        _screenName.textColor = kMBScreenNameColor;
        _MBIcon.hidden = NO;
        _MBIcon.frame = commentCellFrame.MBIconFrame;
        _MBIcon.image = [UIImage imageNamed:@"common_icon_membership"];
    }else{
        _MBIcon.hidden = YES;
        _screenName.textColor = kScreenNameColor;
    }
    _screenName.frame = commentCellFrame.screenNameFrame;
    _screenName.text = comment.user.screenName;
    
    _createTime.frame = commentCellFrame.timeFrame;
    _createTime.text = comment.createAt;
    
    _statuseText.frame = commentCellFrame.textFrame;
    _statuseText.text = comment.text;

}

@end
