//
//  DetailViewController.m
//  Toilet
//
//  Created by Olle Lind on 30/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "DetailViewController.h"
#import "RateViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController{
    Rating *rating;
}

-(id)initWithRating:(Rating *)_rating{
    self = [self init];
    rating = _rating;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Add title
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 280, 20)];
    label.textColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = rating.title;
    label.font = [UIFont fontWithName:@"System" size:22];
    [self.scrollView addSubview:label];
    
    // Add stars
    int stars = (int)rating.rating;
    int y = CGRectGetMaxY(label.frame) + 10;
    int imageWidth = 30;
    for(int i=0; i<stars; i++){
        UIImageView *starImage = [[UIImageView alloc]initWithFrame:CGRectMake(160 - ((stars-i+1) * imageWidth/2) + (i*imageWidth), y, imageWidth, imageWidth)];
        starImage.backgroundColor = [UIColor orangeColor];
        [self.scrollView addSubview:starImage];
    }
    
    // Add new rating button
    UIButton *newRatingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newRatingButton.frame = CGRectMake(30, 115, 270, 40);
    newRatingButton.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    [newRatingButton setTitle:@"Rate" forState:UIControlStateNormal];
    [newRatingButton addTarget:self action:@selector(newRatingButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:newRatingButton];
    
    // Add comments
    y = 200;
    UIFont *commentFont = [UIFont systemFontOfSize:16];
    for(NSString *comment in rating.comments){
        CGSize maximumLabelSize = CGSizeMake(280, 500);
        CGSize expectedLabelSize = [comment boundingRectWithSize:maximumLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :commentFont} context:nil].size;

        UILabel *commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, y, 280, expectedLabelSize.height)];
        commentLabel.text = comment;
        [self.scrollView addSubview:commentLabel];
        y = CGRectGetMaxY(commentLabel.frame) + 10;
    }
    
}

-(void)newRatingButtonPressed{
    RateViewController *rateVC = [[RateViewController alloc]initWithRating:rating];
    [self presentViewController:rateVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
