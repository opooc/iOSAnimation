//
//  WaterButton.m
//  GIFgogogo~
//
//  Created by doushuyao on 2020/9/13.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "WaterButton.h"
@interface WaterButton()
@property (nonatomic,assign,readwrite) CGFloat circleCenterX;
@property (nonatomic,assign,readwrite) CGFloat circleCenterY;
@property (nonatomic,strong,readwrite) NSTimer *timer;
@property (nonatomic,assign,readwrite) NSInteger countNum;
@property (nonatomic,assign,readwrite) CGFloat viewRadius;
@property (nonatomic,strong,readwrite) UIColor *targetAnimColor;
@end

@implementation WaterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化各个值
        self.viewRadius = 0.0f;
        self.countNum = 0;
        self.circleCenterX = 0.0f;
        self.circleCenterY = 0.0f;
        //目标颜色
        self.targetAnimColor = [UIColor colorWithDisplayP3Red:216.0 / 255.0 green: 114.0 / 255.0 blue:213.0 / 255.0 alpha:0.8];
        //当前颜色
        self.backgroundColor = [UIColor colorWithDisplayP3Red:50/255.0 green:185/255.0 blue: 170/255.0 alpha:1.0];
    }
    return self;
}

//重新绘制.
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //获取上下文
    CGContextRef ctx    = UIGraphicsGetCurrentContext();
    CGFloat    endangle = M_PI*2;
    //从当前的位置x,y为圆心,以viewRadius为半径 画圆。
    CGContextAddArc(ctx, self.circleCenterX, self.circleCenterY, self.viewRadius, 0, endangle, false);
//    //????
    UIColor *stockColor = self.targetAnimColor;
//  书上这样这，我感觉不好理解
//    [[UIColor blackColor] setStroke];
//    [stockColor setFill];
    //这样写 好理解一些.
    CGContextSetFillColorWithColor(ctx, stockColor.CGColor);
    CGContextFillPath(ctx);
    
}
//按钮点击时调用该方法
- (void)startButtonAnimationWithButton:(UIButton *)msenderBt AndEvent:(UIEvent *)mevent{
    //1.设置为不可点击
    [self setUserInteractionEnabled:NO];
    //2.拿触摸事件用来拿位置
    //button转型为UIView,这里之所以可以转是因为，button是继承自UIControl,而UIControl是继承自UIView
    UIView *buttonView = (UIView*)msenderBt;
    //获取按钮事件集
    NSSet *touchSet    = [mevent touchesForView:buttonView];
    
    //书上的这样转换会报错，找不到对象！
    //把按钮事件集转成数组形式
    //NSArray *touchArr  = [NSArray arrayWithObject:touchSet.allObjects];
    //拿到第一个触摸事件
    //UITouch *touch1    = touchArr[0];
    
    //正确拿法
    UITouch *touch1    = [touchSet anyObject];
    //拿位置
    CGPoint point1     = [touch1 locationInView:buttonView];
    //取到具体位置
    self.circleCenterX = point1.x;
    self.circleCenterY = point1.y;
    //3.使用计时器定时刷新水纹动画
    self.timer         = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(timeAction) userInfo:nil repeats:true];
    //4.把timer放到NSRunLoop的当前线程中
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

//定时器调用的方法
- (void)timeAction{
    //用来统计次数
    self.countNum += 1;
    
    //异步刷新自己的viewRadius,然后更新 调用draw方法。
    dispatch_async(dispatch_get_main_queue(), ^{
        self.viewRadius += 6 ;
        [self setNeedsDisplay];
    });
    if (self.countNum > 50) {
        self.countNum   = 0;
        self.viewRadius = 0;
        [self.timer invalidate];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewRadius = 0;
            [self setNeedsDisplay];
        });
        [self setUserInteractionEnabled:YES];
    }

}

@end
