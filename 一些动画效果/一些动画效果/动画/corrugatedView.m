//
//  corrugatedView.m
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "corrugatedView.h"
#import "circleView.h"
@implementation corrugatedView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //[self initialization];
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:0.5];
//        _pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panOne)];
//        [self addGestureRecognizer:_pan];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self initialization];
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:0.5];
    }
    return self;
}

-(void)panOne
{
    NSLog(@"调用了手势方法");
    [self createView];
    
}

-(void)animationWithItemIndex:(circleView *)circle
{
    NSLog(@"走动画了");
    //获取这个控件
    __block CGRect frame = circle.frame;
    //动画时间
    NSInteger randomDuration = arc4random() % 40+10;
    //等待时间
    NSInteger randomDelay = arc4random() % 40+20;
    [UIView animateWithDuration:randomDuration/15.0 delay:randomDelay/70.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        //扩散动画
        frame.size.height = self.bounds.size.height;
        frame.size.width = self.bounds.size.height;
        circle.frame = frame;
        circle.center = CGPointMake(_touchCoordinates.x, _touchCoordinates.y);
        circle.alpha = 0.0;
        [circle setNeedsDisplay];
        
    } completion:^(BOOL finished) {
        
        circle.alpha = 0.9;
        circle.frame = CGRectZero;
        circle.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        
        //进行一次扩散后就删除
        [circle removeFromSuperview];
        
        //循环扩散不删除
        //[self animationWithItemIndex:circle];
    }];
}

-(void)createView
{
    NSLog(@"调用创建控件");
    CGRect frame = CGRectZero;
    circleView * view = [[circleView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.center = CGPointMake(_touchCoordinates.x, _touchCoordinates.y);
    view.alpha = 0.9;
    view.tintColor = [UIColor orangeColor];
    view.userInteractionEnabled = NO;
    [self addSubview:view];
    [self animationWithItemIndex:view];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点了屏幕");
    
    UITouch *touch = [touches anyObject];
    _touchCoordinates = [touch locationInView:self];
    [self createView];
}
@end
