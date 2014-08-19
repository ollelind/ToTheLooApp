//
//  RatingDAO.h
//  Toilet
//
//  Created by Olle Lind on 29/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RatingDAO : NSObject

+(void)newRatingWithTitle:(NSString *)title comment:(NSString *)comment rating:(int)rating location:(CLLocation *)location;
+(void)getRatingsWithinDistanceInKM:(int)distance fromLocation:(CLLocation *)location response:(void(^)(NSArray *objects, NSError *error))response;
@end
