//
//  IQTraditionSnakerGameViewController.m
//  IQRetroSnaker
//
//  Created by 程恒盛 on 16/12/13.
//  Copyright © 2016年 力王. All rights reserved.
//

#import "IQTraditionSnakerGameViewController.h"

@interface IQTraditionSnakerGameViewController ()
@property(nonatomic, strong) NSMutableArray <NSIndexPath *>*foods;

@end

@implementation IQTraditionSnakerGameViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.speed = 9;
    [IQRetroSnakerState sharedInstance].canPassWall = YES;
    
    [self startMove];
}
-(NSMutableArray<NSIndexPath *> *)foods{
    if (!_foods) {
        _foods = [[NSMutableArray alloc] init];
    }
    return _foods;
}
#pragma mark - 重写 IQGestureController_baseDelegate 方法
-(void)gestureDidKeepingMove:(IQGestureMoveDirectionMode)direction{
    [super gestureDidKeepingMove:direction];
    //设置蛇的速度标准
    int count = self.snakerView.views.count/5;
    self.speed = 9 - count;
    
    if ([self.snakerIndexPath.firstObject isEqual:self.foods.firstObject]) {
        [self.snakerView addViewWhenTouchTheFood:[IQSnakerView_base class]];
        [self.foods removeObject:self.foods.firstObject];
        [self reloadData];
    }
    if (self.foods.count==0) [self reloadData];
}
-(void)reloadData{
    //随机产生食物
    if (self.foods.count==0) {
        //消除可能存在蛇身上的食物
        NSMutableArray <NSIndexPath *> *indexPaths = [[NSMutableArray alloc] initWithArray:[self.collectionView indexPathsForVisibleItems]];
        [indexPaths removeObjectsInArray:self.snakerIndexPath];
        
        int randNumber = rand()%indexPaths.count;
        NSIndexPath *food = [indexPaths objectAtIndex:randNumber];
        [self.foods addObject:food];
        [self.collectionView reloadData];
    }
}
#pragma mark - 重写 collectionviewDataSource 方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == self.foods.firstObject.row) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
@end
