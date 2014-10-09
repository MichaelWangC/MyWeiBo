//
//  DetailController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-25.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DetailController.h"
#import "DetailStatusCellFrame.h"
#import "DetailStatusCell.h"
#import "DetailHeader.h"
#import "HttpTool.h"
#import "Statuse.h"
#import "AccessTokenTool.h"
#import "Comment.h"
#import "RepostCellFrame.h"
#import "CommentCellFrame.h"
#import "RepostCell.h"
#import "CommentCell.h"

@interface DetailController ()<DetailHeadDelegate>{
    DetailStatusCellFrame *_statusCellFrame;
    DetailHeader *_detailHeader;
    
    NSMutableArray *_repostFrames;
    NSMutableArray *_commentFrames;
}

@end

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"微博正文";
    self.tableView.backgroundColor = kGlobalBg;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    //微博的CellFrame
    _statusCellFrame = [[DetailStatusCellFrame alloc]init];
    _statusCellFrame.statuse = _status;
    //评论与转发数组初始化
    _repostFrames = [[NSMutableArray alloc]init];
    _commentFrames = [[NSMutableArray alloc]init];
    
    _detailHeader = [[DetailHeader alloc]init];
    _detailHeader.delegate = self;
    _detailHeader.currentBtnType = DetailHeaderBtnTypeComment;
    
}

#pragma mark 获得当前需要使用的数组
-(NSMutableArray *)currentContents{
    if (_detailHeader.currentBtnType == DetailHeaderBtnTypeRepost) {
        return  _repostFrames;
    }else{
        return _commentFrames;
    }
}

#pragma mark DetailHeadDelegate
-(void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index{

    //先刷新表格(马上显示对应的旧数据)
    [self.tableView reloadData];
    
    if (index == DetailHeaderBtnTypeRepost) {
        [self loadNewRepost];
    }else{
        [self loadNewComment];
    }
}

#pragma mark 加载最新转发数据
-(void)loadNewRepost{
    long long sinceId = _repostFrames.count == 0 ? 0:((RepostCellFrame *)_repostFrames[0]).baseText.ID;
    [HttpTool getWithUrl:KRepostsUrl parameters:@{
        @"access_token" : [AccessTokenTool shareAccessTokenTool].account.accessToken,
        @"id" : @(_status.ID),
        @"since_id" : @(sinceId)
    }success:^(id responseObject) {
        NSArray *reposts = responseObject[@"reposts"];
        NSMutableArray *statuses = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in reposts) {
            Statuse *s = [[Statuse alloc]initWithDict:dict];
            RepostCellFrame *rFrame = [[RepostCellFrame alloc]init];
            [rFrame setBaseText:s];
            [statuses addObject:rFrame];
        }
        [_repostFrames insertObjects:statuses atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)]];
        
        //更新转发数量
        _status.repostsCount = [responseObject[@"total_number"] integerValue];
        
        [self.tableView reloadData];
        
        //滚动到转发评论组
        if ([self currentContents].count != 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }failure:^(NSError *error) {
           
    }];
}

#pragma mark 加载最新评论数据
-(void)loadNewComment{
    long long sinceId = _commentFrames.count == 0 ? 0:((CommentCellFrame *)_commentFrames[0]).baseText.ID;
    [HttpTool getWithUrl:KCommentsShowUrl parameters:@{
        @"access_token" : [AccessTokenTool shareAccessTokenTool].account.accessToken,
        @"id" : @(_status.ID),
        @"since_id" : @(sinceId)
    }success:^(id responseObject) {
        NSArray *comments = responseObject[@"comments"];
        NSMutableArray *tempComments = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in comments) {
            Comment *c = [[Comment alloc]initWithDict:dict];
            CommentCellFrame *cFrame = [[CommentCellFrame alloc]init];
            [cFrame setBaseText:c];
            [tempComments addObject:cFrame];
        }
        [_commentFrames insertObjects:tempComments atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempComments.count)]];
        
        //更新评论数量
        _status.commentsCount = [responseObject[@"total_number"] integerValue];
        
        [self.tableView reloadData];
        
        //滚动到转发评论组
        if ([self currentContents].count != 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }failure:^(NSError *error) {
                                                           
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return [self currentContents].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return _statusCellFrame.cellHeight;
    return ((BaseTextFrame *)[self currentContents][indexPath.row]).cellHeight;;
}

#pragma mark 第section组头部控件有多高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return [DetailHeader DetailHeaderHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) return nil;
    _detailHeader.status = _status;
    return _detailHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIden = @"DetailStatusCell";
        DetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[DetailStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        cell.cellFrame = _statusCellFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    //评论or转发列表
    if (_detailHeader.currentBtnType == DetailHeaderBtnTypeRepost) {
        static NSString *cellIden = @"repostCell";
        RepostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[RepostCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        RepostCellFrame *s = [self currentContents][indexPath.row];
        [cell setRepostCellFrame:s];
        return cell;
    }else{
        static NSString *cellIden = @"commentCell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        CommentCellFrame *c = [self currentContents][indexPath.row];
        [cell setCommentCellFrame:c];
        return cell;
    }
    
}

@end
