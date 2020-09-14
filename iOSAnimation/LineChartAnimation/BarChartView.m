//
//  BarChartView.m
//  LineChartAnimation
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "BarChartView.h"
@interface BarChartView()

@property (nonatomic,strong,readwrite) CAShapeLayer *chartLine;
@property (nonatomic,strong,readwrite) CABasicAnimation *pathAnimation;//这个是展示动画,

@end
@implementation BarChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds   = true;
        self.pathAnimation   = [CABasicAnimation new];
        
        self.chartLine               = [CAShapeLayer new];
        self.chartLine.lineCap       = kCALineCapSquare;
        self.chartLine.lineJoin      = kCALineJoinRound;
        self.chartLine.fillColor     = [UIColor grayColor].CGColor;
        self.chartLine.strokeColor   =  [UIColor colorWithDisplayP3Red:77.0/255.0 green: 186.0/255.0 blue:122.0/255.0 alpha:1.0].CGColor;
        self.chartLine.lineWidth     = 30.0f;
        //末尾的长度,strokeStart默认为0
        self.chartLine.strokeEnd     = 0.0f;
        [self.layer addSublayer:self.chartLine];
    }
    return self;
}

- (void)drawLineChart{
    self.chartLine.strokeEnd = 1.0f;
    NSLog(@"%@",self.pathAnimation);
    [self.chartLine addAnimation:self.pathAnimation forKey:nil];

}

- (void)drawRect:(CGRect)rect{
    //实例化一个贝瑟尔曲线
    UIBezierPath *line = [UIBezierPath new];
    line.lineWidth     = 30.0f;
    //注意这里是KCG
    line.lineCapStyle  = kCGLineCapSquare;
    line.lineJoinStyle = kCGLineJoinRound;
    
    for (int i = 0 ; i < 5; i++) {
        CGFloat x = 60 + 70*i;
        CGFloat y = 100 + 20*i;
        [line moveToPoint:CGPointMake(x, 215)];
        [line addLineToPoint:CGPointMake(x, y)];
    }

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
