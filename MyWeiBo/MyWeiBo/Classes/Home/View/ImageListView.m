//
//  ImageListView.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-17.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "ImageListView.h"
#import "HttpTool.h"

@interface ImageListView (){
    UIImage *_placeImage;
}

@end

@implementation ImageListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _placeImage = [UIImage imageNamed:@"timeline_image_loading"];
    }
    return self;
}

-(void)setPicUrls:(NSArray *)picUrls{
    NSInteger count = picUrls.count;
    NSInteger row,column,allColumn;
    //删除之前的子控件
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    if (count == 1) {
        //添加图片
        UIImageView *image = [[UIImageView alloc]init];
        CGFloat imageX = kImageListPadding;
        CGFloat imageY = kImageListPadding;
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.frame = (CGRect){{imageX,imageY},{kSingleImageW,kSingleImageH}};
        [HttpTool loadImageWithUrl:picUrls[0][@"thumbnail_pic"] place:_placeImage imageView:image];
        [self addSubview:image];
        return;
    }
    
    //图片列数
    if (count == 4) {
        allColumn = 2;
    }else{
        allColumn = 3;
    }
    
    for (int i = 0; i < count ; i++) {
        row = i / allColumn;
        column = i % allColumn;
        //添加图片
        UIImageView *image = [[UIImageView alloc]init];
        CGFloat imageX = kImageListPadding * (column + 1) + column * kImageW;
        CGFloat imageY = kImageListPadding * (row + 1) + row * kImageH;
        image.frame = (CGRect){{imageX,imageY},{kImageW,kImageH}};
        image.contentMode = UIViewContentModeScaleToFill;
        [HttpTool loadImageWithUrl:picUrls[i][@"thumbnail_pic"] place:_placeImage imageView:image];
        [self addSubview:image];
    }
    
}

+(CGSize)imageListSizeWithCount:(NSInteger)imageCount{
    
    CGFloat viewW,viewH;
    if (imageCount == 1) {
        viewW = kImageListPadding * 2 + kSingleImageW;
        viewH = kImageListPadding * 2 + kSingleImageH;
        return (CGSize){viewW,viewH};
    }
    
    //图片列数
    NSInteger allColumn;
    if (imageCount == 4) {
        allColumn = 2;
    }else{
        allColumn = 3;
    }
    
    NSInteger row = imageCount%allColumn;
    row = row?imageCount/allColumn+1:imageCount/allColumn;
    viewW = kImageListPadding * (allColumn + 1) + kImageW * allColumn;
    viewH = kImageListPadding * row + kImageH * row;
    return (CGSize){viewW,viewH};
    
}

@end
