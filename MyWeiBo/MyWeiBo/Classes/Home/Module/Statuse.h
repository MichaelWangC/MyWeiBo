//
//  Statuse.h
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Statuse : NSObject

@property (nonatomic,assign) long long ID;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *createAt;
@property (nonatomic,strong) NSArray *picUrls;
@property (nonatomic,strong) Statuse *retweetedStatus;
@property (nonatomic,strong) User *user;

-(id)initWithDict:(NSDictionary *)dict;

@end
