//
//  MLSwipeTableViewController.m
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MLSwipeTableViewController.h"
#import "MLSwipeTableView.h"
#import "MLSwipeDrawerController.h"

@implementation MLSwipeTableViewController

- (void)loadView
{
    self.tableView = [MLSwipeTableView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.top = self.navigationController.navigationBar.intrinsicContentSize.height + 20.0f;
    self.tableView.contentInset = inset;
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

#pragma mark Rotation
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.top = self.navigationController.navigationBar.intrinsicContentSize.height + 20.0f;
    
    CGFloat adjustOffsetY = self.tableView.contentInset.top - inset.top;
    
    self.tableView.contentInset = inset;
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += adjustOffsetY;
    self.tableView.contentOffset = offset;
}

@end
