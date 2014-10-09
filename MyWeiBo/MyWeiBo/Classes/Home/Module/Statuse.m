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
    
    if (self = [super initWithDict:dict]) {

        _picUrls = dict[@"pic_urls"];
        NSDictionary *retweeted = dict[@"retweeted_status"];
        if (retweeted) {
            _retweetedStatus = [[Statuse alloc]initWithDict:retweeted];
        }
        
        _repostsCount = [dict[@"reposts_count"] integerValue];
        _commentsCount = [dict[@"comments_count"] integerValue];
        _attitudesCount = [dict[@"attitudes_count"] integerValue];
        
    }
    return self;
}

@end
