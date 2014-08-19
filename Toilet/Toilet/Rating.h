//
//  Rating.h
//  Toilet
//
//  Created by Olle Lind on 29/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface Rating : NSObject

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *ratings;
@property (nonatomic, assign) double rating;
@property (nonatomic, weak) GMSMarker *marker;
@property (nonatomic, strong) NSString *objectId;

@end
