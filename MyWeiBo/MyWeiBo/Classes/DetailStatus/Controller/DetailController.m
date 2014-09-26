//
//  DetailController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-9-25.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "DetailController.h"
#import "StatusCellFrame.h"
#import "StatuseCell.h"
#import "DetailHeader.h"

@interface DetailController ()

@end

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"微博正文";
    self.tableView.backgroundColor = kGlobalBg;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return _statusCellFrame.cellHeight;
    return 44;
}

#pragma mark 第section组头部控件有多高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0;
    return [DetailHeader DetailHeaderHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) return nil;
    DetailHeader *detailHeader = [[DetailHeader alloc]init];
    return detailHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIden = @"DetailStatusCell";
        StatuseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
        if (cell == nil) {
            cell = [[StatuseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        }
        cell.cellFrame = _statusCellFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    static NSString *cellIden = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
    }
    
    return cell;
}


@end
