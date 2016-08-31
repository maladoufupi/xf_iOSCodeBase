//
//  roundView.m
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//

#import "roundView.h"

@implementation roundView

-(instancetype)init
{
    if (self= [super init])
    {
        self.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        
        [self createObjc];
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 100)];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(shou) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

//初始化属性
-(void)createObjc
{
    _shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_shapeLayer];
    _shapeLayer.fillColor = [UIColor colorWithRed:0.400 green:0.400 blue:1.000 alpha:1.000].CGColor;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrame)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

//不断画圆
-(void)updateFrame
{
    _path = [UIBezierPath bezierPathWithArcCenter:_beginPoint radius:[self getRadius] startAngle:0 endAngle:M_PI*2 clockwise:YES];
    _shapeLayer.path = _path.CGPath;
}

//计算出圆的半径
- (CGFloat)getRadius
{
    CGFloat result = sqrt(pow(_endPoint.x-_beginPoint.x, 2)+pow(_endPoint.y-_beginPoint.y, 2));
    if (_isTouchEnd) {
        CGFloat animationDuration = 1.0; // 弹簧动画持续的时间
        int maxFrames = animationDuration / _displayLink.duration;
        _currentFrame++;
        
        if (_currentFrame <= maxFrames) {
            CGFloat factor = [self getSpringInterpolation:(CGFloat)(_currentFrame) / (CGFloat)(maxFrames)]; //根据公式计算出弹簧因子
            return 50 + (result - 50) * factor; // 根据弹簧因子计算当前帧的圆半径
        }else {
            return 50;
        }
        
    }
    return result;
}

//起始点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _beginPoint = point;
    _endPoint = point;
    
    _isTouchEnd = NO;
    _currentFrame = 1;
}
//结束点
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _endPoint = point;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _isTouchEnd = YES; //触摸结束，更新触摸状态
    
}

-(void)shou
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (CGFloat)getSpringInterpolation:(CGFloat)x
{
    CGFloat tension = 0.3; // 张力系数
    return pow(2, -10 * x) * sin((x - tension / 4) * (2 * M_PI) / tension);
}
@end
