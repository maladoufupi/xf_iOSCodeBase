//
//  roundView.h
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//  圆球

#import <UIKit/UIKit.h>

@interface roundView : UIView
@property(nonatomic,strong)CADisplayLink * displayLink;
@property(nonatomic,strong)UIBezierPath * path;
@property(nonatomic,assign)CGPoint beginPoint;
@property(nonatomic,assign)CGPoint endPoint;
@property(nonatomic,strong)CAShapeLayer * shapeLayer;
@property(nonatomic,assign)BOOL isTouchEnd;
@property(nonatomic,assign)int currentFrame;
@end
