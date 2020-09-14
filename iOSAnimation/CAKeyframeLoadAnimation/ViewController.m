//
//  ViewController.m
//  CAKeyframeLoadAnimation
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [UIImageView new];
    imageView.frame        = CGRectMake(50, 50, 50, 50);
    imageView.image        = [UIImage imageNamed:@"Plane"];
    [self.view addSubview:imageView];
    //创建可变路径
    CGMutablePathRef pathLine = CGPathCreateMutable();
    //设置初始位置 直线运动
    CGPathMoveToPoint(pathLine, nil, 50, 50);
    CGPathAddLineToPoint(pathLine, nil, 300, 50);
//    CGAffineTransform 是一个2D仿生
//    CGPathAddArc(pathLine, nil, 200,200, 150, 0, M_PI_2, true);
    
    
    //创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.duration = 2.0f;
    animation.keyPath  = @"position";
    animation.path     = pathLine;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [imageView.layer addAnimation:animation forKey:nil];

}


@end
