//
//  User.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _screenName = dict[@"screen_name"];
        _profileImageUrl = dict[@"profile_image_url"];
        
        _verified = [dict[@"verified"] boolValue];
        _verifiedType = [dict[@"verified_type"] intValue];
        _mbrank = [dict[@"mbrank"] intValue];
        _mbtype = [dict[@"mbtype"] intValue];
    }
    return self;
}

@end
