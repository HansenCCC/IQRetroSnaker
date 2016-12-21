//
//  IQGestureController_base.m
//  IQRetroSnaker
//
//  Created by 程恒盛 on 16/12/12.
//  Copyright © 2016年 力王. All rights reserved.
//

#import "IQGestureController_base.h"

@interface IQGestureController_base ()
@property(nonatomic, strong) NSTimer *timerControl;//时间控制器
@property(nonatomic, assign) NSInteger allDistance;
@property(nonatomic, assign) BOOL isMoveing;
@property(nonatomic, assign) NSInteger allNumber;//计数
@end

@implementation IQGestureController_base
-(instancetype)init{
    if(self = [super init]){
        self.allNumber = 0;
        self.allDistance = 0;
        self.speed = 9;
        self.isMoveing = NO;
        _currentDirection = IQGestureMoveDirectionModeRight;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backGroundView = [[UIView alloc] init];
    [self.backGroundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.backGroundView];
    //collection 作为食物
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout  alloc] init];
    flowLayout.itemSize = [IQRetroSnakerState sharedInstance].getSnackerSize;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.backGroundView addSubview:self.collectionView];
    [self.collectionView reloadData];
    
    CGSize snakerSize = [IQRetroSnakerState sharedInstance].getSnackerSize;
    CGRect f1 = [UIScreen mainScreen].bounds;
    f1.size = snakerSize;
    self.snakerView = [[IQSnakerView_base alloc] initWithFrame:f1];
    self.snakerView.backgroundColor = [UIColor blackColor];
    [self.backGroundView addSubview:self.snakerView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(__OnPanGestureControl:)];
    [self.view addGestureRecognizer:panGesture];
    
    self.timerControl = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(__OnControlKeepMove:) userInfo:nil repeats:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.timerControl invalidate];
    self.timerControl = nil;
}
-(void)dealloc{
    [self.timerControl invalidate];
    self.timerControl = nil;
}
-(void)setDirection:(IQGestureMoveDirectionMode)direction{
    _currentDirection = direction;
}
-(void)__OnControlKeepMove:(NSTimer *)sender{
    if (!self.isMoveing) return;
    _allNumber++;
    NSInteger speedMode = self.speed;
    if(_allNumber%speedMode == 0)
    [self gestureDidKeepingMove:_currentDirection];
}
-(void)startMove{
    self.isMoveing = YES;
}
-(void)stopMove{
    self.isMoveing = NO;
}
-(void)setIsMoveing:(BOOL)isMoveing{
    _isMoveing = isMoveing;
    [IQRetroSnakerState sharedInstance].isMoveing = isMoveing;
}
-(void)setAllDistance:(NSInteger)allDistance{
    _allDistance = allDistance;
    [IQRetroSnakerState sharedInstance].allDistance = allDistance;
}
-(void)setCurrentDirection:(IQGestureMoveDirectionMode)currentDirection{
    _currentDirection = currentDirection;
    [IQRetroSnakerState sharedInstance].currentDirection = currentDirection;
}
-(void)setSpeed:(NSInteger)speed{
    if (speed<1) speed = 1;
    if (speed>9) speed = 9;
    _speed = speed;
    [IQRetroSnakerState sharedInstance].speed = speed;
}
//获取下一步位置
-(CGRect)nextSnakerViewPlaceForDirection:(IQGestureMoveDirectionMode) direction{
    CGRect f1 = self.snakerView.frame;
    CGPoint movePoint = f1.origin;
    BOOL canPass = [IQRetroSnakerState sharedInstance].canPassWall;
    CGSize sanckerSize = f1.size;//蛇的尺寸
    CGFloat snakerMaxY = CGRectGetMaxY(f1);//最Y的位置
    CGFloat snakerMaxX = CGRectGetMaxX(f1);//最X的位置
    CGRect bounds = [IQRetroSnakerState sharedInstance].getScreenBounds;
    switch (direction) {
        case IQGestureMoveDirectionModeTop:
        {
            //当移到最顶部
            if(movePoint.y < sanckerSize.height/2&&movePoint.y > -sanckerSize.height/2){
                movePoint.y = bounds.size.height;
                if (!canPass) {
                    [self stopMove];
                }
            }
            movePoint.y += -sanckerSize.height;
        }
            break;
        case IQGestureMoveDirectionModeLeft:
        {
            //当移到最左边
            if(movePoint.x < sanckerSize.width/2&&movePoint.x > -sanckerSize.width/2){
                movePoint.x = bounds.size.width;
                if (!canPass) {
                    [self stopMove];
                }
            }
            movePoint.x += -sanckerSize.width;
        }
            break;
        case IQGestureMoveDirectionModeBottom:
        {
            //当移到最顶部
            if((snakerMaxY - bounds.size.height) < sanckerSize.height/2&&(snakerMaxY - bounds.size.height)> -sanckerSize.height/2){
                movePoint.y = -sanckerSize.height;
                if (!canPass) {
                    [self stopMove];
                }
            }
            movePoint.y += sanckerSize.height;
        }
            break;
        case IQGestureMoveDirectionModeRight:
        {
            //当移到最右边
            if(snakerMaxX - bounds.size.width < sanckerSize.width/2&&snakerMaxX - bounds.size.width > -sanckerSize.width/2){
                movePoint.x = -sanckerSize.width;
                if (!canPass) {
                    [self stopMove];
                }
            }
            movePoint.x += sanckerSize.width;
        }
            break;
        default:
            break;
    }
    f1.origin = movePoint;
    return f1;
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.backGroundView.frame= bounds;
    self.collectionView.frame = bounds;

}
-(NSArray<NSIndexPath *> *)snakerIndexPath{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for (IQSnakerView_base * snakerView in self.snakerView.views) {
        CGPoint center = snakerView.center;
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:center];
        if (![indexPaths containsObject:indexPath]) {
            if (indexPath)
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}
#pragma mark - UIGestureRecognizer
-(void)__OnPanGestureControl:(UIPanGestureRecognizer *)panGesture{
    //根据摇动、拖拽手势判断选择方向
    if (panGesture.state != UIGestureRecognizerStateEnded) return;
    // translation in the coordinate system of the specified view
    CGPoint pointTranslation = [panGesture translationInView:self.view];
    //当滑动距离在无效距离内时 return
    if (fabs(pointTranslation.x)<IQGestureDefineInvalidDistance&&fabs(pointTranslation.y)<IQGestureDefineInvalidDistance) return;
    //判断是垂直还是水平方向
    IQGestureMoveDirectionMode direction;
    if(fabs(pointTranslation.x) >= fabs(pointTranslation.y)){
        if (pointTranslation.x>0) {
            direction = IQGestureMoveDirectionModeRight;
        }else{
            direction = IQGestureMoveDirectionModeLeft;
        }
    }else{
        if (pointTranslation.y<0) {
            direction = IQGestureMoveDirectionModeTop;
        }else{
            direction = IQGestureMoveDirectionModeBottom;
        }
    }
    if (self.currentDirection != direction) {
        self.direction = direction;
    }
}

#pragma mark - IQGestureController_baseDelegate
-(void)gestureDidKeepingMove:(IQGestureMoveDirectionMode)direction{
    self.allDistance++;
    self.snakerView.frame = [self nextSnakerViewPlaceForDirection:direction];
    [self.snakerView setNeedsLayout];
}
#pragma mark - UICollectionViewDelegate && UICollectionDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger all = [IQRetroSnakerState sharedInstance].row * [IQRetroSnakerState sharedInstance].section;
    return all;
}

#pragma mark - 关闭横屏
- (BOOL)shouldAutorotate{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0){
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
    return mask;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    UIInterfaceOrientation orientation = UIInterfaceOrientationPortrait;
    return orientation;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
