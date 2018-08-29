//
//  LJBannerView.m
//  LJBannerViewDemo
//
//  Created by DY05 on 2018/8/29.
//  Copyright © 2018年 DYLee. All rights reserved.
//

#import "LJBannerView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LJBannerView ()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pageControl;

@property (strong,nonatomic) NSTimer *autoTimer;

@property (assign,nonatomic) CGFloat timerCount;
@property (assign,nonatomic) CGFloat nowContentx;

@property (copy,nonatomic) NSArray *imgArr;
@property (copy,nonatomic) NSArray *imgURLArr;

@end

static CGFloat const Animated_Secs = 4.0f; //轮播间隔时间

@implementation LJBannerView

#pragma mark -- Private Method

- (void)initBaseView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delaysContentTouches=YES;
    _scrollView.delegate = self;
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPage = 0;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}

- (void)setupImgView
{
    for (UIView *sonView in _scrollView.subviews) {
        [sonView removeFromSuperview];
    }
    if(_imgArr != nil)
    {
        if (_imgArr.count > 0 && _scrollView.subviews.count == 0) {
            if(_imgArr.count == 0)
            {
                //收到图片为0的时候
                return;
            }else if (_imgArr.count == 1)
                //图片仅为一张
            {
                _scrollView.contentOffset = CGPointMake(0, 0);
                _scrollView.contentSize = CGSizeMake(self.frame.size.width * _imgArr.count, self.frame.size.height);
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                [imgView setImage:[UIImage imageNamed:_imgArr.firstObject]];
                [_scrollView addSubview:imgView];
                _pageControl.numberOfPages = _imgArr.count;
            }else{
                
                //多张图片
                _pageControl.numberOfPages = _imgArr.count;
                _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
                _nowContentx = _scrollView.contentOffset.x;
                
                _scrollView.contentSize = CGSizeMake(self.frame.size.width * (_imgArr.count+2), self.frame.size.height);
                for (NSInteger i = 0 ; i < _imgArr.count+2; i++) {
                    
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
                    
                    if(i == 0)
                        //第一张图片
                    {
                        [imgView setImage:[UIImage imageNamed:_imgArr.lastObject]];
                        
                    }else if(i > 0 && i < _imgArr.count+1)
                        //中间区段图片
                    {
                        [imgView setImage:[UIImage imageNamed:_imgArr[i-1]]];
                    }else if(i == _imgArr.count+1)
                        //最后一张图片
                    {
                        [imgView setImage:[UIImage imageNamed:_imgArr.firstObject]];
                    }
                    [_scrollView addSubview:imgView];
                    
                }
                //图片放置完毕开启自动轮播
                [self autoScrollTheImage];
            }
        }
    }else if (_imgURLArr != nil)
    {
        if (_imgURLArr.count > 0 && _scrollView.subviews.count == 0) {
            if(_imgURLArr.count == 0)
            {
                //收到图片为0的时候
                return;
            }else if (_imgURLArr.count == 1)
                //图片仅为一张
            {
                _scrollView.contentOffset = CGPointMake(0, 0);
                _scrollView.contentSize = CGSizeMake(self.frame.size.width * _imgURLArr.count, self.frame.size.height);
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                [imgView sd_setImageWithURL:[NSURL URLWithString:_imgURLArr.firstObject]];
                [_scrollView addSubview:imgView];
                _pageControl.numberOfPages = _imgURLArr.count;
            }else{
                //图片多余一张
                _pageControl.numberOfPages = _imgURLArr.count;
                _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
                _nowContentx = _scrollView.contentOffset.x;
                
                _scrollView.contentSize = CGSizeMake(self.frame.size.width * (_imgURLArr.count+2), self.frame.size.height);
                for (NSInteger i = 0 ; i < _imgURLArr.count+2; i++) {
                    
                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
                    
                    if(i == 0)
                        //第一张图片
                    {
                        [imgView sd_setImageWithURL:[NSURL URLWithString:_imgURLArr.lastObject]];
                        
                    }else if(i > 0 && i < _imgURLArr.count+1)
                        //中间区段图片
                    {
                        [imgView sd_setImageWithURL:[NSURL URLWithString:_imgURLArr[i-1]]];
                    }else if(i == _imgURLArr.count+1)
                        //最后一张图片
                    {
                        [imgView sd_setImageWithURL:[NSURL URLWithString:_imgURLArr.firstObject]];
                    }
                    [_scrollView addSubview:imgView];
                }
                //图片放置完毕开启自动轮播
                [self autoScrollTheImage];
            }
        }
    }
}

#pragma mark -- Public Method

- (void)setLocalImageArr:(NSArray *)localImgArr
{
    _imgURLArr = nil;
    _imgArr = [[NSArray alloc] initWithArray:localImgArr];
    [self setupImgView];
}

- (void)setImageURLArr:(NSArray *)imgURLArr
{
    _imgArr = nil;
    _imgURLArr = [[NSArray alloc] initWithArray:imgURLArr];
    [self setupImgView];
    
}
#pragma mark --自动轮播设置启动timer

- (void)autoScrollTheImage
{
    _timerCount = _nowContentx/self.frame.size.width;
    //timer启动
    if(_autoTimer == nil){
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:Animated_Secs target:self selector:@selector(handleMaxShowTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_autoTimer forMode:NSRunLoopCommonModes];
    }
}


#pragma mark --实现自动滚动方法

- (void)handleMaxShowTimer
{
    _timerCount++;
    
    if(_imgArr != nil)
    {
        if(_timerCount == _imgArr.count+2)
        {
            _timerCount = 2;
            [_scrollView scrollRectToVisible:CGRectMake(_timerCount * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        }else
        {
            [_scrollView scrollRectToVisible:CGRectMake(_timerCount * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        }
    }else if (_imgURLArr != nil)
    {
        if(_timerCount == _imgURLArr.count+2)
        {
            _timerCount = 2;
            [_scrollView scrollRectToVisible:CGRectMake(_timerCount * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        }else
        {
            [_scrollView scrollRectToVisible:CGRectMake(_timerCount * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
        }
    }
    
    
}


#pragma mark --scrollview代理方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_imgArr != nil)
    {
        int page = scrollView.contentOffset.x/self.frame.size.width-1;
        _pageControl.currentPage = page;
        
        if(scrollView.contentOffset.x/self.frame.size.width == _imgArr.count+1)
        {
            scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        }else if (scrollView.contentOffset.x/self.frame.size.width == 0)
        {
            scrollView.contentOffset = CGPointMake(_imgArr.count*self.frame.size.width, 0);
        }
    }else if (_imgURLArr != nil)
    {
        int page = scrollView.contentOffset.x/self.frame.size.width-1;
        _pageControl.currentPage = page;
        
        if(scrollView.contentOffset.x/self.frame.size.width == _imgURLArr.count+1)
        {
            scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        }else if (scrollView.contentOffset.x/self.frame.size.width == 0)
        {
            scrollView.contentOffset = CGPointMake(_imgURLArr.count*self.frame.size.width, 0);
        }
    }
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    //手动拖拽情况下取消timer;
    if(_autoTimer)
    {
        [_autoTimer invalidate];
        _autoTimer = nil;
    }
    
    
}
#pragma mark -- 重新开启timer
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self autoScrollTheImage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //取到scrollview滚动停止后的contentoffset以此当下次开启timer后滚动的起点位置
    _nowContentx = scrollView.contentOffset.x;
    _timerCount = _nowContentx/self.frame.size.width - 1;
}



#pragma mark -- Life Cycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_scrollView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_pageControl setFrame:CGRectMake(self.frame.size.width/2 - 50, self.frame.size.height-32, 100,30 )];
    [self setupImgView];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBaseView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBaseView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initBaseView];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(newSuperview == nil)
    {
        if(_autoTimer)
        {
            [_autoTimer invalidate];
            _autoTimer = nil;
        }
    }
}

@end
