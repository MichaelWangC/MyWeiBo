//
//  OAuthController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-10.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "OAuthController.h"
#import "MBProgressHUD.h"
#import "HttpTool.h"
#import "AccessTokenTool.h"
#import "MainController.h"

@interface OAuthController ()<UIWebViewDelegate>{
    UIWebView *_oauthWebView;
}

@end

@implementation OAuthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"微博授权";
    
    CGFloat webWidth = self.view.frame.size.width;
    CGFloat webHeight = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height;
    webHeight -= IOS7?20:0;
    CGRect webViewRect = (CGRect){CGPointZero,{webWidth,webHeight}};
    _oauthWebView = [[UIWebView alloc]initWithFrame:webViewRect];
    _oauthWebView.delegate = self;
    [self.view addSubview:_oauthWebView];
    
    NSURL *oauthURL = [NSURL URLWithString:KAuthorizeUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:oauthURL];
    [request setHTTPMethod:@"Post"];
    NSString *postString = [NSString stringWithFormat:@"client_id=%@&redirect_uri=%@&display=mobile",KAppKey,KRedirectUrl];
    NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    [_oauthWebView loadRequest:request];
}

#pragma mark webDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"网页加载中...";
    hud.dimBackground = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //全路径
    NSString *strUrl = request.URL.absoluteString;
    
    NSRange range = [strUrl rangeOfString:@"code="];
    if (range.length != 0) {
        NSInteger index = range.location+range.length;
        NSString *code = [strUrl substringFromIndex:index];
        
        //获取access_token
        [self getAccessToken:code];
        return NO;
    }
    
    return YES;
}

#pragma mark 获取access_token
-(void)getAccessToken:(NSString *)requestToken{

    
    NSDictionary *dict = @{
               @"client_id" : KAppKey,
           @"client_secret" : KAppSecret,
              @"grant_type" : @"authorization_code",
                    @"code" : requestToken,
            @"redirect_uri" : KRedirectUrl
    };

    [HttpTool postWithUrl:KAccessTokenUrl parameters:dict success:^(id responseObject) {
        //保存access_token
        AccessToken *accessToken = [[AccessToken alloc]init];
        accessToken.accessToken = responseObject[@"access_token"];
        accessToken.uid = responseObject[@"uid"];
        [[AccessTokenTool shareAccessTokenTool]saveAccessToken:accessToken];
        
        //回到主界面
        MainController *main = [[MainController alloc]init];
        [self presentViewController:main animated:YES completion:nil];
        self.navigationController.view.window.rootViewController = main;
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"请求失败---",nil);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

@end
