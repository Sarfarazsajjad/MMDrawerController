//
//  MMDrawerController+MLSwipeSubclass.h
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//


#import "MMDrawerController.h"

typedef void (^MMDrawerGestureCompletionBlock)(MMDrawerController * drawerController, UIGestureRecognizer * gesture);

@interface MMDrawerController (MLSwipeSubclass)

@property (nonatomic, copy) MMDrawerGestureCompletionBlock gestureCompletion;
@property (nonatomic, assign, getter = isAnimatingDrawer) BOOL animatingDrawer;

- (UIViewController*)sideDrawerViewControllerForSide:(MMDrawerSide)drawerSide;

-(void)setAnimatingDrawer:(BOOL)animatingDrawer;

-(void)setShowsStatusBarBackgroundView:(BOOL)showsDummyStatusBar;

@end