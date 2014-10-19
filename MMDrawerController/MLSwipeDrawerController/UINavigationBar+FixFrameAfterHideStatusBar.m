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


- (CGSize)hook_sizeThatFits:(CGSize)size
{
    CGSize rsize = [self hook_sizeThatFits:size];
    if ([UIApplication sharedApplication].statusBarHidden) {
        rsize.height+=20.0f;
    }
    
//    NSLog(@"%@",NSStringFromCGSize(rsize));
    
    //遍历下动画看看
    NSLog(@"1.%@",self.layer.animationKeys);
    [self.layer removeAnimationForKey:@"position"];
    [self.layer removeAnimationForKey:@"bounds"];
    return rsize;
}

- (void)hook_layoutSubviews
{
    [self hook_layoutSubviews];
    CGRect frame = self.frame;
    if (frame.origin.y==0) {
        frame.origin.y=20.0f;
        self.frame = frame;
//        return;
        
        [self.layer removeAllAnimations];
        for (UIView *view in [self subviews]) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                for (UIView *subView in [view subviews]) {
                    [subView.layer removeAllAnimations];
                    if ([subView isKindOfClass:NSClassFromString(@"_UIBackdropView")]) {
                        for (UIView *subView2 in [subView subviews]) {
                            [subView2.layer removeAllAnimations];
                        }
                    }
                }
                
                [view.layer removeAllAnimations];
                
                CGRect bframe = view.frame;
                bframe.origin.y -= 20.0f;
                bframe.size.height += 20.0f;
                view.frame = bframe;
                
                break;
            }
        }
    }
    
    NSLog(@"当前:%@ frame为%@",self,NSStringFromCGRect(self.frame));
    
//    return;
}

- (void)hook_setFrame:(CGRect)frame
{
    [self hook_setFrame:frame];
    NSLog(@"frame修改为%@",NSStringFromCGRect(frame));
}

+ (void)load
{
//    Swizzle(self, @selector(sizeThatFits:), @selector(hook_sizeThatFits:));
//    
    Swizzle(self, @selector(layoutSubviews), @selector(hook_layoutSubviews));
    
//    Swizzle(self, @selector(setFrame:), @selector(hook_setFrame:));
}
@end
