//
//  MLSwipeDrawerController.h
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MMDrawerController.h"

#define MLSWIPEDRAWERCONTROLLER_NEED_HIDE_STATUSBAR_NOTIFICATION @"com.molon.MLSWIPEDRAWERCONTROLLER_NEED_HIDE_STATUSBAR_NOTIFICATION"
#define MLSWIPEDRAWERCONTROLLER_NEED_SHOW_STATUSBAR_NOTIFICATION @"com.molon.MLSWIPEDRAWERCONTROLLER_NEED_SHOW_STATUSBAR_NOTIFICATION"

@class MLSwipeGestureRecognizer;
@interface MLSwipeDrawerController : MMDrawerController

@property (nonatomic, strong, readonly) MLSwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong, readonly) MLSwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
