//
//  WSEventView.m
//  CalendarDemo
//
//  Created by Dotsquares on 2/16/17.
//  Copyright © 2017 Dotsquares. All rights reserved.
//

#import "WSEventView.h"

@implementation WSEventView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)setEventViewColor:(UIColor *)color{
    self.clipsToBounds=YES;
    self.backgroundColor = color;
    self.layer.cornerRadius=self.frame.size.width/2;
}


@end
