//
//  LocationManager.h
//  Toilet
//
//  Created by Olle Lind on 26/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationClient : NSObject <CLLocationManagerDelegate>

+(LocationClient*) client;

-(CLLocation *)getLocation;

@end
