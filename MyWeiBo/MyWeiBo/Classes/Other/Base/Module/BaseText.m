//
//  BaseText.m
//  MyWeiBo
//
//  Created by ZYmac on 14-10-9.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "BaseText.h"
#import "User.h"

@implementation BaseText

-(id)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        _ID = [dict[@"id"] longLongValue];
        _text = dict[@"text"];
        [self setCreateAt:dict[@"created_at"]];
        
        _user = [[User alloc]initWithDict:dict[@"user"]];
        
    }
    return self;
}

-(NSString *)createAt{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzzz yyyy"];
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [formatter dateFromString:_createAt];
    
    NSTimeInterval sinceTime = -[date timeIntervalSinceNow];
    
    if (sinceTime < 60) {
        return @"刚刚";
    }else if (sinceTime < 60*60){
        return [NSString stringWithFormat:@"%.f分钟前",sinceTime / 60];
    }else if (sinceTime < 60*60*24){
        return [NSString stringWithFormat:@"%.f小时前",sinceTime / 60 /60];
    }else{
        [formatter setDateFormat:@"MM-dd HH:mm:ss"];
        return [formatter stringFromDate:date];
    }
}

@end
