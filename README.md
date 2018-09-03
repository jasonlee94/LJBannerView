# LJBannerView
* 极简的图片轮播器,基于UIScrollView实现  

![example_1](/LJBannerViewDemo/ExampleImg/1.png)![example_2](/LJBannerViewDemo/ExampleImg/2.png)

# Features
* [x] 支持在Storyboard\xib中创建
* [x] 支持Autolayout

# Installation
#### 1.Pod安装  
    pod 'LJBannerView', '~> 1.0.0'  
  *此库已包含依赖库SDWebImage*
#### 2.手动安装
将项目文件中的LJBannerView .m/.h 拷贝到自己的项目中，并自行添加SDWebImage库  
导入头文件:
```objectivec
#import "LJBannerView.h"
```
# Usage
1. Create By Frame
  ```objectivec
    LJBannerView *bannerView = [[LJBannerView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, 220.0f)];
    [self.view addSubview:bannerView];
    [bannerView setImageURLArr:@[@"http://www.xdowns.com/attachment/android/images/1709/170912094146.jpg",@"http://img3.3lian.com/2013/s1/30/d/62.jpg",@"http://image2.suning.cn/uimg/shp/userItems/151712398561123589_3.jpg"]];
  ```
2. Create By Masonry
  ```objectivec
    LJBannerView *bannerView = [[LJBannerView alloc] init];
    [self.view addSubview:bannerView];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(100);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.mas_offset(@220);
    }];
    
    [bannerView setImageURLArr:@[@"http://www.xdowns.com/attachment/android/images/1709/170912094146.jpg",@"http://img3.3lian.com/2013/s1/30/d/62.jpg",@"http://image2.suning.cn/uimg/shp/userItems/151712398561123589_3.jpg"]];
  ```
3. Create By Xib  
![example_xib](/LJBannerViewDemo/ExampleImg/3.png)  

```objectivec
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
```
  
 
 
 
