//
//  RateViewController.m
//  Toilet
//
//  Created by Olle Lind on 26/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "RateViewController.h"
#import "Rating.h"
#import "LocationClient.h"
#import "RatingDAO.h"
#import "UIViewController+LSPopupViewController.h"

@interface RateViewController ()

@end

@implementation RateViewController{
    int stars;
    Rating *rating;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithRating:(Rating *)_rating{
    self = [self init];
    rating = _rating;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(rating){
        self.titleTextfield.text = rating.title;
    }
    self.commentTextView.layer.borderColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor;
    self.commentTextView.layer.borderWidth = 0.5;
    [self.contentScrollview addSubview:self.contentView];
    self.contentScrollview.contentSize = CGSizeMake(self.contentScrollview.frame.size.width, self.contentView.frame.size.height + 30);
    [self.contentView setOriginX:self.contentScrollview.center.x - self.contentView.frame.size.width/2];
    [self.contentView setOriginY:15];
    self.contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    
    self.commentTextView.layer.borderColor = MediumGrey.CGColor;
    self.commentTextView.layer.borderWidth = 1.0;
    self.commentTextView.layer.cornerRadius = 4.0;
    
    for(UIButton *button in self.optionButtons){
        [button setBackgroundImage:[UIImage imageNamed:@"paper_unselected"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"paper"] forState:UIControlStateSelected];
    }
    
    /*UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(endEditing:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];*/
}


-(IBAction)starButtonPressed:(UIButton *)sender{
    // Deselect all
    int number = (int)sender.tag;
    for(UIButton *button in self.starButtons){
        if(button.tag <= number){
            [button setImage:[UIImage imageNamed:@"paper"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.2 delay:0.05*button.tag usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    button.transform = CGAffineTransformMakeScale(1.0, 1.0);
                } completion:nil];
                
            }];
            
            /*[UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                button.transform = CGAffineTransformMakeScale(1.1, 1.1);
            } completion:^(BOOL finished) {
                button.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];*/
        }else{
            [button setImage:[UIImage imageNamed:@"paper_unselected"] forState:UIControlStateNormal];
        }
    }
    stars = number;
}

-(IBAction)rateButtonPressed:(id)sender{
    if(!rating){
        NSString *title = self.titleTextfield.text;
        NSString *comment = self.commentTextView.text;
        CLLocation *currentLocation = [[LocationClient client] getLocation];
        [RatingDAO newRatingWithTitle:title
                              comment:comment
                               rating:stars
                             location:currentLocation];
    }else{
    
    }
    
    [self dismissPopupViewController];
}

/*
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setOriginY:0];
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setOriginY:120];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
 
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}
*/
-(IBAction)closeButtonPressed:(id)sender{
    [self.parentVC dismissPopupViewController];
}

-(IBAction)optionButtonPressed:(UIButton *)sender{
    [sender setSelected:!sender.selected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
