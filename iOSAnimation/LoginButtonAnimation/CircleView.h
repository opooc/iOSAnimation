//
//  CircleView.h
//  LoginButtonAnimationEffect
//
//  Created by doushuyao on 2020/9/13.
//  Copyright © 2020 com.opooc.DesignPatterns. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol CircleDelegate <NSObject>
//必须实现
@required
- (void)circleAnimationStop;

@end

@interface CircleView : UIView

@property (nonatomic,weak,readwrite) id<CircleDelegate> delegate;

- (void) strokeChart;

@end

NS_ASSUME_NONNULL_END
