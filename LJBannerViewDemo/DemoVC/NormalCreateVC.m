//
//  NormalCreateVC.m
//  LJBannerViewDemo
//
//  Created by DY05 on 2018/8/29.
//  Copyright © 2018年 DYLee. All rights reserved.
//

#import "NormalCreateVC.h"
#import "LJBannerView.h"

@interface NormalCreateVC ()<LJBannerViewDelegate>

@end

@implementation NormalCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LJBannerView *bannerView = [[LJBannerView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, 220.0f)];
    bannerView.currentPageIndicatorTintColor = [UIColor redColor];
    bannerView.pageIndicatorTintColor = [UIColor yellowColor];
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
    
    [bannerView setImageURLArr:@[@"http://www.xdowns.com/attachment/android/images/1709/170912094146.jpg",@"http://img3.3lian.com/2013/s1/30/d/62.jpg",@"http://image2.suning.cn/uimg/shp/userItems/151712398561123589_3.jpg"]];
}

- (void)LJBannerViewDelegateClickForIndex:(NSInteger)index
{
    NSLog(@"点击下标:%ld",index);
}

@end
