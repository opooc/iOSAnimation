//
//  CircleView.m
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/13.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "CircleView.h"


@interface CircleView() <CAAnimationDelegate>

@property (nonatomic,strong,readwrite)NSNumber *lineWidth;
@property (nonatomic,strong,readwrite)UIColor *strokeColor;
//DrawRect：DrawRect属于CoreGraphic框架，占用CPU，消耗性能大
//CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存
@property (nonatomic,strong,readwrite)CAShapeLayer *circle;

@end

@implementation CircleView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //线条宽度
        self.lineWidth   = @(3.0);
        //线条颜色
        self.strokeColor = [UIColor colorWithDisplayP3Red:25.0 / 255.0 green:155.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
        //初始化这个CAShapeLayer
        self.circle      = [CAShapeLayer new];
        
        //配置circle的路径
        CGFloat startAngle = -90.0/180.0 * M_PI;
        CGFloat endAngle   = -90.01/180.0 * M_PI;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5) radius:frame.size.height * 0.5 - 2 startAngle:startAngle endAngle:endAngle clockwise:true];
        
        //设置circle的路径
        self.circle.path      = circlePath.CGPath;
        //设置circle的拐角形状
        self.circle.lineCap   = kCALineCapRound;
        //清空里面的填充颜色
        self.circle.fillColor = [UIColor clearColor].CGColor;
        //lineWidth可以不用设定，等滚动的时候在设置
        //self.circle.lineWidth = self.lineWidth.floatValue;
        //把circle扔到当前视图layer层上
        [self.layer addSublayer:self.circle];
    }
    return self;
}
//实现圆环滚动
- (void) strokeChart{
    //设置圆环宽度和颜色
    //这个添加过了
    self.circle.lineWidth   = [self.lineWidth floatValue];
    //设置边框颜色
    self.circle.strokeColor = self.strokeColor.CGColor;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation new];
    //strokeEnd代表逐渐绘制
    pathAnimation.keyPath        = @"strokeEnd";
    pathAnimation.duration       = 3.0f;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue      = @(0.0f);
    pathAnimation.toValue        = @(1.0f);
    //设置代理，主要是为了开启第三阶段
    pathAnimation.delegate       = self;
    //这特么又是啥?????
    [pathAnimation setValue:@"strokeEndAnimationcircle" forKey:@"groupborderkeycircle"];
    [self.circle addAnimation:pathAnimation forKey:@"strokeEndAnimationcircle"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.delegate circleAnimationStop];
}
@end
