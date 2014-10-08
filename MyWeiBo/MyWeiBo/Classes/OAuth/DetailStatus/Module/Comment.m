//
//  Comment.m
//  MyWeiBo
//
//  Created by ZYmac on 14-10-8.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment
-(id)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        _ID = [dict[@"id"] longLongValue];
        _text = dict[@"text"];
        [self setCreateAt:dict[@"created_at"]];

        _user = [[User alloc]initWithDict:dict[@"user"]];
        
    }
    return self;
}
@end
