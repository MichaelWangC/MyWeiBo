//
//  UIBarButtonItem+MWB.h
//  MyWeiBo
//
//  Created by ZYmac on 14-8-30.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MWB)
- (id)initWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
@end
