//
//  RatingDAO.m
//  Toilet
//
//  Created by Olle Lind on 29/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "RatingDAO.h"
#import <Parse/Parse.h>
#import "Rating.h"
#import <CoreLocation/CoreLocation.h>

#define RATING_EXTERNAL_NAME @"Rating"

@implementation RatingDAO

+(void)newRatingWithTitle:(NSString *)title comment:(NSString *)comment rating:(int)rating location:(CLLocation *)location{
    PFObject *parseObj = [PFObject objectWithClassName:RATING_EXTERNAL_NAME];
    parseObj[@"title"] = title;
    parseObj[@"ratings"] = @[@(rating)];
    parseObj[@"comments"] = @[comment];
    parseObj[@"location"] = [PFGeoPoint geoPointWithLocation:location];
    [parseObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            Rating *rating = [[Rating alloc] init];
            rating.title = title;
            rating.ratings = parseObj[@"ratings"];
            rating.comments = parseObj[@"comments"];
            rating.location = location;
            rating.objectId = parseObj.objectId;
            [[NSNotificationCenter defaultCenter] postNotificationName:NEW_RATING object:rating];
        }
    }];
}

+(void)getRatingsWithinDistanceInKM:(int)distance fromLocation:(CLLocation *)location response:(void(^)(NSArray *objects, NSError *error))response{
    PFGeoPoint *currentGeoPoint = [PFGeoPoint geoPointWithLocation:location];
    PFQuery *query = [PFQuery queryWithClassName:RATING_EXTERNAL_NAME];
    [query whereKey:@"location" nearGeoPoint:currentGeoPoint withinKilometers:distance];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSMutableArray *ratingArray = [NSMutableArray array];
            for(PFObject *obj in objects){
                [ratingArray addObject:[self ratingFromParseObject:obj]];
            }
            response([NSArray arrayWithArray:ratingArray], error);
            return;
        }
        response(objects, error);
    }];
}

+(Rating *)ratingFromParseObject:(PFObject *)obj{
    Rating *rating = [[Rating alloc]init];
    rating.title = [obj objectForKey:@"title"];
    rating.ratings = [obj objectForKey:@"ratings"];
    rating.comments = [obj objectForKey:@"comments"];
    rating.objectId = obj.objectId;
    PFGeoPoint *geoPoint = [obj objectForKey:@"location"];
    rating.location = [[CLLocation alloc] initWithLatitude:geoPoint.latitude longitude:geoPoint.longitude];
    return rating;
}

@end






