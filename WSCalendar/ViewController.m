//
//  ViewController.m
//  WSCalendar
//
//  Created by Dotsquares on 4/20/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    WSCalendarView *calendarView;
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    calendarView = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    //calendarView.dayColor=[UIColor blackColor];
    //calendarView.weekDayNameColor=[UIColor purpleColor];
    //calendarView.barDateColor=[UIColor purpleColor];
    //calendarView.todayBackgroundColor=[UIColor blackColor];
    calendarView.tappedDayBackgroundColor=[UIColor blackColor];
    calendarView.calendarStyle = WSCalendarStyleDialog;
    calendarView.isShowEvent=false;
    [calendarView setupAppearance];
    [self.view addSubview:calendarView];
    calendarView.delegate=self;
    
    
    calendarViewEvent = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarViewEvent.calendarStyle = WSCalendarStyleView;
    calendarViewEvent.isShowEvent=true;
    calendarViewEvent.tappedDayBackgroundColor=[UIColor blackColor];
    calendarViewEvent.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [calendarViewEvent setupAppearance];
    calendarViewEvent.delegate=self;
    [self.containerView addSubview:calendarViewEvent];
    
    
    eventArray=[[NSMutableArray alloc] init];
    NSDate *lastDate;
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    for (int i=0; i<10; i++) {
        
        if (!lastDate) {
            lastDate=[NSDate date];
        }
        else{
            [dateComponent setDay:1];
        }
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:lastDate options:0];
        lastDate=datein;
        [eventArray addObject:datein];
    }
    [calendarViewEvent reloadCalendar];
    
    NSLog(@"%@",[eventArray description]);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [calendarView ActiveCalendar:textField];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark WSCalendarViewDelegate

-(NSArray *)setupEventForDate{
    return eventArray;
}

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
    
}

-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
    self.txtCalender.text = str;
}


- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
