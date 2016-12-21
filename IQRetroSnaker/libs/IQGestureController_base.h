//
//  IQGestureController_base.h
//  IQRetroSnaker
//  贪吃蛇control_base
//  Created by 程恒盛 on 16/12/12.
//  Copyright © 2016年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQRetroSnakerState.h"
#import "IQSnakerView_base.h"
@protocol IQGestureController_baseDelegate <NSObject>
//移动回调
-(void)gestureDidKeepingMove:(IQGestureMoveDirectionMode)direction;
@end

@interface IQGestureController_base : UIViewController<IQGestureController_baseDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) IQSnakerView_base *snakerView;
@property(nonatomic, strong) UIView *backGroundView;
@property(nonatomic, strong) UICollectionView *collectionView;

//蛇的位置
@property(nonatomic, strong, readonly) NSArray <NSIndexPath *> *snakerIndexPath;

//获取下一步位置
-(CGRect)nextSnakerViewPlaceForDirection:(IQGestureMoveDirectionMode) direction;
//当前蛇走的方向
@property(nonatomic, assign) IQGestureMoveDirectionMode currentDirection;
//当前蛇移动了总距离
@property(nonatomic, assign, readonly) NSInteger allDistance;
//是否可以移动
@property(nonatomic, assign, readonly) BOOL isMoveing;
//当前移动的速度 1-9 (设置速度的值在1-9之间)
@property(nonatomic, assign) NSInteger speed;

@property(nonatomic, assign, readonly) NSInteger allNumber;//计数
-(void)startMove;
-(void)stopMove;
@end
