//
//  ViewController.m
//  CATransition
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong,readwrite) UIImageView *imageView;

@end

@implementation ViewController
//创建的CATransition 尽量使用公有API，使用私有Api上架可能会被拒,~书上是这样写的
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    self.imageView.center       = self.view.center;
    self.imageView.image        = [UIImage imageNamed:@"1.jpg"];
    self.imageView.contentMode  = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    //这里书上是 使用storyBoard加了个按钮。
    [self addOpenButton];
    
}
//点击按钮开始切换动画 滴滴滴~
- (void)animationBegin{
    self.imageView.image = [UIImage imageNamed:@"2.jpg"];
    
    CATransition *animation = [CATransition new];
    animation.duration     = 5.0f;
    //私有api
    //animation.type = @"pageCurl";//翻页效果
    //animation.type = @"oglFlip";//翻转效果
    //animation.type = @"pageUnCurl";//向下翻页效果
    //animation.type = @"cube";//立方体效果
    //下面四个失效了??亲测无效果...
    //animation.type = @"stuckEffect";//收缩效果
    //animation.type = @"rippleEffect";//水滴波纹
    //animation.type = @"cameraIrisHollowOpen";//相机打开效果
    //animation.type = @"cameraIrisHollowClose";//相机关闭效果
    
    //公有api
    //animation.type = kCATransitionMoveIn;//移动效果
    //animation.type = kCATransitionFade;//淡入淡出效果
    //animation.type = kCATransitionPush;//推送效果
    //animation.type = kCATransitionReveal;//揭开效果
    
    [self.view.layer addAnimation:animation forKey:nil];
}

//加个按钮
- (void) addOpenButton{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(53, 50, 100, 100)];
    [btn setTitle:@"Anim" forState:UIControlStateNormal];

    [btn setTitleColor:[UIColor colorWithDisplayP3Red:77.0/255.0 green: 186.0/255.0 blue:122.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(animationBegin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
@end
