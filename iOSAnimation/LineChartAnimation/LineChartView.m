//
//  LineChartView.m
//  LineChartAnimation
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "LineChartView.h"
@interface LineChartView()

@property (nonatomic,strong,readwrite) UIColor *PNGreen;
@property (nonatomic,strong,readwrite) CAShapeLayer *chartLine;
@property (nonatomic,strong,readwrite) CABasicAnimation *pathAnimation;//这个是展示动画,

@end
@implementation LineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds   = true;
        self.PNGreen         = [UIColor colorWithDisplayP3Red:77.0/255.0 green: 186.0/255.0 blue:122.0/255.0 alpha:1.0];
        self.pathAnimation   = [CABasicAnimation new];
        
        self.chartLine               = [CAShapeLayer new];
        self.chartLine.lineCap       = kCALineCapRound;
        self.chartLine.lineJoin      = kCALineJoinRound;
        self.chartLine.fillColor     = [UIColor whiteColor].CGColor;
        self.chartLine.strokeColor   = self.PNGreen.CGColor;
        self.chartLine.lineWidth     = 10.0f;
        //末尾的长度,strokeStart默认为0
        self.chartLine.strokeEnd     = 0.0f;
        [self.layer addSublayer:self.chartLine];
        
    }
    return self;
}
- (void)drawLineChart{
    //????这里为什么直接设置为1.0
    self.chartLine.strokeEnd = 1.0f;
    [self.chartLine addAnimation:self.pathAnimation forKey:nil];
}
- (void)drawRect:(CGRect)rect{
    //实例化一个贝瑟尔曲线
    UIBezierPath *line = [UIBezierPath new];
    line.lineWidth     = 10.0f;
    //注意这里是KCG
    line.lineCapStyle  = kCGLineCapRound;
    line.lineJoinStyle = kCGLineJoinRound;
    [line moveToPoint:CGPointMake(70, 260)];
    [line addLineToPoint:CGPointMake(140, 100)];
    [line addLineToPoint:CGPointMake(210, 240)];
    [line addLineToPoint:CGPointMake(280, 170)];
    [line addLineToPoint:CGPointMake(350, 220)];
    //将贝瑟尔扔给 CAShapeLayer层
    self.chartLine.path        = line.CGPath;
    //设置边框颜色,我放了初始化里面了
    //self.chartLine.strokeColor = self.PNGreen.CGColor;
    
    self.pathAnimation.keyPath        = @"strokeEnd";
    self.pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.pathAnimation.fromValue      = @(0.0f);
    self.pathAnimation.toValue        = @(1.0f);
    //设置相反执行
    self.pathAnimation.autoreverses   = NO;
    self.pathAnimation.duration       = 2.0f;
}

@end
