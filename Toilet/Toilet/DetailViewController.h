//
//  DetailViewController.h
//  Toilet
//
//  Created by Olle Lind on 30/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rating.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

-(id)initWithRating:(Rating *)_rating;

@end
