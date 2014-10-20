//
//  MLSwipeDrawerController.m
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MLSwipeDrawerController.h"
#import "MMDrawerController+MLSwipeSubclass.h"
#import "MMDrawerController+Subclass.h"
#import "MLSwipeGestureRecognizer.h"

@interface MLSwipeDrawerController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) MLSwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) MLSwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic, assign) BOOL statusBarShouldBeHidden;

@end

@implementation MLSwipeDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 覆盖父级别初始化手势这块，不添加pan手势，添加swipe手势，这样就能去掉了默认的pan实现
-(void)setupGestureRecognizers{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCallback:)];
    [tap setDelegate:self];
    [self.view addGestureRecognizer:tap];
    
    MLSwipeGestureRecognizer * leftSwipe = [[MLSwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureCallback:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftSwipe setDelegate:self];
    [self.view addGestureRecognizer:leftSwipe];
    self.leftSwipeGestureRecognizer = leftSwipe;
    
    MLSwipeGestureRecognizer * rightSwipe = [[MLSwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureCallback:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [rightSwipe setDelegate:self];
    [self.view addGestureRecognizer:rightSwipe];
    self.rightSwipeGestureRecognizer = rightSwipe;
    
    self.openDrawerGestureModeMask |= MMOpenDrawerGestureModeCustom;
    self.closeDrawerGestureModeMask |= MMCloseDrawerGestureModeCustom;
    [self setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        if ([gesture isEqual:leftSwipe]||[gesture isEqual:rightSwipe]) {
            //最好加一些位置检测，对我来说暂时没这个必要
            return YES;
        }else{
            return NO;
        }
    }];
}

#pragma mark - swipe callback
-(void)swipeGestureCallback:(UISwipeGestureRecognizer *)swipeGesture{
    //到这里时候swipeGesture.state 只会是 UIGestureRecognizerStateEnded
    if (self.openSide==MMDrawerSideNone) {
        MMDrawerSide toOpenSide = MMDrawerSideNone;
        //判断是拉开左边还是右边
        if (UISwipeGestureRecognizerDirectionLeft==swipeGesture.direction) {
            toOpenSide = MMDrawerSideRight;
        }else if (UISwipeGestureRecognizerDirectionRight==swipeGesture.direction) {
            toOpenSide = MMDrawerSideLeft;
        }
        if (toOpenSide!=MMDrawerSideNone) {
            if ([self sideDrawerViewControllerForSide:toOpenSide]) { //尽量不做无用的工作
                [self openDrawerSide:toOpenSide animated:YES completion:^(BOOL finished) {
                    if(self.gestureCompletion){
                        self.gestureCompletion(self, swipeGesture);
                    }
                }];
            }
        }
    }else{
        if ((UISwipeGestureRecognizerDirectionLeft == swipeGesture.direction&&self.openSide==MMDrawerSideLeft)||(UISwipeGestureRecognizerDirectionRight == swipeGesture.direction&&self.openSide==MMDrawerSideRight)) {
            [self closeDrawerAnimated:YES completion:^(BOOL finished) {
                if(self.gestureCompletion){
                    self.gestureCompletion(self, swipeGesture);
                }
            }];
        }
    }
}

-(void)openDrawerSide:(MMDrawerSide)drawerSide animated:(BOOL)animated velocity:(CGFloat)velocity animationOptions:(UIViewAnimationOptions)options completion:(void (^)(BOOL))completion
{
    if (self.isAnimatingDrawer) {
        [super openDrawerSide:drawerSide animated:animated velocity:velocity animationOptions:options completion:completion];
        return;
    }
    
    UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:drawerSide];
    if (sideDrawerViewController) {
        //得通知下当前需要隐藏状态栏
        self.statusBarShouldBeHidden = YES;
    }
    
    [super openDrawerSide:drawerSide animated:animated velocity:velocity animationOptions:options completion:completion];
    
    if (!sideDrawerViewController) {
        //下面修正MM里的一个BUG，这个BUG会引起例如无左侧滑VC时候，界面不响应触摸
        [self setAnimatingDrawer:NO];
    }
}

- (void)closeDrawerAnimated:(BOOL)animated completion:(void (^)(BOOL))completion
{
    if (self.isAnimatingDrawer) {
        [super closeDrawerAnimated:animated completion:completion];
        return;
    }
    
    self.statusBarShouldBeHidden = NO;
    
    [super closeDrawerAnimated:animated completion:completion];
}

@end
