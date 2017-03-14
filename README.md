# IQRetroSnaker
贪吃蛇-Objective-C 游戏-RetroSnaker

* 本来打算做一个完整的贪吃蛇游戏，但是毕竟有工作，最近有点忙，有点过头了。先忙完手头上的事再继续写吧。现在的只是初稿，不过基本逻辑已经写好~~
   
效果图

![image] (https://raw.githubusercontent.com/HersonIQ/IQRetroSnaker/master/蛇蛇蛇.gif)

片段代码：
~~~
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
~~~

娱人愚己，自娱自乐。  i'm here https://www.zhihu.com/people/EngCCC
