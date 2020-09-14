//
//  ViewController.m
//  CoverFlow
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong,readwrite) NSArray <UIImageView *> *imageViewArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 250)];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 250)];
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 300, 200)];
    
    self.imageViewArray = @[imageView1,imageView2,imageView3];
    
    for (int i = 0 ; i < self.imageViewArray.count; i++) {
        NSString *imageName                      = [NSString stringWithFormat:@"%d.jpg",i];
        self.imageViewArray[i].image             = [UIImage imageNamed:imageName];
        CGPoint newPoint                         = CGPointMake(self.imageViewArray[i].layer.anchorPoint.x, 0.0f);
        self.imageViewArray[i].layer.anchorPoint = newPoint;//设定新的y=0 代表只能沿左侧的y轴旋转
        [self.view addSubview:self.imageViewArray[i]];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    for (int i = 0; i < self.imageViewArray.count; i++) {
        //构建新的3D转换
        CATransform3D imageTransform = CATransform3DIdentity;
        imageTransform.m34           = -0.005; //透视
        imageTransform = CATransform3DTranslate(imageTransform, 0.0f, 50.0f, 0.0f);//位置变换
        imageTransform = CATransform3DScale(imageTransform, 0.95f, 0.6f, 1.0f);//缩放变换
        
        //第一张和第二张图旋转
        if (i == 0) {
            imageTransform = CATransform3DRotate(imageTransform, M_PI_4/2, 0.0, 1.0, 0.0);
        }else if (i == 1){
            imageTransform = CATransform3DRotate(imageTransform, -M_PI_4/2, 0.0, 1.0, 0.0);
        }
        
        UIImageView *imageView      = [self.imageViewArray objectAtIndex:i];
        CABasicAnimation *animation = [CABasicAnimation new];
        animation.keyPath           = @"transform";//旋转动画
        animation.fromValue         = [NSValue valueWithCATransform3D:imageView.layer.transform];
        animation.toValue           = [NSValue valueWithCATransform3D:imageTransform];
        animation.duration          = 3.0f;
        
        CABasicAnimation *animBounds = [CABasicAnimation new];
        animBounds.keyPath           = @"position";//位置动画
        animBounds.duration          = 3.0f;
        if (i == 0) {
            animBounds.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 10)];
        }else if (i == 1){
            animBounds.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 10)];
        }else{
            animBounds.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 20)];
        }
        
        CAAnimationGroup *animGroup     = [CAAnimationGroup new];
        animGroup.duration              = 3.0f;
        animGroup.repeatCount           = 1;
        [animGroup setRemovedOnCompletion:NO];
        animGroup.fillMode              = kCAFillModeForwards;
        animGroup.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animGroup.animations            = @[animation,animBounds];
        
        NSString *key = [NSString stringWithFormat:@"%d",i];
        [imageView.layer addAnimation:animGroup forKey:key];
    }
}

@end
