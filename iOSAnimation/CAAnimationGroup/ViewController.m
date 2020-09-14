//
//  ViewController.m
//  CAAnimationGroup
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong,readwrite) UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton                 = [[UIButton alloc]initWithFrame:CGRectMake(20, 230, self.view.frame.size.width - 20*2, 50)];
    self.loginButton.backgroundColor = [UIColor colorWithDisplayP3Red:50/255.0 green:185/255.0 blue:170/255.0 alpha:1.0f];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    //旋转
    CABasicAnimation *rotate = [CABasicAnimation new];
    rotate.keyPath = @"transform.rotation";
    rotate.toValue = @(M_PI);
    //缩小到0
    CABasicAnimation *scale  = [CABasicAnimation new];
    scale.keyPath = @"transform.scale";
    scale.toValue = @(0.0f);
    //移动到右上
    CABasicAnimation *move   = [CABasicAnimation new];
    move.keyPath = @"transform.translation";
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(217.00f, -230.00f)];
    CAAnimationGroup *animationGroups = [CAAnimationGroup new];
    animationGroups.animations = @[rotate,scale,move];
    animationGroups.duration   = 2.0f;
    animationGroups.fillMode   = kCAFillModeForwards;
    [animationGroups setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animationGroups forKey:nil];
}


@end
