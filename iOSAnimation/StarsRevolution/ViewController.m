//
//  ViewController.m
//  StarsRevolution
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@property (nonatomic,strong,readwrite) CAReplicatorLayer *replicatorLayer;
@property (nonatomic,strong,readwrite) UIImageView *iv_earth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    background.image        = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:background];
    
    _iv_earth       = [[UIImageView alloc]initWithFrame:CGRectMake( (UISCREEN_WIDTH-50)/2+150, (UISCREEN_HEIGHT-50)/2, 50, 50)];
    _iv_earth.image = [UIImage imageNamed:@"earth"];
    
    UIImageView *iv_sun = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    iv_sun.center       = self.view.center;
    iv_sun.image        = [UIImage imageNamed:@"sun"];
    
    self.replicatorLayer = [CAReplicatorLayer new];
    [self.replicatorLayer addSublayer:self.iv_earth.layer];
    [self.replicatorLayer addSublayer:iv_sun.layer];


}

- (void)viewWillAppear:(BOOL)animated{
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:150 startAngle:0 endAngle:M_PI*2 clockwise:true];
    [path closePath];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.keyPath              = @"position";
    animation.path                 = path.CGPath;
    animation.duration             = 10.0f;
    animation.repeatCount          = MAXFLOAT;
    //跟书上不一样，我放了初始化了
    //self.replicatorLayer.instanceCount = 100;

    //图层内容个数
    self.replicatorLayer.instanceCount = 50;
    //复制时间
    self.replicatorLayer.instanceDelay = 0.2f;
    [self.view.layer addSublayer:self.replicatorLayer];
    //关键帧动画不像Group 一样，不用提交
    [self.iv_earth.layer addAnimation:animation forKey:nil];

}
@end
