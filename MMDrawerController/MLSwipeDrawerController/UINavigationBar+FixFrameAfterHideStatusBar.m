//
//  UINavigationBar+FixFrameAfterHideStatusBar.m
//  MMDrawerControllerKitchenSink
//
//  Created by molon on 14/10/18.
//  Copyright (c) 2014年 Mutual Mobile. All rights reserved.
//

#import "UINavigationBar+FixFrameAfterHideStatusBar.h"
#import <objc/runtime.h>


//静态就交换静态，实例方法就交换实例方法
void Swizzle(Class c, SEL origSEL, SEL newSEL)
{
    //获取实例方法
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method newMethod = nil;
	if (!origMethod) {
        //获取静态方法
		origMethod = class_getClassMethod(c, origSEL);
        newMethod = class_getClassMethod(c, newSEL);
    }else{
        newMethod = class_getInstanceMethod(c, newSEL);
    }
    
    if (!origMethod||!newMethod) {
        return;
    }
    
    //自身已经有了就添加不成功，直接交换即可
    if(class_addMethod(c, origSEL, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))){
        //添加成功一般情况是因为，origSEL本身是在c的父类里。这里添加成功了一个继承方法。
        class_replaceMethod(c, newSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else{
        method_exchangeImplementations(origMethod, newMethod);
	}
}


@implementation UINavigationBar (FixFrameAfterHideStatusBar)

- (void)hook_layoutSubviews
{
    [self hook_layoutSubviews];
    
    CGRect frame = self.frame;
    if (frame.origin.y==0&&[UIApplication sharedApplication].statusBarHidden) {
        
        frame.origin.y = 20.0f;
        self.frame = frame;

        [self.layer removeAllAnimations]; //这句其实也就只有ios8需要
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
//                for (UIView *subView in [view subviews]) {
//                    [subView.layer removeAllAnimations];
//                    if ([subView isKindOfClass:NSClassFromString(@"_UIBackdropView")]) {
//                        for (UIView *subView2 in [subView subviews]) {
//                            [subView2.layer removeAllAnimations];
//                        }
//                    }
//                }
//                [view.layer removeAllAnimations];
                
                CGRect bframe = view.frame;
                if (bframe.origin.y == 0) {
                    bframe.origin.y -= 20.0f;
                    bframe.size.height += 20.0f;
                    view.frame = bframe;
                }
                
                break;
            }
        }
    }
}

+ (void)load
{
    Swizzle(self, @selector(layoutSubviews), @selector(hook_layoutSubviews));
}
@end
