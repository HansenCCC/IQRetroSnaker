//
//  IQSnakerView_base.h
//  IQRetroSnaker
//  snaker 
//  Created by 程恒盛 on 16/12/19.
//  Copyright © 2016年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IQSnakerView_base : UIView
@property(nonatomic, readonly) NSMutableArray <IQSnakerView_base *>*views;


//self上一个的frame
@property(nonatomic, assign) CGRect lastFrame;

/**
 添加蛇的身体

 @param classView IQSnakerView_base的子类或者本身
 */
-(void)addViewWhenTouchTheFood:(Class)classView;
@end
