//
//  BazierView.m
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "BazierView.h"

@implementation BazierView

- (void)drawRect:(CGRect)rect{
    UIColor *color1 = [UIColor colorWithDisplayP3Red:255.0 / 255.0 green: 127.0 / 255.0 blue: 79.0 / 255.0 alpha: 1.0];
    UIColor *color2 = [UIColor colorWithDisplayP3Red:77.0 / 255.0 green: 186.0 / 255.0 blue: 122.0 / 255.0 alpha: 1.0];
    UIBezierPath *bezierPath = [UIBezierPath new];
    bezierPath.lineWidth     = 10.0f;
    //设置端点
    bezierPath.lineCapStyle  = kCGLineCapRound;
    //设置拐点
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    [bezierPath moveToPoint:CGPointMake(150, 150)];
    [bezierPath addLineToPoint:CGPointMake(250, 250)];
    [bezierPath addLineToPoint:CGPointMake(350, 150)];
    //封闭
    [bezierPath closePath];
    //设置边框颜色 和 里面填充颜色
    [color1 setStroke];
    [color2 setFill];
    
    //让bezierPath使用
    [bezierPath stroke];
    [bezierPath fill];
    
}

@end
