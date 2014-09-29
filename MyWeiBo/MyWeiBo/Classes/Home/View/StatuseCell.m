//
//  StatuseCell.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "StatuseCell.h"
#import "StatusDock.h"
#import "StatusCellFrame.h"

@interface StatuseCell (){

    StatusDock *_statusDock;
}

@end

@implementation StatuseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 操作条
        _statusDock = [[StatusDock alloc] init];
        [self.contentView addSubview:_statusDock];
    }
    return self;
}

//设置frame 同事设置内容
-(void)setCellFrame:(StatusCellFrame *)cellFrame{
    [super setCellFrame:cellFrame];
    //statusDock
    _statusDock.frame = cellFrame.statusDockFrame;
    _statusDock.status = cellFrame.statuse;
}

@end
