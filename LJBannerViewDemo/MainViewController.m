//
//  MainViewController.m
//  LJBannerViewDemo
//
//  Created by DY05 on 2018/8/29.
//  Copyright © 2018年 DYLee. All rights reserved.
//

#import "MainViewController.h"
#import "NormalCreateVC.h"
#import "XibCreateViewController.h"
#import "MasonryCreateVC.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (IBAction)normalCreateAction:(id)sender
{
    NormalCreateVC *vc = [[NormalCreateVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)xibCreateAction:(id)sender
{
    XibCreateViewController *vc = [[XibCreateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)masonryCreateAction:(id)sender
{
    MasonryCreateVC *vc = [[MasonryCreateVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图片轮播器";
}



@end
