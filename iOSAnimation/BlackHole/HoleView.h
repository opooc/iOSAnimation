//
//  HoleView.h
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/12.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HoleView : UIView
//内部调用的是绘制方法
- (void)blackHoleIncrease:(CGFloat) myFloat;

@end

NS_ASSUME_NONNULL_END
