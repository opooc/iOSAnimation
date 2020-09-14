//
//  ViewController.m
//  CAKeyframeAnimation
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong,readwrite) UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //关键帧动画不像CABasicAnimation一样,关键帧可以一次性设置多组值
    //同样CAAnimationGroup也可以一次设置多组动画
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    [self changeFade];
}
//淡出效果
- (void)changeFade{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.duration = 10.0f;
    animation.keyPath  = @"opacity";
    //每个关键帧停留时间为keyTime*duration;
    NSArray<NSNumber *> *valuesArr = [NSArray arrayWithObjects:
                                      @(0.95f),
                                      @(0.90f),
                                      @(0.88f),
                                      @(0.85f),
                                      @(0.35f),
                                      @(0.05f),
                                      @(0.00f),
                                      nil];
    animation.values    = valuesArr;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.redView.layer addAnimation:animation forKey:nil];
}

@end
