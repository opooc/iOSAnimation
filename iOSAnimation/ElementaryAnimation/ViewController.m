//
//  ViewController.m
//  ElementaryAnimation
//
//  Created by doushuyao on 2020/9/7.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong, readwrite) UIButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login"]];
    bgview.frame = self.view.frame;
    [self.view addSubview:bgview];
    //其他动画初始位置
    //_loginButton = [[UIButton alloc]initWithFrame:CGRectMake(-394, 200, self.view.frame.size.width - 20 * 2, 50)];
    
    //几何动画的初始位置+淡入淡出动画初始位置+颜色渐变动画初始位置
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 20 * 2, 50)];
    
    //淡入淡出动画
    //_loginButton.alpha = 0.0f;
    
    _loginButton.backgroundColor = [UIColor colorWithDisplayP3Red:50 / 255.0 green:185 / 255.0 blue:170 / 255.0 alpha:1.0];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
}

- (void)loginAction{
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc]initWithDuration:2.0f curve:UIViewAnimationCurveLinear animations:^{
        //组合动画
        //设置旋转角度
        self.loginButton.transform = CGAffineTransformMakeRotation(M_PI * 0.25);
        //设置位置
        self.loginButton.frame     = CGRectMake(400, 0, self.loginButton.frame.size.width * 0.1, self.loginButton.frame.size.height * 0.1);
        //设置透明度
        self.loginButton.alpha = 0.0f;
    }];

    [animator startAnimation];
    
    
}











- (void)viewWillAppear:(BOOL)animated {
    //淡入淡出动画、颜色渐变动画的持续时间改成2.0f,其他动画初始位置为1.0f
//    UIViewPropertyAnimator *animator;
//    animator = [[UIViewPropertyAnimator alloc]initWithDuration:2.0f curve:UIViewAnimationCurveEaseIn animations:^{
        //位置动画
        //self.loginButton.center = CGPointMake(200, 400);
        
        //形状动画(书上是用bound我发现动画变不了，要把初试的位置改一下)
        //self.loginButton.bounds = CGRectMake(0 , 0, self.loginButton.frame.size.width*0.7, self.loginButton.frame.size.height*1.2);
        
        //位置+形状动画
        //self.loginButton.frame = CGRectMake(0, self.loginButton.frame.origin.y, self.loginButton.frame.size.width*0.7, self.loginButton.frame.size.height*1.2);
        
        //淡入淡出动画
        //self.loginButton.alpha = 1.0f;
        
        //颜色渐变动画
        //self.loginButton.backgroundColor = [UIColor grayColor];
    
        //缩放动画 (横方向 缩小0.7f,纵方向拉伸1.2f)
        //                       [a  b  0]
        // [xN,yN,1] = [x,y,1] * [c  d  0]
        //                       [tX tY 1]
        //1.0硬转法
        //self.loginButton.transform = CGAffineTransformMake(0.7f,0,0,1.2f,0,0);
        //2.0直接调scale方法
        //CGAffineTransformMakeScale实现以初始位置为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍
        //self.loginButton.transform = CGAffineTransformMakeScale(0.7, 1.2);
        
        //旋转动画 逆时针45度
        //CGAffineTransformMakeRotation实现以初始位置为基准,将坐标系统逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度)
        //self.loginButton.transform = CGAffineTransformMakeRotation(-M_PI*0.25);

        //位移动画
        //CGAffineTransformMakeTranslation实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位
        //CGAffineTransformTranslate实现以一个已经存在的形变为基准
        //self.loginButton.transform = CGAffineTransformMakeTranslation(0, 300);
        
    //}];

    //option会过渡相关的选项和与动画方向相关的选项将被忽略
    //写UIViewAnimationOptionRepeat没啥用,所以我选择回调~
//    animator  = [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:2.0f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//           self.loginButton.transform = CGAffineTransformMakeRotation(-M_PI*0.25);
//
//    } completion:^(UIViewAnimatingPosition finalPosition) {
//        [[[UIViewPropertyAnimator alloc]initWithDuration:2.0f curve:UIViewAnimationCurveLinear animations:^{
//            self.loginButton.transform = CGAffineTransformMakeRotation(0.0f);
//        }] startAnimation];
//    }];
//    [animator startAnimation];
    
    //为了使用系统自带的重复返回功能，只能被迫使用 带警告的UIView
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationRepeatCount:2];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    self.loginButton.transform = CGAffineTransformMakeRotation(-M_PI*0.25);
//    [UIView commitAnimations];
    
    //使用系统自带回调
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:1.0f];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
//    self.loginButton.transform = CGAffineTransformMakeScale(0.7, 1.2);
//    [UIView commitAnimations];
}
//- (void) animationDidStop{
//    NSLog(@"555");
//}
@end
