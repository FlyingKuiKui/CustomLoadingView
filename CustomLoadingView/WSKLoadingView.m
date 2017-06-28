//
//  WSKLoadingView.m
//  CustomLoadingView
//
//  Created by 王盛魁 on 2017/6/28.
//  Copyright © 2017年 WangShengKui. All rights reserved.
//

#import "WSKLoadingView.h"

static CGFloat viewWidth = 80;
static CGFloat viewHeight = 80;
static CGFloat fTimer = 0;
@interface WSKLoadingView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *logBackView;
@property (nonatomic, strong) UIImageView *imgvLoad;
@property (nonatomic, strong) UILabel *lblPrompt;
@property (nonatomic, strong) NSTimer *timer; // 计时器
@end

@implementation WSKLoadingView
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.2;
    }
    return _backView;
}

- (UIView *)logBackView{
    if (!_logBackView) {
        _logBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        _logBackView.backgroundColor = [UIColor clearColor];
        _logBackView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    }
    return _logBackView;
}

- (UIImageView *)imgvLoad{
    if (!_imgvLoad) {
        _imgvLoad = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading.png"]];
        _imgvLoad.frame = CGRectMake(0, 0, 77, 77);
        _imgvLoad.center = CGPointMake(CGRectGetWidth(self.logBackView.frame)/2, CGRectGetHeight(self.logBackView.frame)/2);
    }
    return _imgvLoad;
}

- (UILabel *)lblPrompt{
    if (!_lblPrompt) {
        _lblPrompt = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logBackView.frame), [UIScreen mainScreen].bounds.size.width, 30)];
        [_lblPrompt setTextAlignment:NSTextAlignmentCenter];
        [_lblPrompt setTextColor:[UIColor whiteColor]];
        [_lblPrompt setText:@"Loading..."];
    }
    return _lblPrompt;
}
+ (WSKLoadingView *)shareLoadingView{
    static WSKLoadingView *loadingView = nil;
    static dispatch_once_t onceToken;
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    dispatch_once(&onceToken, ^{
        loadingView = [[WSKLoadingView alloc]initWithView:view];
    });
    return loadingView;
}

// 初始化
- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.logBackView];
        [self addSubview:self.lblPrompt];
        
        UIImageView *imgvBack = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logoIcon.png"]];
        imgvBack.frame = CGRectMake(0, 0, 55, 55);
        imgvBack.center = CGPointMake(CGRectGetWidth(self.logBackView.frame)/2, CGRectGetHeight(self.logBackView.frame)/2);
        [self.logBackView addSubview:imgvBack];
        [self.logBackView addSubview:self.imgvLoad];
    }
    return self;
}
// 展示加载动画
+ (void)showLoadingView{
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:self]) {
            [subview removeFromSuperview];
        }
    }
    [view addSubview:[WSKLoadingView shareLoadingView]];
    [[WSKLoadingView shareLoadingView] startTimer];
}
// 隐藏加载动画
+ (void)hiddenLoadingView{
    [[WSKLoadingView shareLoadingView] stopTimer];
    UIView *view = [[UIApplication sharedApplication].windows firstObject];
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:self]) {
            [subview removeFromSuperview];
        }
    }
}
// 开始计时
- (void)startTimer{
    if (self.timer) {
        [self stopTimer];
    }
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
// 停止计时
- (void)stopTimer{
    [self.timer invalidate];
}
// 计时操作
- (void)timerAction{
    self.imgvLoad.transform = CGAffineTransformRotate(_imgvLoad.transform, M_PI * 60 /180);
    fTimer++;
    if (fTimer == 100) {
        [self.class hiddenLoadingView];
        fTimer = 0;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
