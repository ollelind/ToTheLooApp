//
//  ViewController.m
//  Toilet
//
//  Created by Olle Lind on 26/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "RateViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Rating.h"
#import "LocationClient.h"
#import "DetailViewController.h"
#import "RatingDAO.h"
#import "UIViewController+LSPopupViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    GMSMapView *mapView;
    CLLocation *lastLocation;
    NSMutableArray *ratings;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRating:) name:NEW_RATING object:nil];
    
    CLLocation *location = [[LocationClient client] getLocation];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                               longitude:location.coordinate.longitude
                                                                    zoom:15];
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) camera:camera];
    mapView.myLocationEnabled = YES;
    
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    
    UIButton *rateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rateButton.backgroundColor = [UIColor whiteColor];
    [rateButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //[rateButton setTitle:@"Rate" forState:UIControlStateNormal];
    [rateButton setShowsTouchWhenHighlighted:YES];
    rateButton.frame = CGRectMake(160-21, self.view.frame.size.height-150, 42, 72);
    [rateButton setBackgroundImage:[UIImage imageNamed:@"toilet"] forState:UIControlStateNormal];
    [rateButton addTarget:self action:@selector(rateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    rateButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rateButton];
    
    ratings = [NSMutableArray array];
    
    [RatingDAO getRatingsWithinDistanceInKM:5.0 fromLocation:location response:^(NSArray *objects, NSError *error) {
        if(!error){
            for(Rating *r in objects){
                [self addRating:r];
            }
        }
    }];
}

-(void)locationUpdated:(NSNotification *)notification{
    CLLocation *location = (CLLocation *)notification.object;
    if((location.coordinate.latitude != lastLocation.coordinate.latitude ||
       location.coordinate.longitude != lastLocation.coordinate.longitude) &&
       lastLocation == nil)
    {
        
    }
}

-(void)rateButtonPressed{
    RateViewController *rateVC = [[RateViewController alloc]init];
    rateVC.parentVC = self;
    [self presentPopupViewController:rateVC];
    //[self presentViewController:rateVC animated:YES completion:nil];
}

-(void)newRating:(NSNotification *)notification{
    Rating *rating = notification.object;
    [self addRating:rating];
}
-(void)addRating:(Rating *)rating{
    for(Rating *r in ratings){
        if(r.objectId == rating.objectId){
            return;
        }
    }
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(rating.location.coordinate.latitude, rating.location.coordinate.longitude);
    marker.icon = [UIImage imageNamed:@"flag_icon"];
    marker.map = mapView;
    marker.tappable = YES;
    
    rating.marker = marker;
    [ratings addObject:rating];
}

#pragma mark - Google map delegate
-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    for(Rating *rating in ratings){
        if(rating.marker == marker){
            DetailViewController *detailVC = [[DetailViewController alloc]initWithRating:rating];
            [self.navigationController presentViewController:detailVC animated:YES completion:nil];
            return YES;
        }
    }
    return NO;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
