//
//  IQRetroSnakerState.h
//  IQRetroSnaker
//  配置
//  Created by 程恒盛 on 16/12/19.
//  Copyright © 2016年 力王. All rights reserved.
//

/**
 *  定义单例
 *  @param ... 无实际使用
 */
#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#import <Foundation/Foundation.h>
#define IQGestureDefineInvalidDistance 50.0 //无效距离
typedef enum {
    IQGestureMoveDirectionModeTop = 0,
    IQGestureMoveDirectionModeLeft,
    IQGestureMoveDirectionModeBottom,
    IQGestureMoveDirectionModeRight
}IQGestureMoveDirectionMode;

//当前移动的速度 1-9
//typedef enum {
//    IQGestureMovingSpeedModeHight = 1,
//    IQGestureMovingSpeedModeNormal = 2,
//    IQGestureMovingSpeedModeLow = 3,
//}IQGestureMovingSpeedMode;

@interface IQRetroSnakerState : NSObject
AS_SINGLETON(IQRetroSnakerState);
//是否可以穿过 (default YES)
@property(nonatomic, assign) BOOL canPassWall;
//是否可以穿过 (default YES)
@property(nonatomic, assign) BOOL canPassSelf;
//row表示一行有多少个格子
@property(nonatomic, assign) NSInteger row;
//section表示一竖有多少个格子
@property(nonatomic, assign) NSInteger section;

//获取snaker size
-(CGSize)getSnackerSize;
//获取屏幕尺寸
-(CGRect)getScreenBounds;

#warning 预保留 不可操作
//当前蛇走的方向
@property(nonatomic, assign) IQGestureMoveDirectionMode currentDirection;
//当前蛇移动了总距离
@property(nonatomic, assign) NSInteger allDistance;
//是否可以移动
@property(nonatomic, assign) BOOL isMoveing;
//当前移动的速度 1-9
@property(nonatomic, assign) NSInteger speed;
@end
