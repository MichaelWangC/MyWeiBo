//
//  HttpTool.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation HttpTool

+(void)requestWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString*)method{
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]requestWithMethod:method URLString:url parameters:dict error:nil];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (nil == success) return;
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (nil == success) return;
        failure(error);
    }];
    [op start];
    
}

+(void)getWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    [HttpTool requestWithUrl:url parameters:dict success:success failure:failure method:@"GET"];
}

+(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    [HttpTool requestWithUrl:url parameters:dict success:success failure:failure method:@"POST"];
}

+(void)loadImageWithUrl:(NSString *)imageUrl place:(UIImage *)place imageView:(UIImageView *)imageView{
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:place options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

@end
