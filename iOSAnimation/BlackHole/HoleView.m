//
//  HoleView.m
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "HoleView.h"

@interface HoleView()
@property (nonatomic,assign,readwrite) CGFloat myFloat;
@end

@implementation HoleView

- (void)blackHoleIncrease:(CGFloat) myFloat{
    self.myFloat = myFloat;
    //手动调用drawRect方法
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    //拿到绘制的上下文
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //false代表逆时针
    CGContextAddArc(context,self.center.x, self.center.y, self.myFloat, 0, M_PI * 2, false);
    CGContextFillPath(context);
    
}

@end
