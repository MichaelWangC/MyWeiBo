//
//  MoreController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-2.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#pragma mark 这个类只用在MoreController
@interface LogutBtn : UIButton
@end

@implementation LogutBtn
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat x = 10;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width - 2 * x;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height;
    return CGRectMake(x, y, width, height);
}
@end

#import "MoreController.h"
#import "UIImage+MWB.h"
#import "HttpTool.h"
#import "AccessTokenTool.h"
#import "OAuthController.h"
#import "MWBNavigationController.h"
#import "MBProgressHUD.h"

@interface MoreController (){
    NSArray *_titles;
}

@end

@implementation MoreController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"更多";
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
    _titles = [NSArray arrayWithContentsOfURL:url];
    
    // 3.要在tableView底部添加一个按钮
    LogutBtn *logout = [LogutBtn buttonWithType:UIButtonTypeCustom];
    // 设置背景图片
    [logout setImage:[UIImage resizedImage:@"common_button_big_red.png"] forState:UIControlStateNormal];
    [logout setImage:[UIImage resizedImage:@"common_button_big_red_highlighted.png"] forState:UIControlStateHighlighted];
    // tableFooterView的宽度是不需要设置。默认就是整个tableView的宽度
    logout.bounds = CGRectMake(0, 0, 0, 44);
    // 4.设置按钮文字
    logout.titleLabel.textAlignment = NSTextAlignmentCenter;
    [logout setTitle:@"退出登录" forState:UIControlStateNormal];
    
    //添加事件 取消授权
    [logout addTarget:self action:@selector(revokeOAuth) forControlEvents:UIControlEventTouchUpInside];
    //    logout.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.tableView.tableFooterView = logout;
    
    // 增加底部额外的滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

#pragma mark 取消授权
-(void)revokeOAuth{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"取消授权中...";
    hud.dimBackground = YES;
    //删除版本号
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:(NSString *)kCFBundleVersionKey];
    //删除accessToken
    [[AccessTokenTool shareAccessTokenTool] deleteAccessToken];
    //取消授权
    [HttpTool getWithUrl:KRevokeOauthUrl parameters:@{
                @"access_token":[AccessTokenTool shareAccessTokenTool].account.accessToken
    } success:^(id responseObject) {
        //跳转授权页面
        OAuthController *oauth = [[OAuthController alloc]init];
        MWBNavigationController *mwb = [[MWBNavigationController alloc]initWithRootViewController:oauth];
        [self presentViewController:mwb animated:YES completion:nil];
        self.navigationController.parentViewController.view.window.rootViewController = mwb;
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _titles[section];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 10;
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenCell = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idenCell];
    }
    
    NSDictionary *dictionary = _titles[indexPath.section][indexPath.row];
    cell.textLabel.text = [dictionary objectForKey:@"name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
