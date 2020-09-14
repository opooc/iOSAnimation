//
//  ViewController.m
//  GhostFire
//
//  Created by doushuyao on 2020/9/13.
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
    emitterCell.name              = @"fire";
    emitterCell.emissionLongitude = M_PI;//x-y平面
    emitterCell.velocity          = 1;//粒子速度，反方向，向上 1 和 -1  没有区别
    emitterCell.velocityRange     = 50;// 粒子速度范围
    emitterCell.emissionRange     = 1.1;//周围发射角度
    emitterCell.yAcceleration     = -200;// 粒子y方向的加速度分量
    emitterCell.scaleSpeed        = 0.3;// 缩放比例 超大火苗
    emitterCell.color = [UIColor colorWithDisplayP3Red:0.3 green:0.4 blue:0.2 alpha:0.1].CGColor;
    emitterCell.contents          = (id)[UIImage imageNamed:@"fire.png"].CGImage;
    emitterCell.lifetime          = 1;//设置生命周期
    emitterCell.birthRate         = 500;//设置出生速率
    
    
    CAEmitterLayer *emitterLayer  = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = self.view.center;// 粒子发射位置
    emitterLayer.emitterSize = CGSizeMake(50, 10);// 控制火苗大小
    emitterLayer.renderMode = kCAEmitterLayerAdditive; // 设置渲染模式 (混合模式)
    emitterLayer.emitterMode = kCAEmitterLayerOutline;// 控制发射源模式 即形状
    emitterLayer.emitterShape = kCAEmitterLayerLine;//控制发射源形状
    emitterLayer.emitterCells = @[emitterCell];//把放射源放到layer中
    
    [self.view.layer addSublayer:emitterLayer];
    
//可以直接设置
//    [emitterLayer setValue:@(500) forKey:@"emitterCells.fire.birthRate"];
//    [emitterLayer setValue:@(1) forKey:@"emitterCells.fire.lifetime"];

}


@end
