//
//  Statuse.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "Statuse.h"
#import "User.h"

@implementation Statuse

-(id)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        _ID = [dict[@"id"] longLongValue];
        _text = dict[@"text"];
        [self setCreateAt:dict[@"created_at"]];
        _picUrls = dict[@"pic_urls"];
        NSDictionary *retweeted = dict[@"retweeted_status"];
        if (retweeted) {
            _retweetedStatus = [[Statuse alloc]initWithDict:retweeted];
        }
        
        _user = [[User alloc]initWithDict:dict[@"user"]];
        
        _repostsCount = [dict[@"reposts_count"] integerValue];
        _commentsCount = [dict[@"comments_count"] integerValue];
        _attitudesCount = [dict[@"attitudes_count"] integerValue];
        
    }
    return self;
}

-(void)setCreateAt:(NSString *)createAt{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss zzzz yyyy"];
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [formatter dateFromString:createAt];

    NSTimeInterval sinceTime = -[date timeIntervalSinceNow];
    
    if (sinceTime < 60) {
        _createAt = [NSString stringWithFormat:@"刚刚"];
    }else if (sinceTime < 60*60){
        _createAt = [NSString stringWithFormat:@"%.f分钟前",sinceTime / 60];
    }else if (sinceTime < 60*60*24){
        _createAt = [NSString stringWithFormat:@"%.f小时前",sinceTime / 60 /60];
    }else{
        [formatter setDateFormat:@"MM-dd HH:mm:ss"];
        _createAt = [formatter stringFromDate:date];
    }
}

@end
