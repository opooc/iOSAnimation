//
//  ViewController.m
//  KeyLuckyDraw
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, assign, readwrite) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
    self.imageView.frame = UIScreen.mainScreen.bounds;
    self.imageView.image = [UIImage imageNamed:@"turntable"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    [self animationCircle];
}
- (void) animationCircle{
    [UIView animateKeyframesWithDuration:0.2f delay:0 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.25f animations:^{
            self.index += 1;
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 * self.index);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25f relativeDuration:0.25f animations:^{
            self.index += 1;
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 * self.index);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.25f animations:^{
            self.index += 1;
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 * self.index);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75f relativeDuration:0.25f animations:^{
            self.index += 1;
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 * self.index);
        }];
        
        
    } completion:^(BOOL finished) {
        [self animationCircle];
    }];
    
}

@end
