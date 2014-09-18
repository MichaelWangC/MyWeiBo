//
//  AccessToken.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken

//归档
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_accessToken forKey:@"accessToken"];
    [aCoder encodeObject:_uid forKey:@"uid"];
}
@end
