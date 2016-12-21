//
//  IQRetroSnakerState.m
//  IQRetroSnaker
//
//  Created by 程恒盛 on 16/12/19.
//  Copyright © 2016年 力王. All rights reserved.
//

#import "IQRetroSnakerState.h"

@implementation IQRetroSnakerState
DEF_SINGLETON(IQRetroSnakerState);
-(instancetype)init{
    if (self = [super init]) {
        self.canPassWall = YES;
        self.canPassSelf = NO;
    }
    return self;
}
//默认一行8个格子
-(NSInteger)row{
    return 8;
}
-(NSInteger)section{
    int row = self.row;
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize snakerSize = CGSizeMake(bounds.size.width/row, bounds.size.width/row);
    NSInteger hNum = (NSInteger)bounds.size.height/snakerSize.height;
    return hNum;
}
-(CGSize)getSnackerSize{
    
    int row = self.row;
    int section = self.section;
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect f1 = bounds;
    f1.size.height = bounds.size.height/section;
    f1.size.width = bounds.size.width/row;
    return f1.size;
}
-(CGRect)getScreenBounds{
    CGRect bounds = [UIScreen mainScreen].bounds;
    return bounds;
}
@end
