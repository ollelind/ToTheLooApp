//
//  LocationManager.m
//  Toilet
//
//  Created by Olle Lind on 26/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "LocationClient.h"

@implementation LocationClient{
    CLLocationManager *locationManager;
}

static LocationClient *_client = nil;
static dispatch_once_t onceToken;

+(LocationClient *)client
{
    //thread-safe way to create a singleton
    dispatch_once(&onceToken, ^{
        _client = [[LocationClient allocWithZone:nil] init];
    });
    
    return _client;
}

-(id)init{
    self = [super init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    return self;
}

-(CLLocation *)getLocation{
    return locationManager.location;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        [[NSNotificationCenter defaultCenter]postNotificationName:LOCATION_UPDATED object:currentLocation];
    }
}



@end
