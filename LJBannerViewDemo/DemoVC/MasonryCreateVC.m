//
//  MasonryCreateVC.m
//  LJBannerViewDemo
//
//  Created by DY05 on 2018/8/29.
//  Copyright © 2018年 DYLee. All rights reserved.
//

#import "MasonryCreateVC.h"
#import "LJBannerView.h"
#import <Masonry/Masonry.h>

@interface MasonryCreateVC ()

@end

@implementation MasonryCreateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LJBannerView *bannerView = [[LJBannerView alloc] init];
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(100);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.mas_offset(@220);
    }];
    
    [bannerView setImageURLArr:@[@"http://www.xdowns.com/attachment/android/images/1709/170912094146.jpg",@"http://img3.3lian.com/2013/s1/30/d/62.jpg",@"http://image2.suning.cn/uimg/shp/userItems/151712398561123589_3.jpg"]];
    
    
}



@end
