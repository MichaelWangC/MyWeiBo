//
//  HomeController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-11.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "HomeController.h"
#import "UIBarButtonItem+MWB.h"
#import "HttpTool.h"
#import "AccessTokenTool.h"
#import "Statuse.h"
#import "MBProgressHUD.h"
#import "StatuseCell.h"
#import "StatusCellFrame.h"
#import "MJRefresh.h"
#import "DetailController.h"

#define kShowBtnHeight 44

@interface HomeController (){
    NSMutableArray *_statusesFrames;
}

@end

@implementation HomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"首页";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_compose" highlightedIcon:@"navigationbar_compose_highlighted" target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highlightedIcon:@"navigationbar_pop_highlighted" target:nil action:nil];
    
    self.tableView.backgroundColor = kGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //增加滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    _statusesFrames = [[NSMutableArray alloc]init];
    
    [self setupRefresh];
}

#pragma mark 集成刷新控件
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"正在刷新";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载";
}

#pragma mark 下拉刷新
-(void)headerRereshing{
    [self loadStatuseData];
}

#pragma mark 上拉新增
-(void)footerRereshing{
    [self loadMoreStatuseData];
}

#pragma mark 显示获取最新微博数量
-(void)showStatusCount:(NSInteger)count{
    
    NSString *showText = count?[NSString stringWithFormat:@"%d条新微博",count]:@"没有新微薄";
    UIButton *showBtn = [[UIButton alloc]init];
    [showBtn setTitle:showText forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"timeline_new_status_background"];
    //图片拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [showBtn setBackgroundImage:image forState:UIControlStateNormal];
    CGFloat showX = 0;
    CGFloat showY = self.navigationController.navigationBar.frame.size.height - kShowBtnHeight;
    showY += IOS7?20:0;
    CGFloat showWidth = self.view.frame.size.width;
    CGFloat showHeight = kShowBtnHeight;
    showBtn.frame = CGRectMake(showX, showY, showWidth, showHeight);
    //添加到navigationBar之下
    [self.navigationController.view insertSubview:showBtn belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0f animations:^{
//        CGRect frame = showBtn.frame;
//        frame.origin.y += kShowBtnHeight;
//        showBtn.frame = frame;
        showBtn.transform = CGAffineTransformMakeTranslation(0, kShowBtnHeight + 1);
    } completion:^(BOOL finished) {
        //隐藏
        [NSThread sleepForTimeInterval:0.5];
        [UIView animateWithDuration:1.0f animations:^{
//            CGRect frame = showBtn.frame;
//            frame.origin.y -= kShowBtnHeight;
//            showBtn.frame = frame;
            showBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [showBtn removeFromSuperview];
        }];
        
    }];
    
}

#pragma mark 获取微博数据
-(void)loadStatuseData{
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
//    hud.labelText = @"正在加载内容";
//    hud.dimBackground = YES;
    
    //获取第一条微博的id
    StatusCellFrame *frame = _statusesFrames.count ? _statusesFrames[0] : nil;
    long long ID = [frame.statuse ID];
    
    [HttpTool getWithUrl:KStatusesUrl parameters:@{
        @"access_token":[AccessTokenTool shareAccessTokenTool].account.accessToken,
        @"since_id" : @(ID)
    } success:^(id responseObject) {

        NSArray *array = responseObject[@"statuses"];
        NSMutableArray *tempFrames = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in array) {
            Statuse *statuse = [[Statuse alloc]initWithDict:dict];
            StatusCellFrame *frame = [[StatusCellFrame alloc]init];
            [frame setStatuse:statuse];
            [tempFrames addObject:frame];
        }
        
        [_statusesFrames insertObjects:tempFrames atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempFrames.count)]];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
//        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
        
        [self showStatusCount:tempFrames.count];
        
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
//        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
    }];
}

#pragma mark 获取更多微博数据
-(void)loadMoreStatuseData{
    
    StatusCellFrame *frame = [_statusesFrames lastObject];
    long long ID = [frame.statuse ID] - 1;
    
    [HttpTool getWithUrl:KStatusesUrl parameters:@{
        @"access_token":[AccessTokenTool shareAccessTokenTool].account.accessToken,
        @"max_id" : @(ID)
    } success:^(id responseObject) {

        NSArray *array = responseObject[@"statuses"];
        for (NSDictionary *dict in array) {
            Statuse *statuse = [[Statuse alloc]initWithDict:dict];
            StatusCellFrame *frame = [[StatusCellFrame alloc]init];
            [frame setStatuse:statuse];
            [_statusesFrames addObject:frame];
        }
        
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
//        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
           
       } failure:^(NSError *error) {
           [self.tableView footerEndRefreshing];
//        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
       }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusesFrames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatusCellFrame *frame = _statusesFrames[indexPath.row];
    return frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIden = @"cell";
    StatuseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[StatuseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIden];
    }
    
    StatusCellFrame *statuse = _statusesFrames[indexPath.row];
    [cell setCellFrame:statuse];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailController *detail = [[DetailController alloc]init];
    StatusCellFrame *frame = _statusesFrames[indexPath.row];
    detail.status = frame.statuse;
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
