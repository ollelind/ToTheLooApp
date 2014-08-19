//
//  RateViewController.h
//  Toilet
//
//  Created by Olle Lind on 26/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rating.h"
#import "ViewController.h"

@interface RateViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *starButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *optionButtons;
@property (nonatomic, strong) IBOutlet UITextField *titleTextfield;
@property (nonatomic, strong) IBOutlet UITextView *commentTextView;
@property (nonatomic, strong) IBOutlet UIScrollView *contentScrollview;
@property (nonatomic, strong) IBOutlet UIView *contentView;

@property (nonatomic, strong) IBOutlet ViewController *parentVC;

-(id)initWithRating:(Rating *)_rating;

-(IBAction)starButtonPressed:(UIButton *)sender;
-(IBAction)rateButtonPressed:(id)sender;
-(IBAction)closeButtonPressed:(id)sender;
-(IBAction)optionButtonPressed:(UIButton *)sender;

@end
