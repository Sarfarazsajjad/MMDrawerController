//
//  MLSwipeScrollView.m
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "MLSwipeScrollView.h"
#import "MLSwipeGestureRecognizer.h"

@implementation MLSwipeScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")]&&[gestureRecognizer.view isEqual:self]&&[otherGestureRecognizer isKindOfClass:[MLSwipeGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

@end
