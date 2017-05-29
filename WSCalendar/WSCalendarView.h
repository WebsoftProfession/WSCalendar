//
//  CalendarView.h
//  CalendarDemo
//
//  Created by Dotsquares on 3/9/16.
//  Copyright © 2016 Dotsquares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLabel.h"
#import "WSEventView.h"


typedef enum {
    WSCalendarStyleDialog=0,
    WSCalendarStyleView=1,
}WSCalendarStyle;

@protocol WSCalendarViewDelegate <NSObject>
-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate;
-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate;
-(NSArray *)setupEventForDate;
@end


@interface WSCalendarView : UIView
{
    
    __weak IBOutlet UIBarButtonItem *barBtnYear;
    __weak IBOutlet UIBarButtonItem *barBtnMonth;
    
    __weak IBOutlet UIBarButtonItem *btnBarDate;
    
    __weak IBOutlet UILabel *lblDate1;
    __weak IBOutlet UILabel *lblDate2;
    __weak IBOutlet UILabel *lblDate3;
    __weak IBOutlet UILabel *lblDate4;
    __weak IBOutlet UILabel *lblDate5;
    __weak IBOutlet UILabel *lblDate6;
    __weak IBOutlet UILabel *lblDate7;
    __weak IBOutlet UILabel *lblDate8;
    __weak IBOutlet UILabel *lblDate9;
    __weak IBOutlet UILabel *lblDate10;
    __weak IBOutlet UILabel *lblDate11;
    __weak IBOutlet UILabel *lblDate12;
    __weak IBOutlet UILabel *lblDate13;
    __weak IBOutlet UILabel *lblDate14;
    __weak IBOutlet UILabel *lblDate15;
    __weak IBOutlet UILabel *lblDate16;
    __weak IBOutlet UILabel *lblDate17;
    __weak IBOutlet UILabel *lblDate18;
    __weak IBOutlet UILabel *lblDate19;
    __weak IBOutlet UILabel *lblDate20;
    __weak IBOutlet UILabel *lblDate21;
    __weak IBOutlet UILabel *lblDate22;
    __weak IBOutlet UILabel *lblDate23;
    __weak IBOutlet UILabel *lblDate24;
    __weak IBOutlet UILabel *lblDate25;
    __weak IBOutlet UILabel *lblDate26;
    __weak IBOutlet UILabel *lblDate27;
    __weak IBOutlet UILabel *lblDate28;
    __weak IBOutlet UILabel *lblDate29;
    __weak IBOutlet UILabel *lblDate30;
    __weak IBOutlet UILabel *lblDate31;
    __weak IBOutlet UILabel *lblWeekDate;
    
    
    UITextField *activeTextField;
    WSLabel *activeLabel;
    
}

-(void)initializeMonthYear;

-(void)setMonth:(NSString *)month andYear:(NSString *)year;
- (IBAction)yearNextClicked:(id)sender;
- (IBAction)yearPrevClicked:(id)sender;
- (IBAction)NextClicked:(id)sender;
- (IBAction)PrevClicked:(id)sender;

-(void)reloadCalendar;

@property (nonatomic,strong) id<WSCalendarViewDelegate> delegate;
-(void)setupAppearance;
-(void)ActiveCalendar:(UIView *)view;


@property (assign) int calendarStyle;
@property (assign) BOOL isShowEvent;
@property (nonatomic,strong) UIColor *dayColor;
@property (nonatomic,strong) UIColor *weekDayNameColor;
@property (nonatomic,strong) UIColor *barDateColor;
@property (nonatomic,strong) UIColor *todayBackgroundColor;
@property (nonatomic,strong) UIColor *tappedDayBackgroundColor;




- (IBAction)cancelAction:(id)sender;
- (IBAction)okAciton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnOK;


@end
