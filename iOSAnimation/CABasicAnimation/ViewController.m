//
//  ViewController.m
//  CABasicAnimation
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong,readwrite) UIButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 250, self.view.frame.size.width-20*2, 50)];
    self.loginButton.backgroundColor = [UIColor colorWithDisplayP3Red:50/255.0 green:185/255.0 blue:170/255.0 alpha:1.0];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
}

- (void) viewWillAppear:(BOOL)animated{
    //分析 CABasicAnimation的四种模式
    //    [self testFillMode];
    //1.1位置移动1
    //    [self movePosition1];
    //1.2位置移动2 (压缩X)
    //[self movePosition2];
    //1.3位置移动3 (使用transform)
    //[self movePosition3];
    //2.0旋转
    //[self rotation];
    //3.0圆角
    //[self changeCornerRadius];
    //4.0边框
    //[self changeBorderWidth];
    //5.1背景颜色
    //[self changeColor];
    //5.2边框颜色
    //[self changeBorderColor];
    //6.0淡入效果
    //[self  changeAlpha];
    //7.0阴影渐变动画
    [self changeShadow];
}
//阴影渐变动
- (void)changeShadow{
    self.loginButton.layer.shadowColor   = [UIColor redColor].CGColor;
    //设置阴影的alpha
    self.loginButton.layer.shadowOpacity = 0.5f;
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath   = @"shadowOffset";
    animation.toValue   = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
    animation.duration  = 2.0f;
    animation.fillMode  = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
}
//淡入淡出动画
- (void)changeAlpha{
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath   = @"opacity";
    //设置初试颜色时，默认为0.0,书上是这种方案
    //animation.fromValue = (id)[UIColor greenColor].CGColor;
    animation.fromValue = @(0.0f);
    animation.toValue   = @(1.0f);
    animation.duration  = 2.0f;
    animation.fillMode  = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
}
//设置边框背景颜色动画
- (void)changeBorderColor{
    self.loginButton.layer.borderWidth = 5;
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath   = @"borderColor";
    animation.fromValue = (id)[UIColor greenColor].CGColor;
    animation.toValue   = (id)[UIColor redColor].CGColor;
    animation.duration  = 2.0f;
    animation.fillMode  = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
}
//设置背景颜色
- (void)changeColor{
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath   = @"backgroundColor";
    animation.fromValue = (id)[UIColor greenColor].CGColor;
    animation.toValue   = (id)[UIColor redColor].CGColor;
    animation.duration  = 2.0f;
    animation.fillMode  = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
}
//设置边框动画
- (void)changeBorderWidth{
    //设置边框颜色
    self.loginButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.loginButton.layer.cornerRadius = 10.0;
    
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath  = @"borderWidth";
    animation.toValue  = @(10);
    animation.duration = 2.0f;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
    
}
//设置圆角动画
- (void) changeCornerRadius{
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath  = @"cornerRadius";
    animation.toValue  = @(15);
    animation.duration = 2.0f;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
}
//位置移动
- (void)movePosition3{
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath  = @"transform.translation.y";
    animation.toValue  = @(100);
    animation.duration = 2.0f;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
    
}
//旋转
- (void)rotation{
    CABasicAnimation *animation = [CABasicAnimation new];
    animation.keyPath  = @"transform.rotation";
    animation.toValue  = @(3.14*0.5f);
    animation.duration = 2.0f;
    animation.fillMode = kCAFillModeForwards;
    [animation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:animation forKey:nil];
}
//位置压缩
- (void)movePosition2{
    CABasicAnimation *basicAnimation = [CABasicAnimation new];
    basicAnimation.keyPath   = @"transform.scale.x";
    basicAnimation.fromValue = @(1.0f);
    basicAnimation.toValue   = @(0.5f);
    basicAnimation.duration  = 2.0f;
    basicAnimation.fillMode  = kCAFillModeForwards;
    
    [basicAnimation setRemovedOnCompletion:NO];
    [self.loginButton.layer addAnimation:basicAnimation forKey:nil];
    
    
}
//位置移动
- (void)movePosition1{
    CABasicAnimation *animation = [CABasicAnimation new];
    
    animation.keyPath = @"position";
    CGFloat positionX = self.loginButton.frame.origin.x + 0.5*self.loginButton.frame.size.width;
    CGFloat positionY = self.loginButton.frame.origin.y + 0.5*self.loginButton.frame.size.height +100;
    
    //转成NSValue,toValue是像对于父控件的，byValue代表在原来的基础上进行控制
    animation.toValue  = [NSValue valueWithCGPoint:CGPointMake(positionX, positionY)];
//    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(-20, 100)];
    
    animation.duration = 2.0f;
    //removedOnCompletion：默认为YES，代表动画执行完毕后就从图层上移除，图形会恢复到动画执行前的状态。
    //如果想让图层保持显示动画执行后的状态，那就设置为NO，不过还要设置fillMode为kCAFillModeForwards
    [animation setRemovedOnCompletion:NO];
    animation.fillMode = kCAFillModeForwards;
    
    [self.loginButton.layer addAnimation:animation forKey:nil];
    
}
//分析 CABasicAnimation的四种模式
- (void)testFillMode{
    /*
        kCAFillModeRemoved   默认值,一开始在原始位置,        当动画结束后,回到最初状态
     
        kCAFillModeForwards  一开始在原始位置,              当动画结束后,保持着动画最后的状态
     
        kCAFillModeBackwards 一开始在设定的animation初试位置,当动画结束后，回到最初状态
        
        kCAFillModeBoth      一开始在设定的animation初试位置,当动画结束后，保持着动画最后的状态
        */
    CABasicAnimation * basicAnimation = [[CABasicAnimation alloc] init];
    basicAnimation.keyPath = @"position.y";
    basicAnimation.removedOnCompletion = NO;
    //beginTime : 动画的开始时间
    //CACurrentMediaTime() : 图层的当前时间
    //让动画延迟3秒执行
    basicAnimation.beginTime = CACurrentMediaTime()+3;
    basicAnimation.fillMode = kCAFillModeBoth;
    //动画的开始位置
    basicAnimation.fromValue = @300;
    //动画的结束位置
    basicAnimation.toValue = @500;
    //动画持续时间
    basicAnimation.duration = 3;
    [self.loginButton.layer addAnimation:basicAnimation forKey:nil];
}

@end
