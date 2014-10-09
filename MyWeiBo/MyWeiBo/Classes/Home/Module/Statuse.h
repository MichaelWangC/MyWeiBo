//
//  Statuse.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "BaseText.h"

@class User;
@interface Statuse : BaseText

@property (nonatomic,strong) NSArray *picUrls;
@property (nonatomic,strong) Statuse *retweetedStatus;

@property (nonatomic,assign) NSInteger repostsCount;
@property (nonatomic,assign) NSInteger commentsCount;
@property (nonatomic,assign) NSInteger attitudesCount;

@end
