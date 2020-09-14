//
//  ViewController.m
//  NeonLights
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
    self.view.layer.backgroundColor     = [UIColor blackColor].CGColor;
    
    CAEmitterCell *emitterCell    = [CAEmitterCell new];
    emitterCell.name              = @"nenolight";
    emitterCell.emissionLongitude = M_PI;//x-y平面
    emitterCell.velocity          = 50;//粒子速度，反方向，向上 1 和 -1  没有区别
    emitterCell.velocityRange     = 50;// 粒子速度范围
    
    emitterCell.scale             = 0.1;// 缩放比例
    emitterCell.scaleSpeed        = -0.2;// 速度缩放比例
    
    emitterCell.greenSpeed = -0.1;//设置RGB + alpha
    emitterCell.redSpeed = -0.2;
    emitterCell.blueSpeed = 0.1;
    emitterCell.alphaSpeed = -0.2;
    
    emitterCell.birthRate = 100;//设置出生速率
    emitterCell.lifetime = 4;//设置生命周期
    
    emitterCell.color = [UIColor whiteColor].CGColor;
    emitterCell.contents          = (id)[UIImage imageNamed:@"nenolight"].CGImage;
    
    CAEmitterLayer *emitterLayer  = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = self.view.center;// 粒子发射位置
    emitterLayer.emitterSize = CGSizeMake(2, 2);// 控制火苗大小
    emitterLayer.renderMode = kCAEmitterLayerBackToFront; // 设置渲染模式
    emitterLayer.emitterMode = kCAEmitterLayerOutline;// 控制发射源模式 即形状
    emitterLayer.emitterShape = kCAEmitterLayerCircle;//控制发射源形状
    emitterLayer.emitterCells = @[emitterCell];//把放射源放到layer中
    
    [self.view.layer addSublayer:emitterLayer];
}


@end
