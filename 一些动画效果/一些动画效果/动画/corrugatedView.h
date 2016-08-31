//
//  corrugatedView.h
//  一些动画效果
//
//  Created by XF on 16/8/30.
//  Copyright © 2016年 XF. All rights reserved.
//  波纹

#import <UIKit/UIKit.h>

@interface corrugatedView : UIView
@property(nonatomic,assign)CGPoint touchCoordinates;

@property(nonatomic,strong)UIColor * color;

@property(nonatomic,strong)UITapGestureRecognizer * pan;
@end
