//
//  BaseText.h
//  MyWeiBo
//
//  Created by ZYmac on 14-10-9.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface BaseText : NSObject

@property (nonatomic,assign) long long ID;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *createAt;
@property (nonatomic,strong) User *user;

-(id)initWithDict:(NSDictionary *)dict;

@end
