//
//  ViewController.m
//  VCTransitions
//
//  Created by doushuyao on 2020/9/14.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "TransitionAnim.h"
@interface ViewController () <UINavigationControllerDelegate>

@property (nonatomic,strong,readwrite) SecondViewController *secondViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title                = @"Main Viewcontroller";
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationController.delegate = self;
    
    self.secondViewController = [[SecondViewController alloc]init];
    //这里不能在nav上加，加上反而会直接压住。
//    [self.navigationController addChildViewController:self.secondViewController];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    TransitionAnim *transitionAnim = [TransitionAnim new];
    return transitionAnim;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:  self.secondViewController animated:YES];

}
@end
