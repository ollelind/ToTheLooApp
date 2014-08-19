//
//  UIView+Frame.m
//  Lifesum
//
//  Created by Olle Lind on 27/02/14.
//  Copyright (c) 2014 Shape Up Club. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setOriginX:(double)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
-(void)setOriginY:(double)y{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}
-(void)setWidth:(double)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}
-(void)setHeight:(double)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(void)increaseHeight:(double)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height + height);
}
-(void)increaseWidth:(double)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + width, self.frame.size.height);
}
-(void)decreaseHeight:(double)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - height);
}
-(void)decreaseWidth:(double)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width - width, self.frame.size.height);
}


-(void)positionBelowView:(UIView *)view{
    [self positionBelowView:view withMargin:0];
}
-(void)positionBelowView:(UIView *)view withMargin:(double)margin{
    [self setOriginY:view.frame.origin.y + view.frame.size.height + margin];
}
@end
