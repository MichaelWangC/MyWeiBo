//
//  ImageListView.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-17.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListView : UIView

@property (nonatomic,strong) NSArray *picUrls;

+(CGSize)imageListSizeWithCount:(NSInteger)imageCount;

@end
