//
//  UIViewController+LSPopupViewController.h
//  iShape
//
//  Created by Olle Lind on 28/11/13.
//  Copyright (c) 2013 Shape Up Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LSPopupViewController) <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *popup;
@property (nonatomic, strong) UIView *background;

- (void)presentPopupViewController:(UIViewController*)popupViewController;
- (void)dismissPopupViewController;
- (void)turnOffScroll;
- (void)turnOffTouches;
- (void)turnOnTouches;
@end
