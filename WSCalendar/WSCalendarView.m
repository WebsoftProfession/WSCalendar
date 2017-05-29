//
//  CalendarView.m
//  CalendarDemo
//
//  Created by Dotsquares on 3/9/16.
//  Copyright © 2016 Dotsquares. All rights reserved.
//

#import "WSCalendarView.h"

@implementation WSCalendarView
{
    NSMutableArray *dayInMonth;
    NSMutableArray *completeDateArray;
    NSArray *lblArray;
    BOOL isLoop;
    BOOL is;
    NSDate *selectedDate;
}

@synthesize dayColor=_dayColor;
@synthesize weekDayNameColor=_weekDayNameColor;
@synthesize barDateColor=_barDateColor;
@synthesize todayBackgroundColor=_todayBackgroundColor;
@synthesize tappedDayBackgroundColor=_tappedDayBackgroundColor;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)setupAppearance{
    
    if (self.calendarStyle == WSCalendarStyleDialog) {
        self.hidden=YES;
        self.clipsToBounds=YES;
        self.layer.cornerRadius=5.0;
        self.layer.borderColor=[UIColor grayColor].CGColor;
        self.layer.borderWidth=1.0;
        
    }
    else{
        self.btnCancel.hidden=YES;
        self.btnOK.hidden=YES;
    }
    
     [self initializeMonthYear];
}

-(void)initializeMonthYear
{
    lblArray=[[NSArray alloc] initWithObjects:lblDate1,lblDate2,lblDate3,lblDate4,lblDate5,lblDate6,lblDate7,lblDate8,lblDate9,lblDate10,lblDate11,lblDate12,lblDate13,lblDate14,lblDate15,lblDate16,lblDate17,lblDate18,lblDate19,lblDate20,lblDate21,lblDate22,lblDate23,lblDate24,lblDate25,lblDate26,lblDate27,lblDate28,lblDate29,lblDate30,lblDate31, nil];
    isLoop=YES;
    is=YES;
    dayInMonth=[[NSMutableArray alloc] init];
    completeDateArray=[[NSMutableArray alloc] init];
    
    NSDate *currentDate=[NSDate date];
    [self setLabelCircle:currentDate];
    for (int i=0; i<31 ; i++) {
        
        UILabel *lbl=[lblArray objectAtIndex:i];
        
        lbl.tag=i;
        
        UITapGestureRecognizer *tapG=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblTapped:)];
        [lbl addGestureRecognizer:tapG];
    }
    selectedDate=[NSDate date];
    [self setWeekDateLabel:selectedDate];
    [self setYear:selectedDate];
    [self numberOfYearsInCalendar];
    
    [self setMonthLabels:currentDate];
}

-(void)reloadCalendar{
    [self setMonthLabels:selectedDate];
}

-(void)removeLabelCircle:(NSDate *)currentDate
{
    BOOL isTodayMonth = false;
    if ([self dateStringMatching:currentDate]) {
        isTodayMonth=true;
    }
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd"];
    NSString *str=[monthFormatter stringFromDate:currentDate];
    
    for (int i=0; i<31 ; i++) {
        
        WSLabel *lbl=[lblArray objectAtIndex:i];
        lbl.layer.cornerRadius=lbl.frame.size.width/2;
        lbl.layer.borderWidth=2.0;
        
        if (isTodayMonth) {
            if ([lbl.text isEqualToString:str]) {
                lbl.layer.borderColor=[UIColor clearColor].CGColor;
                if (self.todayBackgroundColor) {
                    lbl.backgroundColor=self.todayBackgroundColor;
                }
                else{
                    lbl.backgroundColor=[UIColor lightGrayColor];
                }
                
            }
            else{
                lbl.layer.borderColor=[UIColor clearColor].CGColor;
                lbl.backgroundColor=[UIColor clearColor];
            }
        }
        else{
            
            lbl.layer.borderColor=[UIColor clearColor].CGColor;
            lbl.backgroundColor=[UIColor clearColor];
        }
        
        if (self.isShowEvent) {
            [self generateEventOnView:lbl];
        }
        
        
    }
}

-(void)generateEventOnView:(WSLabel *)dayView{
    [[dayView subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if([self.delegate respondsToSelector:@selector(setupEventForDate)]){
        NSArray *eventArray = [self.delegate setupEventForDate];
        if (eventArray.count>0) {
            for (int k = 0; k<eventArray.count; k++) {
                if ([self compareDate:dayView.linkedDate withDate:[eventArray objectAtIndex:k]]) {
                    WSEventView *eventView = [[WSEventView alloc] initWithFrame:CGRectMake(dayView.frame.size.width/2-2, dayView.frame.size.height-6, 4, 4)];
                    [eventView setEventViewColor:[UIColor redColor]];
                    [dayView addSubview:eventView];
                }
            }
        }
    }
    
}

-(void)setLabelCircle:(NSDate *)currentDate
{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd"];
    NSString *str=[monthFormatter stringFromDate:currentDate];
    
    for (int i=0; i<31 ; i++) {
        
        UILabel *lbl=[lblArray objectAtIndex:i];
        
        if ([self dateStringMatching:currentDate]) {
            if ([lbl.text isEqualToString:str]) {
                lbl.layer.cornerRadius=lbl.frame.size.width/2;
                if (self.todayBackgroundColor) {
                    lbl.backgroundColor=self.todayBackgroundColor;
                }
                else{
                    lbl.backgroundColor=[UIColor lightGrayColor];
                }
            }
        }
    }
}


-(BOOL)compareDate:(NSDate *)fromDate withDate:(NSDate *)toDate{
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *currentDateStr=[monthFormatter stringFromDate:fromDate];
    
    
    NSString *labelDateStr=[monthFormatter stringFromDate:toDate];
    
    if ([currentDateStr isEqualToString:labelDateStr]) {
        
        return YES;
        
    }
    else
    {
        return NO;
    }
}

-(BOOL)dateStringMatching:(NSDate *)selectedLabelDate
{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *currentDateStr=[monthFormatter stringFromDate:[NSDate date]];
    
    NSString *labelDateStr=[monthFormatter stringFromDate:selectedLabelDate];
    
    if ([currentDateStr isEqualToString:labelDateStr]) {
        
        return YES;
        
    }
    else
    {
        return NO;
    }
}


-(void)lblTapped:(UITapGestureRecognizer *)tap
{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd"];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
    
    for (int i=0; i<31 ; i++) {
        
        UILabel *lbl=[lblArray objectAtIndex:i];
        lbl.layer.cornerRadius=0.0;
        lbl.layer.borderColor=[UIColor clearColor].CGColor;
        lbl.backgroundColor=[UIColor clearColor];
        lbl.layer.borderWidth=0.0;
        if ([self dateStringMatching:selectedDate]) {
            
            if ([lbl.text isEqualToString:str]) {
                lbl.layer.cornerRadius=lbl.frame.size.width/2;
                if (self.todayBackgroundColor) {
                    lbl.backgroundColor=self.todayBackgroundColor;
                }
                else{
                    lbl.backgroundColor=[UIColor lightGrayColor];
                }
            }
        }
        
    }
    
    WSLabel *lbl=(WSLabel *)tap.view;
    lbl.layer.cornerRadius=lbl.frame.size.width/2;
    if (self.tappedDayBackgroundColor) {
        lbl.backgroundColor=self.tappedDayBackgroundColor;
    }
    else{
        lbl.backgroundColor=[UIColor whiteColor];
    }
    
    int interDate=lbl.text.intValue;
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd"];
    int currentDayValue=[[dateFormatter1 stringFromDate:selectedDate] intValue];
    
    if (interDate>currentDayValue) {
        
        NSDate *newSelectedDate=selectedDate;
        
        for (int i=currentDayValue; i<interDate; i++) {
            
            NSDateComponents *dc = [[NSDateComponents alloc] init];
            [dc setDay:1];
            NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:newSelectedDate options:0];
            newSelectedDate=datein;
            NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
            [monthFormatter setDateFormat:@"dd MMMM YYYY"];
            [btnBarDate setTitle:[monthFormatter stringFromDate:datein]];
            [self setWeekDateLabel:datein];
            
            NSLog(@"%d",currentDayValue);
            
        }
    }
    else if(interDate<currentDayValue)
    {
        NSDate *newSelectedDate=selectedDate;
        for (int i=currentDayValue; i>interDate; i--) {
            
            NSDateComponents *dc = [[NSDateComponents alloc] init];
            [dc setDay:-1];
            NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:newSelectedDate options:0];
            newSelectedDate=datein;
            NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
            [monthFormatter setDateFormat:@"dd MMMM YYYY"];
            [btnBarDate setTitle:[monthFormatter stringFromDate:datein]];
            [self setWeekDateLabel:datein];
            
            NSLog(@"%d",currentDayValue);
            
        }
    }
    else{
        NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
        [monthFormatter setDateFormat:@"dd MMMM YYYY"];
        [btnBarDate setTitle:[monthFormatter stringFromDate:[NSDate date]]];
        [self setWeekDateLabel:selectedDate];
    }
    activeLabel = lbl;
    [self.delegate didTapLabel:lbl withDate:lbl.linkedDate];
}

-(void)numberOfYearsInCalendar
{
    NSDate *calendarDate=[NSDate date];
    [completeDateArray addObject:calendarDate];
    for (int i=0; i<365; i++) {
        NSDateComponents *dc = [[NSDateComponents alloc] init];
        [dc setMonth:0];
        [dc setDay:1];
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:calendarDate options:0];
        calendarDate=datein;
        [completeDateArray addObject:datein];
        
    }
}

-(void)setMonthLabels:(NSDate *)date
{
    [dayInMonth removeAllObjects];
    NSDate *currentDate=date;
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"dd"];
    int currentDayValue=[[dateFormatter1 stringFromDate:currentDate] intValue];
    for (int i=currentDayValue; i>1; i--) {
        
        NSDateComponents *dc = [[NSDateComponents alloc] init];
        [dc setDay:-1];
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:currentDate options:0];
        currentDate=datein;
        NSLog(@"%d",currentDayValue);
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    int currentDayValue1=[[dateFormatter stringFromDate:currentDate] intValue];
    NSLog(@"%d",currentDayValue);
    
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setMonth:1];
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:currentDate options:0];
    NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc] init];
    [endDateFormatter setDateFormat:@"dd MMMM"];
    NSString *endDateString=[endDateFormatter stringFromDate:endDate];
    
    [dayInMonth addObject:currentDate];
    for (int i=0; i<30; i++) {
        
        NSDateComponents *dc = [[NSDateComponents alloc] init];
        [dc setDay:1];
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:currentDate options:0];
        currentDate=datein;
        [dayInMonth addObject:datein];
        
    }
    
    for (int i=0; i<31; i++) {
        UILabel *lbl=[lblArray objectAtIndex:i];
        lbl.hidden=YES;
    }
    
    for (int i=0; i<dayInMonth.count; i++) {
        
        WSLabel *lbl=[lblArray objectAtIndex:i];
        lbl.linkedDate = [dayInMonth objectAtIndex:i];
        lbl.hidden=NO;
        NSString *currentDateValue=[dateFormatter stringFromDate:[dayInMonth objectAtIndex:i]];
        
        NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc] init];
        [endDateFormatter setDateFormat:@"dd MMMM"];
        NSString *currentDateString=[endDateFormatter stringFromDate:[dayInMonth objectAtIndex:i]];
        
        if ([currentDateString isEqualToString:endDateString]) {
            
            NSLog(@"done");
            lbl.hidden=YES;
            return;
            
        }
        lbl.text=currentDateValue;
        if (self.isShowEvent) {
            [self generateEventOnView:lbl];
        }
        
    }
}


-(void)setWeekDateLabel:(NSDate *)date
{
    NSDateFormatter *weakFormattar=[[NSDateFormatter alloc] init];
    [weakFormattar setDateFormat:@"EEEE"];
    lblWeekDate.text=[weakFormattar stringFromDate:date];
}

-(void)setYear:(NSDate *)date
{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM YYYY"];
    [btnBarDate setTitle:[monthFormatter stringFromDate:date]];
}


-(void)setMonth:(NSString *)month andYear:(NSString *)year
{
    [barBtnMonth setTitle:month];
    [barBtnYear setTitle:year];
}

- (IBAction)monthNextClicked:(id)sender {
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MMMM"];
    
    NSDate *currentDate=[monthFormatter dateFromString:barBtnMonth.title];
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    
    [dateComponent setMonth:1];
    
    NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:currentDate options:0];
    
    [barBtnMonth setTitle:[monthFormatter stringFromDate:datein]];
    
    [self setMonthLabels:datein];
    [self removeLabelCircle:datein];
    
}

- (IBAction)PrevClicked:(id)sender {
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM YYYY"];
    
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    
    [dateComponent setMonth:-1];
    NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:selectedDate options:0];
    selectedDate=datein;
    
    [btnBarDate setTitle:[monthFormatter stringFromDate:datein]];
    [self setMonthLabels:datein];
    [self removeLabelCircle:datein];
    
}

- (IBAction)NextClicked:(id)sender {
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM YYYY"];
    
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    
    [dateComponent setMonth:1];
    NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:selectedDate options:0];
    selectedDate=datein;
    [btnBarDate setTitle:[monthFormatter stringFromDate:datein]];
    
    [self setMonthLabels:datein];
    [self removeLabelCircle:selectedDate];
}

-(IBAction)yearNextClicked:(id)sender{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM YYYY"];
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    
    [dateComponent setYear:1];
    NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:selectedDate options:0];
    selectedDate=datein;
    [btnBarDate setTitle:[monthFormatter stringFromDate:datein]];
    
    [self setMonthLabels:datein];
    [self removeLabelCircle:selectedDate];
}

- (IBAction)yearPrevClicked:(id)sender {
    
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM YYYY"];
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    
    [dateComponent setYear:-1];
    NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:selectedDate options:0];
    selectedDate=datein;
    [btnBarDate setTitle:[monthFormatter stringFromDate:datein]];
    
    [self setMonthLabels:datein];
    [self removeLabelCircle:selectedDate];
}

//properties

- (UIColor *)dayColor {
    return _dayColor;
}

-(void)setDayColor:(UIColor *)dayColor{
    _dayColor=dayColor;
    for (int i=0; i<lblArray.count; i++) {
        UILabel *lbl=[lblArray objectAtIndex:i];
        lbl.textColor=dayColor;
    }
}

- (UIColor *)weekDayNameColor {
    return _weekDayNameColor;
}

-(void)setWeekDayNameColor:(UIColor *)weekDayNameColor{
    _weekDayNameColor=weekDayNameColor;
    lblWeekDate.textColor=weekDayNameColor;
}

- (UIColor *)barDateColor {
    return _barDateColor;
}

-(void)setBarDateColor:(UIColor *)barDateColor{
    _barDateColor=barDateColor;
    btnBarDate.tintColor=barDateColor;
}

- (UIColor *)todayBackgroundColor {
    return _todayBackgroundColor;
}

-(void)setTodayBackgroundColor:(UIColor *)todayBackgroundColor{
    _todayBackgroundColor=todayBackgroundColor;
}

- (UIColor *)tappedDayBackgroundColor {
    return _tappedDayBackgroundColor;
}

- (IBAction)cancelAction:(id)sender {
    activeTextField.text=@"";
    [self endEditing:YES];
    [self.superview endEditing:YES];
    [self deActiveCalendar];
}

- (IBAction)okAciton:(id)sender {
    
    [self endEditing:YES];
    [self.superview endEditing:YES];
    [self deActiveCalendar];
    if (activeLabel==nil) {
        [self.delegate deactiveWSCalendarWithDate:[NSDate date]];
    }
    else{
        [self.delegate deactiveWSCalendarWithDate:activeLabel.linkedDate];
    }
    
    
}

-(void)setTappedDayBackgroundColor:(UIColor *)tappedDayBackgroundColor{
    _tappedDayBackgroundColor=tappedDayBackgroundColor;
}


-(void)ActiveCalendar:(UIView *)view{

    if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
        activeTextField=(UITextField *)view;
    }
    [self reloadCalendar];
    [self addLayerToPopup];
    [self showCalendarInView:view];
}

-(void)deActiveCalendar{
    [self rempveLayerFromPopup];
    UIView *view;
    [self hideCalendarInView:view];
}

- (IBAction)closeAction:(id)sender {
    [self endEditing:YES];
    [self deActiveCalendar];
}

-(void)showCalendarInView:(UIView *)view{
    
    self.hidden=YES;
    self.alpha=0.1;
    CGRect mainScreenFrame = [UIScreen mainScreen].bounds;
    self.frame=CGRectMake(20,mainScreenFrame.size.width/2, (mainScreenFrame.size.width-40), 300);
    self.hidden=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(20,mainScreenFrame.size.width/2, (mainScreenFrame.size.width-40), 300);
        self.alpha=1.0;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)hideCalendarInView:(UIView *)view{
    
    self.hidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
    } completion:^(BOOL finished) {
    }];
}


-(void)addLayerToPopup
{
    UIView *layerView=[[UIView alloc] initWithFrame:self.superview.frame];
    layerView.tag=2000;
    layerView.backgroundColor=[UIColor blackColor];
    layerView.alpha=0.5;
    UITapGestureRecognizer *tapG =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    [layerView addGestureRecognizer:tapG];
    [self.superview addSubview:layerView];
    [self.superview bringSubviewToFront:self];
}

-(void)rempveLayerFromPopup
{
    UIView *layerView=[self.superview viewWithTag:2000];
    [layerView removeFromSuperview];
    layerView=nil;
}

//The event handling method
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self endEditing:YES];
    [self.superview endEditing:YES];
    [self deActiveCalendar];
}




@end
