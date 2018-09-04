//
//  XibCreateViewController.m
//  LJBannerViewDemo
//
//  Created by DY05 on 2018/8/29.
//  Copyright © 2018年 DYLee. All rights reserved.
//

#import "XibCreateViewController.h"
#import "LJBannerView.h"

@interface XibCreateViewController ()
@property (weak, nonatomic) IBOutlet LJBannerView *bannerView;

@end

@implementation XibCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bannerView setImageURLArr:@[@"http://www.xdowns.com/attachment/android/images/1709/170912094146.jpg",@"http://img3.3lian.com/2013/s1/30/d/62.jpg",@"http://image2.suning.cn/uimg/shp/userItems/151712398561123589_3.jpg"]];
}

@end
