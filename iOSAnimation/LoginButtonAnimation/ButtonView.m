//
//  ButtonView.m
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/13.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ButtonView.h"
#import "CircleView.h"
@interface ButtonView() <CircleDelegate,CAAnimationDelegate>

@property (nonatomic,strong,readwrite) UIColor *FreshBule;
@property (nonatomic,strong,readwrite) UIColor *FreshGreen;
@property (nonatomic,strong,readwrite) UIView  *view;
@property (nonatomic,strong,readwrite) UIView  *viewborder;
@property (nonatomic,assign,readwrite) CGFloat button_x;
@property (nonatomic,assign,readwrite) CGFloat button_y;
@property (nonatomic,assign,readwrite) CGFloat button_w;
@property (nonatomic,assign,readwrite) CGFloat button_h;
@property (nonatomic,strong,readwrite) UILabel *label;
@property (nonatomic,strong,readwrite) CircleView *circleView;

@end
@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button_x   = frame.origin.x;
        self.button_y   = frame.origin.y;
        self.button_w   = frame.size.width;
        self.button_h   = frame.size.height;
        
        self.FreshBule  = [UIColor colorWithDisplayP3Red:25.0 / 255.0 green:155.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
        self.FreshGreen = [UIColor colorWithDisplayP3Red:150.0 / 255.0 green:203.0 / 255.0 blue:25.0 / 255.0 alpha:1.0];
        
        self.view                 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.button_w, self.button_h)];
        self.view.backgroundColor = self.FreshBule;
        
        self.viewborder                   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.button_w, self.button_h)];
        self.viewborder.backgroundColor   = [UIColor clearColor];
        self.viewborder.layer.borderColor = self.FreshBule.CGColor;
        self.viewborder.layer.borderWidth = 3.0f;
        
        [self addSubview:self.view];
        [self addSubview:self.viewborder];
        
        self.circleView = [[CircleView alloc]initWithFrame:CGRectMake(0, 0, self.button_w, self.button_h)];
        self.circleView.delegate = self;
        [self addSubview:self.circleView];
        
        //添加按钮的label
        self.label               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.button_w, self.button_h)];
        self.label.text          = @"UpLoad";
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor     = [UIColor whiteColor];
        self.label.font          = [UIFont systemFontOfSize:20.0f];
        [self addSubview:self.label];
    }
    return self;
}

- (void)startAnimation{
    [self.label removeFromSuperview];
    //圆角
    CABasicAnimation *animMakeBigger = [CABasicAnimation new];
    animMakeBigger.keyPath   = @"cornerRadius";
    animMakeBigger.fromValue = @(5.0);
    animMakeBigger.toValue   = @(self.button_h*0.5);
    
    //位置
    CABasicAnimation *animBounds = [CABasicAnimation new];
    animBounds.keyPath   = @"bounds";
    animBounds.toValue   = [NSValue valueWithCGRect:CGRectMake(self.button_x+(self.button_w - self.button_h)*0.5f, self.button_h, self.button_h, self.button_h)];
    
    //透明度
    CABasicAnimation *animAlpha = [CABasicAnimation new];
    animAlpha.keyPath   = @"opacity";
    animAlpha.toValue   = @(0);

    //边框颜色
    CABasicAnimation *animborder = [CABasicAnimation new];
    animborder.keyPath   = @"borderColor";
    //注意,这里得转CGColor,还要取id类型
    animborder.toValue   = (id)([[UIColor colorWithDisplayP3Red:224.0/255 green:224.0/255 blue:224.0/255 alpha:1.0] CGColor]);

    //创建内部view动画组
    CAAnimationGroup *animGroup = [CAAnimationGroup new];
    animGroup.duration          = 1.0f;
    animGroup.repeatCount       = 1;
    [animGroup setRemovedOnCompletion:NO];
    animGroup.fillMode = kCAFillModeForwards;
    //设置进入的曲线变化
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroup.animations = @[animMakeBigger,animBounds,animAlpha];

    //创建外部view动画组
    CAAnimationGroup *animGroupAll = [CAAnimationGroup new];
    animGroupAll.duration    = 1.0f;
    animGroupAll.repeatCount = 1;
    [animGroupAll setRemovedOnCompletion:NO];
    animGroupAll.fillMode    = kCAFillModeForwards;
    animGroupAll.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animGroupAll.animations  = @[animMakeBigger,animBounds,animborder];
    
    //开始之前提交个代理，用来检测是否结束
    animGroupAll.delegate  = self;
    //设置边框view的动画类型的键值对
    [animGroupAll setValue:@"allMyAnimationsBoard" forKey:@"groupborderkey"];
    
    //开始提交动画    CATransaction 是提交事务||CATransition 是 过渡动画
    [CATransaction begin];
    //为啥要设置key??????
    [self.view.layer addAnimation:animGroup forKey:@"allMyAnimation"];
    [self.viewborder.layer addAnimation:animGroupAll forKey:@"allMyAnimationsBoard"];
    [CATransaction commit];
    

}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //判断是否结束
    if (flag) {
        //拿到类型
        NSString *animType = [anim valueForKey:@"groupborderkey"];
        NSString *animType1 = [anim valueForKey:@"groupborderkey1"];
        if (animType != nil) {
            if ([animType isEqualToString:@"allMyAnimationsBoard"]) {
                //去画圈圈
                [self.circleView strokeChart];
            }
        }else if (animType1 != nil){
            if ([animType1 isEqualToString:@"allMyAnimationsBoardspread1"]) {
                self.label               = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.button_w, self.button_h)];
                self.label.text          = @"Complete";
                self.label.textAlignment = NSTextAlignmentCenter;
                self.label.textColor     = [UIColor whiteColor];
                self.label.font          = [UIFont systemFontOfSize:20.0f];
                [self addSubview:self.label];
            }
        }
        
    }
}

- (void)startAnimationSpread{
    //设置成直角
    CABasicAnimation *animMakeBigger = [CABasicAnimation new];
    animMakeBigger.keyPath   = @"cornerRadius";
    animMakeBigger.fromValue = @(self.button_h * 0.5);
    animMakeBigger.toValue   = @(0);
    
    //位置
    CABasicAnimation *animBounds = [CABasicAnimation new];
    animBounds.keyPath   = @"bounds";
    animBounds.fromValue = [NSValue valueWithCGRect:CGRectMake(self.button_x+(self.button_w - self.button_h)*0.5f, self.button_h, self.button_h, self.button_h)];
    //这里的0 ，0应该是相对于自己
    animBounds.toValue   = [NSValue valueWithCGRect:CGRectMake(0, 0, self.button_w, self.button_h)];

    //透明度
    CABasicAnimation *animAlpha = [CABasicAnimation new];
    animAlpha.keyPath   = @"opacity";
    animAlpha.toValue   = @(1.0);

    //背景色
    CABasicAnimation *animBackground = [CABasicAnimation new];
    animBackground.keyPath   = @"backgroundColor";
    animBackground.toValue   = (id)self.FreshGreen.CGColor;
    
    //边框颜色
    CABasicAnimation *animborder = [CABasicAnimation new];
    animborder.keyPath   = @"borderColor";
    //注意,这里得转CGColor,还要取id类型
    animborder.toValue   = (id)([[UIColor colorWithDisplayP3Red:224.0/255 green:224.0/255 blue:224.0/255 alpha:1.0] CGColor]);

    //创建内部view动画组
    CAAnimationGroup *group = [CAAnimationGroup new];
    group.duration          = 1.0f;
    group.repeatCount       = 1;
    [group setRemovedOnCompletion:NO];
    group.fillMode = kCAFillModeForwards;
    //设置进入的曲线变化
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.animations     = @[animMakeBigger,animBounds,animAlpha,animBackground];

    //创建外部view动画组
    CAAnimationGroup *allGroup = [CAAnimationGroup new];
    allGroup.duration    = 1.0f;
    allGroup.repeatCount = 1;
    [allGroup setRemovedOnCompletion:NO];
    allGroup.fillMode    = kCAFillModeForwards;
    allGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //没有加animAlpha
    allGroup.animations  = @[animMakeBigger,animBounds,animborder];

    //开始之前提交个代理，用来检测是否结束
    allGroup.delegate  = self;
    //设置边框view的动画类型的键值对
    [allGroup setValue:@"allMyAnimationsBoardspread1" forKey:@"groupborderkey1"];

    //开始提交动画    CATransaction 是提交事务||CATransition 是 过渡动画
    [CATransaction begin];
    //为啥要设置key??????
    
    [self.view.layer addAnimation:group forKey:@"allMyAnimationspread1"];
    [self.viewborder.layer addAnimation:allGroup forKey:@"allMyAnimationsBoardspread1"];
    
    [CATransaction commit];

    
}

//实现代理方法，用来回调
- (void)circleAnimationStop{
    [self.circleView removeFromSuperview];
    [self startAnimationSpread];
}
@end


















