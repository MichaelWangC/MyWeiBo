//
//  DetailStatusCellFrame.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-29.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DetailStatusCellFrame.h"

@implementation DetailStatusCellFrame

-(void)setStatuse:(Statuse *)statuse{
    [super setStatuse:statuse];
    
    _cellHeight += kCellMargin;
}

@end
