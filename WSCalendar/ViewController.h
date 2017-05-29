//
//  ViewController.h
//  WSCalendar
//
//  Created by Dotsquares on 4/20/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCalendarView.h"

@interface ViewController : UIViewController<WSCalendarViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtCalender;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

