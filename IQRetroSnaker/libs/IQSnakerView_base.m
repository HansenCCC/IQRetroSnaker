//
//  IQSnakerView_base.m
//  IQRetroSnaker
//
//  Created by 程恒盛 on 16/12/19.
//  Copyright © 2016年 力王. All rights reserved.
//

#import "IQSnakerView_base.h"

@interface IQSnakerView_base ()
@property(nonatomic, strong) NSMutableArray <IQSnakerView_base *>*views;

@end
@implementation IQSnakerView_base
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self reloadView];
    }
    return self;
}
-(void)reloadView{
    [self.views addObject:self];
}
-(void)addViewWhenTouchTheFood:(Class)classView{
    IQSnakerView_base *view = [[classView alloc] init];
    if ([view isKindOfClass:[IQSnakerView_base class]]) {
        [self.views addObject:view];
        view.backgroundColor = self.backgroundColor;
        [self.superview addSubview:view];
    }
}
-(NSMutableArray<IQSnakerView_base *> *)views{
    if (!_views) {
        _views = [[NSMutableArray alloc] init];
    }
    return _views;
}

#pragma mark - layout
-(void)setFrame:(CGRect)frame{
    self.lastFrame = self.frame;
    [super setFrame:frame];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置蛇身frame值
    for (int i = 1; i<_views.count; i++) {
        IQSnakerView_base *lastView = [_views objectAtIndex:i-1];
        IQSnakerView_base *currentView = [_views objectAtIndex:i];
        currentView.frame = lastView.lastFrame;
    }
}
@end
