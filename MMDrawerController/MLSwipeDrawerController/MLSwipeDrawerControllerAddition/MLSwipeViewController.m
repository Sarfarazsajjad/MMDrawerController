//
//  MLSwipeViewController.m
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/20.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MLSwipeViewController.h"
#import "MLSwipeDrawerController.h"

@interface MLSwipeViewController ()

@end

@implementation MLSwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - status bar
- (BOOL)prefersStatusBarHidden
{
    return ((MLSwipeDrawerController*)self.mm_drawerController).statusBarShouldBeHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}

@end
