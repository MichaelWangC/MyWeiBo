//
//  StatusCellFrame.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "StatusCellFrame.h"
#import "IconView.h"
#import "ImageListView.h"
#import "Statuse.h"

@implementation StatusCellFrame

-(void)setStatuse:(Statuse *)status{
    
    [super setStatuse:status];
    
    //微博底部dock
    CGFloat dockX = 0;
    CGFloat dockY = _cellHeight;
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    _statusDockFrame = (CGRect){{dockX,dockY},{cellWidth,kStatusDockHeight}};
    
    //整个cell的高度
    _cellHeight += kStatusDockHeight + kCellMargin;

}

@end
