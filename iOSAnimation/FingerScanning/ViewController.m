//
//  ViewController.m
//  FingerScanning
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.1设置背景色
    self.view.backgroundColor = [UIColor blackColor];
    //1.2添加背景图
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"unLock.jpg"]];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.frame        = self.view.bounds;
    imageView.center       = self.view.center;
    [self.view addSubview:imageView];
    
    //2.设置Layer图层属性
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    //这个位置书上是(105, 330, 200, 200); 我用的iphone8模拟器，85刚好合适
    gradientLayer.frame            = CGRectMake(85, 330, 200, 200);
    gradientLayer.startPoint       = CGPointMake(0, 0);
    gradientLayer.endPoint         = CGPointMake(0, 1);
    gradientLayer.colors           = @[(id)[UIColor clearColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor clearColor].CGColor];
    //开头数定了开始位置，后面的数是减去前面的数的差 代表了所占比例，总比例为1
    gradientLayer.locations        = @[@(0.0f),@(0.1f),@(0.2f)];
    [imageView.layer addSublayer:gradientLayer];
    
    //3.设置CABasicAnimation
    CABasicAnimation *gradientAnimation = [CABasicAnimation new];
    gradientAnimation.keyPath           = @"locations";
    gradientAnimation.fromValue         = @[@(0.0),@(0.1),@(0.2)];
    gradientAnimation.toValue           = @[@(0.8),@(0.9),@(1.0)];
    gradientAnimation.duration          = 3.0f;
    gradientAnimation.repeatCount       = 10;
    [gradientLayer addAnimation:gradientAnimation forKey:nil];
    
}


@end
