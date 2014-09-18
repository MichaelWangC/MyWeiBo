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
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [self loadStatuseData];
}

#pragma mark 获取微博数据
-(void)loadStatuseData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.parentViewController.view animated:YES];
    hud.labelText = @"正在加载内容";
    hud.dimBackground = YES;
    
    [HttpTool getWithUrl:KStatusesUrl parameters:@{
        @"access_token":[AccessTokenTool shareAccessTokenTool].account.accessToken
    } success:^(id responseObject) {

        _statusesFrames = [[NSMutableArray alloc]init];
        NSArray *array = responseObject[@"statuses"];
        for (NSDictionary *dict in array) {
            Statuse *statuse = [[Statuse alloc]initWithDict:dict];
            StatusCellFrame *frame = [[StatusCellFrame alloc]init];
            [frame setStatuse:statuse];
            [_statusesFrames addObject:frame];
        }
        
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.parentViewController.view animated:YES];
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
}

@end
