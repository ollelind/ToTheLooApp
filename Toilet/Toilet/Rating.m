//
//  Rating.m
//  Toilet
//
//  Created by Olle Lind on 29/07/14.
//  Copyright (c) 2014 Olle Lind. All rights reserved.
//

#import "Rating.h"

@implementation Rating

-(id)init{
    self = [super init];
    
    return self;
}

-(void)setRatings:(NSArray *)ratings{
    double total = 0;
    for(NSNumber *num in ratings){
        total += num.doubleValue;
    }
    self.rating = total / ratings.count;
}

@end
