//
//  UIViewController+LSPopupViewController.m
//  iShape
//
//  Created by Olle Lind on 28/11/13.
//  Copyright (c) 2013 Shape Up Club. All rights reserved.
//

#import "UIViewController+LSPopupViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIViewController (LSPopupViewController)
@dynamic popup;
@dynamic background;

- (UIViewController*)popup{
    return objc_getAssociatedObject(self, @"popup");
}

- (void)setPopup:(UIViewController *)popup {
    objc_setAssociatedObject(self, @"popup", popup, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)background{
    return objc_getAssociatedObject(self, @"background");
}

- (void)setBackground:(UIView *)background {
    objc_setAssociatedObject(self, @"background", background, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
BOOL dismissTouches;
- (void)turnOffTouches{
    dismissTouches = YES;
}
- (void)turnOnTouches{
    dismissTouches = NO;
}
- (void)presentPopupViewController:(UIViewController*)popupViewController{
    self.popup = popupViewController;
    self.popup.view.layer.zPosition = 10;
    self.popup.view.userInteractionEnabled = YES;
    
    UIView *topview = [self topView];
    if ([topview.subviews containsObject:self.popup.view]) return;
    
    self.background = [[UIView alloc]initWithFrame:topview.bounds];
    self.background.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.7];
    // Set the GestureRecognizer that will dismiss the view on touch
    UITapGestureRecognizer *panGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    panGesture.cancelsTouchesInView = NO;
    panGesture.delegate = self;
    [self.background addGestureRecognizer:panGesture];
    
    self.popup.view.frame =CGRectMake((topview.frame.size.width - self.popup.view.frame.size.width) / 2,
               topview.center.y - (self.popup.view.frame.size.height/2),
               self.popup.view.frame.size.width,
               self.popup.view.frame.size.height);
    
    self.background.layer.opacity = 0;
    self.popup.view.layer.opacity = 0;
    self.popup.view.transform = CGAffineTransformMakeScale(2.0, 2.0);
    [UIView animateWithDuration:0.2 animations:^{
        self.background.layer.opacity = 1;
        self.popup.view.layer.opacity = 1;
        self.popup.view.transform = CGAffineTransformMakeScale(0.98, 0.98);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.popup.view.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
    /*
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.background.layer.opacity = 1;
        self.popup.view.layer.opacity = 1;
        self.popup.view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];*/
    
    [self.background addSubview:self.popup.view];
    [topview addSubview:self.background];
    dismissTouches = NO;
}
- (void)dismissPopupViewController
{
    self.popup.view.userInteractionEnabled = NO;
    self.background.userInteractionEnabled = NO;
    
    if (self.background.gestureRecognizers.count > 0) {
        UITapGestureRecognizer *gr = self.background.gestureRecognizers[0];
        [self.background removeGestureRecognizer:gr];
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.background.layer.opacity = 0;
        self.popup.view.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [self.popup.view removeFromSuperview];
        [self.background removeFromSuperview];
    }];
    
}
- (void)turnOffScroll{}

#pragma mark - Gesture recognizers

-(void) panGesture:(UITapGestureRecognizer*)gr{
    CGPoint location = [gr locationInView:self.background];
    if(CGRectContainsPoint(self.popup.view.frame, location) || dismissTouches){
        return;
    }
    if (self.background.gestureRecognizers.count > 0) {
        UITapGestureRecognizer *gr = self.background.gestureRecognizers[0];
        [self.background removeGestureRecognizer:gr];
    }
    [self dismissPopupViewController];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint location = [touch locationInView:self.background];
    if(CGRectContainsPoint(self.popup.view.frame, location) || dismissTouches){
        return NO;
    }
    return YES;
}

#pragma mark - Helpers
-(UIView*)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

@end
