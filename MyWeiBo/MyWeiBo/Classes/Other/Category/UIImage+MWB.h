//
//  UIImage+MWB.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MWB)

+ (UIImage *)resizedImage:(NSString *)imgName;
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;

@end
