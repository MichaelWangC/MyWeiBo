//
//  NewFeatureController.m
//  MyWeiBo
//
//  Created by ZYmac on 14-8-28.
//  Copyright (c) 2014年 samples. All rights reserved.
//

#import "NewFeatureController.h"
#import "OAuthController.h"
#import "MWBNavigationController.h"

#define kImageCount 4 //图片数量

@interface NewFeatureController ()<UIScrollViewDelegate>{
    UIScrollView *_svNewFeature;
    UIPageControl *_pcPage;
}

@end

@implementation NewFeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    //背景设置
    NSString *imageName;
    if (Iphone5) {
        imageName = [NSString stringWithFormat:@"new_feature_background-568h"];
    }else{
        imageName = [NSString stringWithFormat:@"new_feature_background"];
    }
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]];
    //添加滚动View
    [self addScrollView];
    //添加图片
    [self addScrollImage];
    //设置PageController
    [self setPageController];
}
#pragma mark 添加滚动View
-(void)addScrollView{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    _svNewFeature = [[UIScrollView alloc]initWithFrame:screenRect];
    _svNewFeature.contentSize = CGSizeMake(screenRect.size.width * kImageCount, screenRect.size.height);
    _svNewFeature.pagingEnabled = YES;
    _svNewFeature.showsHorizontalScrollIndicator = NO;
    _svNewFeature.delegate = self;
    [self.view addSubview:_svNewFeature];
}
#pragma mark 添加图片
-(void)addScrollImage{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    for (int i=0; i<kImageCount; i++) {
        CGFloat imageX = i * screenRect.size.width;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, 0, screenRect.size.width, screenRect.size.height)];
        
        NSString *imageName;
        if (Iphone5) {
            imageName = [NSString stringWithFormat:@"new_feature_%d-568h",i+1];
        }else{
            imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        }
        imageView.image = [UIImage imageNamed:imageName];
        [_svNewFeature addSubview:imageView];
        
        //最后一张 添加按钮
        if (i == kImageCount - 1) {
            //微博分享
            UIButton *btnShare = [[UIButton alloc]init];
            UIImage *imgShareNomal = [UIImage imageNamed:@"new_feature_share_false"];
            [btnShare setImage:imgShareNomal forState:UIControlStateNormal];
            [btnShare setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            btnShare.frame = (CGRect){CGPointZero,imgShareNomal.size};
            btnShare.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.7);
            btnShare.selected = YES;
            [btnShare addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
            //去除高亮状态的阴影
            btnShare.adjustsImageWhenHighlighted = NO;
            [imageView addSubview:btnShare];
            
            //立即体验
            UIButton *btnStart = [[UIButton alloc]init];
            UIImage *imgStart = [UIImage imageNamed:@"new_feature_finish_button"];
            [btnStart setImage:imgStart forState:UIControlStateNormal];
            [btnStart setImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            btnStart.frame = (CGRect){CGPointZero,imgStart.size};
            btnStart.center = CGPointMake(self.view.center.x, self.view.frame.size.height * 0.8);
            [btnStart addTarget:self action:@selector(startWB) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btnStart];
        
            imageView.userInteractionEnabled = YES;
        }
    }
}
#pragma mark 设置PageController
-(void)setPageController{
    _pcPage = [[UIPageControl alloc]initWithFrame:(CGRect){CGPointZero,{120,0}}];
    _pcPage.center = (CGPoint){self.view.center.x,self.view.frame.size.height * 0.95};
    _pcPage.numberOfPages = kImageCount;
    _pcPage.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pcPage.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self.view addSubview:_pcPage];
}
#pragma mark 点击分享按钮
-(void)shareClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}
#pragma mark 进入微博
-(void)startWB{
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    OAuthController *oauth = [[OAuthController alloc]init];
    MWBNavigationController *mwb = [[MWBNavigationController alloc]initWithRootViewController:oauth];
    [self presentViewController:mwb animated:YES completion:nil];
    self.view.window.rootViewController = mwb;
}
#pragma mark scroolView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x / self.view.frame.size.width;
    _pcPage.currentPage = currentPage;
}
//#pragma mark 隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}
@end
