//
//  MLSwipeDrawerController.h
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MMDrawerController.h"
#import "UINavigationBar+FixFrameAfterHideStatusBar.h"
#import "UIViewController+MMDrawerController.h"

@class MLSwipeGestureRecognizer;
@interface MLSwipeDrawerController : MMDrawerController

@property (nonatomic, strong, readonly) MLSwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong, readonly) MLSwipeGestureRecognizer *rightSwipeGestureRecognizer;

@property (nonatomic, assign, readonly) BOOL statusBarShouldBeHidden;

@end
