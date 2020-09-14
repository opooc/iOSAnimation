//
//  ViewController.m
//  BeatNoteReplicator
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.;.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer new];
    replicatorLayer.frame              = CGRectMake(0, 0, 414, 200);
    replicatorLayer.instanceCount      = 20;//一共复制20g份
    replicatorLayer.instanceTransform  = CATransform3DMakeTranslation(20, 0, 0);//沿x轴，每20个点 复制一份
    replicatorLayer.instanceDelay      = 0.2;//复制每0.2s一次
    replicatorLayer.masksToBounds      = true;//超出就切掉
    replicatorLayer.backgroundColor    = [UIColor blackColor].CGColor;
    
    //这是准备要复制的小音柱
    CALayer *layer        = [CALayer new];
    layer.frame           = CGRectMake(14, 200, 10, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    //小音柱扔到复制器
    [replicatorLayer addSublayer:layer];
    //复制器扔到view 视图的layer上
    [self.view.layer addSublayer:replicatorLayer];
    
    //小音柱动画
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath           = @"position.y";
    animation.duration          = 0.5f;
    animation.fromValue         = @(200);
    animation.toValue           = @(180);
    animation.autoreverses      = true;
    animation.repeatCount       = MAXFLOAT;
    [layer addAnimation:animation forKey:nil];
    
}


@end
