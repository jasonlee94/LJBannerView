//
//  LJBannerView.h
//  LJBannerViewDemo
//
//  Created by DY05 on 2018/8/29.
//  Copyright © 2018年 DYLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBannerView : UIView

//配置本地图片 (@[@"picture.png",...])
- (void)setLocalImageArr:(NSArray *)localImgArr;

//配置网络图片 （@[@"http://xxxxx",....]）
- (void)setImageURLArr:(NSArray *)imgURLArr;

@end
