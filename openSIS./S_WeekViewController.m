//
//  ViewController.m
//  CALEDERMONTH
//
//  Created by Tanay Bhattacharjee on 10/12/15.
//  Copyright © 2015 Tanay Bhattacharjee. All rights reserved.
//

//
//  WeekViewController.m
//  openSiS
//
//  Created by os4ed on 12/14/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "list.h"
#import "WeekViewController.h"
#import "StudentScheduleViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "WeekViewCell.h"

#import "StudentScheduleViewController.h"
#import "CLWeeklyCalendarView.h"
#import "MonthViewController.h"
#import "S_WeekViewController.h"
#import "StudentScheduleViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "WeekViewCell1.h"
#import "VRGCalendarView.h"
#import "StudentScheduleViewController.h"
#import "CLWeeklyCalendarView.h"
#import "MonthViewController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "S_MonthViewController.h"
#import "S_ListViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"


@interface S_WeekViewController ()<CLWeeklyCalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,VRGCalendarViewDelegate>

{
    NSMutableArray *ary;
    UIPickerView *picker1;
    NSMutableArray *arr_picker;
    VRGCalendarView *cal;
    CGRect   FrameTable;
    
    NSString    * student_id,*view_select,*s_year,*s_year_id , * term_flag;

    NSString * startdate,*lastdate;
    
    
}
@property (strong, nonatomic) NSString *str_date;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *view_mon_day_yr;
@property (strong, nonatomic) IBOutlet UILabel *label_date, *label_headerFullDate;
@property (strong, nonatomic) IBOutlet UITextField *text_mon_day_yr;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (strong, nonatomic) IBOutlet UIView *view_blackDate;

@property (nonatomic, strong) CLWeeklyCalendarView* calendarView;

@property(strong,nonatomic)  VRGCalendarView *cal;
@end

@implementation S_WeekViewController








@synthesize cal;
-(void)n1
{
    [cal showNextMonth];
    NSLog(@"-------%@",cal.currentMonth);
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, yyyy"];
    NSDateFormatter *df12 = [[NSDateFormatter alloc]init];
    
    
    [df12 setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *tble_date=[df12 stringFromDate:self.cal.currentMonth];
    
    NSString  *  str_current_date=[df stringFromDate:self.cal.currentMonth];
    // NSDateFormatter *df1
    self.label_date.text=[NSString stringWithFormat:@"%@",str_current_date];
    // self.label_date.text=@"";
    
    self.label_headerFullDate.text=[NSString stringWithFormat:@"%@",tble_date];
    [self designview];
    
}
-(CLWeeklyCalendarView *)calendarView
{
    if(!_calendarView){
        _calendarView = [[CLWeeklyCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        _calendarView.delegate = self;
    }
    return _calendarView;
}





-(void)startdate
{
    NSDate *curDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:curDate]; // Get necessary date components
    
    // set last of month
    [comps setMonth:[comps month]];
    [comps setDay:1];
    
    
    
    NSDateFormatter * df=[[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    startdate = [df stringFromDate:[calendar dateFromComponents:comps]];
    
    
    NSLog(@"start date...%@", startdate);
    
}


-(void)enddate
{
    
    
    
    
    
    NSDate *curDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:curDate]; // Get necessary date components
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    
    NSDateFormatter * df=[[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    lastdate = [df stringFromDate:[calendar dateFromComponents:comps]];
    
    
    NSLog(@"end date...%@", lastdate);
    
    
    
}

















-(void)designview
{
    
    [view_cal.layer setCornerRadius:1.0f];
    view_cal.clipsToBounds = YES;
    [view_cal.layer setBorderWidth:1.0f];
    view_cal.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
    [view_assign.layer setCornerRadius:1.0f];
    view_assign.clipsToBounds = YES;
    [view_assign.layer setBorderWidth:1.0f];
    view_assign.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
}
-(void)n
{
    [cal showPreviousMonth];
    NSLog(@"-----");
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, yyyy"];
    NSDateFormatter *df12 = [[NSDateFormatter alloc]init];
    
    
    [df12 setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *tble_date=[df12 stringFromDate:self.cal.currentMonth];
    
    
    NSString  *  str_current_date=[df stringFromDate:self.cal.currentMonth];
    // NSDateFormatter *df1
    self.label_date.text=[NSString stringWithFormat:@"%@",str_current_date];
    self.label_headerFullDate.text=[NSString stringWithFormat:@"%@",tble_date];
}
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month year:(int)year numOfDays:(int)days targetHeight:(float)targetHeight animated:(BOOL)animated
{
    
    //    for (UIView *SubView in [cal subviews])
    //    {
    //        if ([SubView isKindOfClass:[UIImageView class]])
    //        {
    //            UIImageView *imageView=(UIImageView *)SubView;
    //            if (imageView.image==[UIImage imageNamed:@"icon_cal_lyellow"])
    //            {
    //                [imageView removeFromSuperview];
    //            }
    //        }
    //    }
    
    //   [Addoperation addOperationWithBlock:^{
    //  [self loaddates:[NSString stringWithFormat:@"%d",month]];
    
    //  }];
    
    
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date
{
    /* [nodataLable setHidden:YES];
     [dateFormatterloop setDateFormat:@"dd"];
     
     NSString *StrLoop=[dateFormatterloop stringFromDate:date];
     
     if ((MonthString>monthnow)&&(mainyear>=Distributeyear))
     {
     
     [Lblupcomming setText:@"Event Details"];
     
     }
     else if (Distributeyear<mainyear)
     {
     [Lblupcomming setText:@"Event Details"];
     }
     else if (([StrLoop integerValue]<[todayDate integerValue])&&MonthString==monthnow)
     {
     [Lblupcomming setText:@"Event Details"];
     
     }
     else
     {
     [Lblupcomming setText:@"Upcoming Events"];
     }*/
    
    
    //  [self Getdatevaluefromfrommonth:StrLoop];
    self.label_date.text=@"";
    
    NSLog(@"Selected date = %@",date);
    
    // date_value=[NSString stringWithFormat:@"%@",date];
    //  NSLog(@"-=----------%@",date_value);
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    
    date_value=[df stringFromDate:date];
    NSLog(@"oo=============%@",cal.labelCurrentMonth.text);
    cal.labelCurrentMonth.text=date_value;
    NSLog(@"kk=============%@",cal.labelCurrentMonth.text);
    NSLog(@"-=----------%@",date_value);
    
    NSDate *date1 = [df dateFromString:date_value];
    [df setDateFormat:@"MMM dd, yyyy"];
    self.label_date.text = [df stringFromDate:date1];
    NSDateFormatter *df12 = [[NSDateFormatter alloc]init];
    
    
    [df12 setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSString *tble_date=[df12 stringFromDate:date];
    
    self.label_headerFullDate.text=tble_date;
    [self loaddata];
}
-(void)GetTodaysmonth:(UITapGestureRecognizer *)Gesture

{
    NSLog(@"fff");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag1=0;
    calendar_id=@"";
    assignment_data=@"assignment";
    [self assign];
    self.text_mon_day_yr.text=@"Week";
    
    
    
    [self startdate];
    [self enddate];
    
    
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/calender.php?staff_id=2&school_id=1&syear=2015&action_type=list_events&view_type=list&date=&calendar_id=
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
//    
//    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
//    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    

    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_calendar.php?student_id=%@&school_id=%@&syear=%@&action_type=%@&view_type=week&start_date=%@&end_date=%@&calendar_id=",student_id,s_year_id,s_year,assignment_data,startdate,lastdate];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"data_success"]];
        NSLog(@"success is: -----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            [self.table setHidden:NO];
            [label_nodata setHidden:YES];
            
            
            ary=[dictionary1 objectForKey:@"cal_data"];
            NSLog(@"ary data---%@",ary);
            
            
            
            
            [self.table reloadData];
            
        }
        else
        {
            [self.table setHidden:YES];
            [label_nodata setHidden:NO];
            //  UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Not Found" message:[dictionary1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            // [alrt show];
        }
        
        
        ary_data=[[NSMutableArray alloc]init ];
        ary_data_title=[[NSMutableArray alloc]init];
        
        ary=[dictionary1 objectForKey:@"cal_data"];
        NSLog(@"ary data---%@",ary);
        
        ary_data=[dictionary1 objectForKey:@"school_calender"];
        ary_data_id=[[NSMutableArray alloc]init];
        
        ary_assign=[[NSMutableArray alloc]initWithObjects:@"Events",@"Assignments",nil];
        
        
        if ([ary_data count]>0) {
            ary_data_title = [[NSMutableArray alloc] init];
            ary_data_id= [[NSMutableArray alloc] init];
            for (int i = 0; i<[ary_data count]; i++) {
                NSDictionary *dic15 = [ary_data objectAtIndex:i];
                [ary_data_title  addObject:[dic15 objectForKey:@"TITLE"]];
                [ary_data_id addObject:[dic15 objectForKey:@"ID"]];
                
                
            }
            
            txt_cal.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"TITLE"]];
            school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"ID"]];
            
        }
        else {
            NSLog(@"No  list");
            
            txt_cal.text=@"No List";
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.table setHidden:YES];
        [label_nodata setHidden:NO];
        
    }];
    [operation start];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    [self loadPicker1];
    [self courseperiod123];
    [self.view_ForCalender addSubview:self.calendarView];
    cal=[[VRGCalendarView alloc] init];
    cal.delegate=self;
    // [cal setFrame:CGRectMake(0.0f, 20.0f, 320.0f, 320.0f)];
    [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
    
    FrameTable=[cal frame];
    
    [view1 addSubview:cal];
    NSString *str_current_date;//=[NSString stringWithFormat:@"%@",[NSDate date]];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, yyyy"];
    
    
    str_current_date=[df stringFromDate:[NSDate date]];
    NSDateFormatter *df1=[[NSDateFormatter alloc]init];
    //  NSDate *date1 = [df1 dateFromString:[NSDate date]];
    [df1 setDateFormat:@"MMM dd, yyyy"];
    self.label_date.text = str_current_date;
    
    NSDateFormatter *df12 = [[NSDateFormatter alloc]init];
    
    
    [df12 setDateFormat:@"EEEE, MMMM dd, yyyy"];
    NSDateFormatter *df100 = [[NSDateFormatter alloc]init];
    [df100 setDateFormat:@"yyyy-MM-dd"];
    date_value=[df100 stringFromDate:[NSDate date]];
    NSString *tble_date=[df12 stringFromDate:[NSDate date]];
    
    self.label_headerFullDate.text=tble_date;
    
    self.label_headerFullDate.text=[NSString stringWithFormat:@"%@",tble_date];
    NSLog(@"----%@",str_current_date);
    //  self.label_date.text=str_current_date;
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(n)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [cal addGestureRecognizer:recognizer];
    UISwipeGestureRecognizer *recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(n1)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [cal addGestureRecognizer:recognizer1];
    
    
    ary = [[NSMutableArray alloc]init];
    
    //   NSDate *date = [NSDate date];
    //date_value= [ self convertDate:date];
    
    
    arr_picker = [[NSMutableArray alloc]initWithObjects:@"Month", @"List View", nil];
    
    // [self showdateinLabel:str_current_date];
    [self dodesignsforTextViews:self.view_mon_day_yr];
    [self loaddata];
    //   [self ];
    self.table.tableFooterView = [[UIView alloc]init];
    
    [self.view_ForCalender addSubview:self.calendarView];
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    self.view_blackDate.hidden = YES;
    label_titleforthisPage.text = [NSString stringWithFormat:@"Schedule: %@",self.studentName];
    _text_mon_day_yr.text=@"Week";
    
    [self designview];
    
    
}


-(NSString *)convertDate:(NSDate *)dateparam
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [df stringFromDate:dateparam];
    
    return str;
    
}
-(void)showdateinLabel:(NSString *)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:dateStr];
    [df setDateFormat:@"MMM dd, yyyy"];
    self.label_date.text = [df stringFromDate:date];
    
}


-(void)loaddata
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:2.0];
    //        });
    //    });
    [self loaddata1];
    
}

- (void)dodesignsforTextViews:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.647f green:0.647f blue:0.647f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    disview.clipsToBounds = YES;
}

-(void)loaddata1
{
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/calender.php?staff_id=2&school_id=1&syear=2015&action_type=list_events&view_type=list&date=&calendar_id=
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
//    
//    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
//    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    
    
    [self startdate];
    [self enddate];
    
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_calendar.php?student_id=%@&school_id=%@&syear=%@&action_type=%@&view_type=week&start_date=%@&end_date=%@&calendar_id=",student_id,s_year_id,s_year,assignment_data,startdate,lastdate];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"data_success"]];
        NSLog(@"success is: -----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            [self.table setHidden:NO];
            [label_nodata setHidden:YES];
            
            
            ary=[dictionary1 objectForKey:@"cal_data"];
            NSLog(@"ary data---%@",ary);
            
            
            
            
            [self.table reloadData];
            
        }
        else
        {
            [self.table setHidden:YES];
            [label_nodata setHidden:NO];
            //  UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Not Found" message:[dictionary1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            // [alrt show];
        }
        
        
        ary_data=[[NSMutableArray alloc]init ];
        ary_data_title=[[NSMutableArray alloc]init];
        
        ary=[dictionary1 objectForKey:@"cal_data"];
        NSLog(@"ary data---%@",ary);
        
        ary_data=[dictionary1 objectForKey:@"school_calender"];
        ary_data_id=[[NSMutableArray alloc]init];
        
        //  ary_assign=[[NSMutableArray alloc]initWithObjects:@"Assignments",@"Events", nil];
        
        
        if ([ary_data count]>0) {
            ary_data_title = [[NSMutableArray alloc] init];
            ary_data_id= [[NSMutableArray alloc] init];
            for (int i = 0; i<[ary_data count]; i++) {
                NSDictionary *dic15 = [ary_data objectAtIndex:i];
                [ary_data_title  addObject:[dic15 objectForKey:@"TITLE"]];
                [ary_data_id addObject:[dic15 objectForKey:@"ID"]];
                
                
            }
            
            
        }
        else {
            NSLog(@"No  list");
            
            txt_cal.text=@"No List";
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.table setHidden:YES];
        [label_nodata setHidden:NO];
        
    }];
    [operation start];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
-(void)pickerDoneClicked1
{
    
    if ([flag isEqualToString:@"1"]) {
        
        txt_cal.text=inbox_data;
        NSLog(@"school id-----%@",school_id);
        NSLog(@"assigdata----%@",assignment_data);
        //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                //[MBProgressHUD hideHUDForView:self.view animated:YES];
        //                [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        //            });
        //        });
        //
        
        //  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self loaddata];
        
        
    }
    else
    {
        
    }
    
    [txt_cal resignFirstResponder];
}

-(void)pickerDoneClicked3
{
    [self.text_mon_day_yr resignFirstResponder];
    
}
-(void)pickerDoneClicked2
{
    
    if ([flag_i isEqualToString:@"1"]) {
        
        txt_assign.text=inbox_data;
        if ([inbox_data isEqualToString:@"Events"]) {
            assignment_data=@"event";
            flag1=0;
        }
        
        else
            
        {
            
            assignment_data=@"assignment";
            flag1=1;
        }
        
        //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                //[MBProgressHUD hideHUDForView:self.view animated:YES];
        //                [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        //            });
        //        });
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self loaddata1];
    }
    else
    {
        
    }
    
    [txt_assign resignFirstResponder];
}

-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    txt_cal.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    txt_cal.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

-(void)assign{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=7;
    txt_assign.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked2)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    txt_assign.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    
    if (pickerView.tag==60) {
        
        
        return ary_data_title.count;
    }
    else if (pickerView.tag==7)
    {
        return ary_assign.count;
        
    }
    else if (pickerView.tag==3)
    {
        return arr_picker.count;
        
    }
    
    return 0;
    
    
    
    
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView.tag==60) {
        return [ary_data_title objectAtIndex:row];
    }
    else if (pickerView.tag==7)
    {
        return [ary_assign objectAtIndex:row];
        
    }
    
    else if (pickerView.tag==3)
    {
        return [arr_picker objectAtIndex:row];
        
    }
    
    
    return 0;
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    
    
    if (pickerView.tag==60) {
        
        
        
        
        
        inbox_data =(NSString *)[ary_data_title objectAtIndex:row];
        NSString *strC =(NSString *)[ary_data_title objectAtIndex:row];
        school_id= [ary_data_id objectAtIndex:[ary_data_title indexOfObjectIdenticalTo:strC]];
        flag=@"1";
        
        
    }
    
    if (pickerView.tag==7) {
        
        
        
        
        
        inbox_data =(NSString *)[ary_assign objectAtIndex:row];
        
        flag_i=@"1";
        
        
    }
    if (pickerView.tag==3) {
        
        
        self.text_mon_day_yr.text = [arr_picker objectAtIndex:row];
        
        
        
    }
    
}



- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(IBAction)thirdButton:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    S_ReportViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"rprt"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
    MsgViewController *mgc =[[MsgViewController alloc]init];
    mgc=[sb instantiateViewControllerWithIdentifier:@"msg"];
    [self.navigationController pushViewController:mgc animated:NO];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SettingViewController * mvc=[[SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}


-(IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ary.count;
}
- (WeekViewCell1 *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // static NSString *CellIdentifier = @"studentscheduleviewcell";
    
    //static NSString *cellid = @"cell";
    //UITableViewCell *cell;
    WeekViewCell1 *cell;
    if (flag1==1) {
        
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"weekviewcell1"];
        
        cell.lbl_period.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"DESCRIPTION"]];
        
        
        cell.lbl_time.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TITLE"]];
    }
    
    else
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"weekviewcell2"];
        
        cell.day1.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"ASSIGNED_DATE"]];
        
        
        
        
        cell.lbl_time.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TITLE"]];
        cell.lbl_period.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"DESCRIPTION"]];
        cell.lbl_term.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"DUE_DATE"]];
        
        
    }
    
    //  cell.lbl_time2.text = [timestr substringFromIndex:rr.location+1];
    
    //
    //    NSArray *array_days = [[NSArray alloc]init];
    //    array_days = [[ary objectAtIndex:indexPath.row] objectForKey:@"DAYS"];
    //
    //    NSString *status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:0] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day1.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day1.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:1] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day2.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day2.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:2] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day3.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day3.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:3] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day4.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day4.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:4] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day5.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day5.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:5] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day6.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day6.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:6] objectForKey:@"status"]];
    //
    //    if ([status isEqualToString:@"1"]) {
    //        cell.day7.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    //    }
    //    else
    //    {
    //        cell.day7.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    //    }
    //
    //
    
    
    
    
    return cell;
}

- (IBAction)change_Date:(id)sender {
    self.view_blackDate.hidden = NO;
    [self.view bringSubviewToFront:self.view_blackDate];
    
}

- (IBAction)dateChanged:(UIDatePicker *)datePicker
{
    NSDate *date = self.datepicker1.date;
    self.str_date = [self convertDate:date];
    
    [self showdateinLabel:self.str_date];
    
}

- (IBAction)cancel_datepicker:(id)sender
{
    self.view_blackDate.hidden = YES;
    [self.text_mon_day_yr resignFirstResponder];
    
    [self loaddata];
}














-(void)loadPicker1{
    
    picker1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker1  .delegate = self;
    picker1 .dataSource = self;
    
    [ picker1  setShowsSelectionIndicator:YES];
    picker1.tag=3;
    self.text_mon_day_yr.inputView = picker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.text_mon_day_yr.inputAccessoryView = mypickerToolbar;
    
}

- (void)dismisspicker
{
    [self.text_mon_day_yr resignFirstResponder];
    self.view_blackDate.hidden = YES;
    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Month"]) {
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"S_Calender" bundle:nil];
        S_MonthViewController *obj=[s instantiateViewControllerWithIdentifier:@"s_month"];
        [self.navigationController pushViewController:obj animated:YES];
        
           }
    
    
    
    if ([self.text_mon_day_yr.text isEqualToString:@"List View"]) {
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"S_Calender" bundle:nil];
        S_ListViewController *obj=[s instantiateViewControllerWithIdentifier:@"s_list"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    
    
    
    
    
}



#pragma mark - week view delegate

-(NSDictionary *)CLCalendarBehaviorAttributes
{
    return @{
             CLCalendarWeekStartDay : @1,                 //Start Day of the week, from 1-7 Mon-Sun -- default 1
             CLCalendarDayTitleTextColor : [UIColor blackColor],
             CLCalendarSelectedDatePrintColor : [UIColor blackColor],
             };
    
}
-(void)dailyCalendarViewDidSelect: (NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, yyyy"];
    self.label_date.text = [df stringFromDate:date];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    date_value = [df stringFromDate:date];
    
    [self loaddata];
    
    [df setDateFormat:@"EEEE, MMMM dd, yyyy"];
    self.label_headerFullDate.text = [df stringFromDate:date];
    
    
    
}




@end







