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
#import "list1.h"
#import "P_ListViewController.h"
#import "WeekViewController.h"
#import "StudentScheduleViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "WeekViewCell.h"

#import "StudentScheduleViewController.h"
#import "CLWeeklyCalendarView.h"
#import "MonthViewController.h"
#import "Month1wViewController.h"
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
#import "P_MonthViewController.h"
#import "P_WeekViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "pdashboardViewController.h"
#import "P_SettingViewController.h"
#import "pdashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"


@interface P_ListViewController()<CLWeeklyCalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,VRGCalendarViewDelegate>

{
    NSMutableArray *ary;
    UIPickerView *picker1;
    NSMutableArray *arr_picker;
    VRGCalendarView *cal;
    CGRect   FrameTable;
    
    NSString    * student_id,*view_select,*s_year,*s_year_id , * term_flag,*parentid;
    
     NSString*cp_flag,*coperiod;
    
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

@implementation P_ListViewController







@synthesize ary_data;
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
    
    
    
    
    
    
    
    NSDateFormatter * dff=[[NSDateFormatter alloc]init];
    [dff setDateFormat:@"yyyy-MM-dd"];
    date_value=[dff stringFromDate:[NSDate date]];
    
    
    
    
    [self alldata];
    
    
    
    flag1=0;
    calendar_id=@"";
    assignment_data=@"event";
    [self assign];
    self.text_mon_day_yr.text=@"List View";
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
//    
//    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
//    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];


    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_calendar.php?parent_id=%@&student_id=%@&syear=%@&action_type=%@&view_type=list&date=%@&calendar_id=",parentid,student_id,s_year,assignment_data,date_value];
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
        
        //  ary=[dictionary1 objectForKey:@"cal_data"];
        //NSLog(@"ary data---%@",ary);
        
        ary_data=[dictionary1 objectForKey:@"school_calender"];
        
        
        ary_data_id=[[NSMutableArray alloc]init];
        
        ary_assign=[[NSMutableArray alloc]initWithObjects:@"Events",@"Assignments", nil];
        
        NSLog(@"ary data---%@",ary_data);
        if ([ary_data count]>0) {
            ary_data_title = [[NSMutableArray alloc] init];
            ary_data_id= [[NSMutableArray alloc] init];
            for (int i = 0; i<[ary_data count]; i++) {
                NSDictionary *dic15 = [ary_data objectAtIndex:i];
                [ary_data_title  addObject:[dic15 objectForKey:@"TITLE"]];
                [ary_data_id addObject:[dic15 objectForKey:@"ID"]];
                
            }
            
            
            
            
//            txt_cal.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"TITLE"]];
//            school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"ID"]];
            
            
        }
        else {
            NSLog(@"No  list");
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.table setHidden:YES];
        [label_nodata setHidden:NO];
        
    }];
    [operation start];
    
    
    
    
    
    
    
    [self courseperiod123];
    [self loadPicker1];
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
    
    
    arr_picker = [[NSMutableArray alloc]initWithObjects:@"Week",@"Month", nil];
    
    // [self showdateinLabel:str_current_date];
    [self dodesignsforTextViews:self.view_mon_day_yr];
    //[self loaddata];
    //   [self ];
    self.table.tableFooterView = [[UIView alloc]init];
    
    [self.view_ForCalender addSubview:self.calendarView];
    
    NSLog(@"ary_data-----%@",ary_data);
    
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    self.view_blackDate.hidden = YES;
    label_titleforthisPage.text = [NSString stringWithFormat:@"Schedule: %@",self.studentName];
    
    [self designview];
    
    
    
//    txt_cal.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"TITLE"]];
//    school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"ID"]];
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
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(loaddata1) withObject:nil afterDelay:2.0];
            });
        });
    //[self loaddata1];
    
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
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];

    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_calendar.php?parent_id=%@&student_id=%@&syear=%@&action_type=%@&view_type=list&date=%@&calendar_id=",parentid,student_id,s_year,assignment_data,date_value];
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
        
        //  ary=[dictionary1 objectForKey:@"cal_data"];
        //NSLog(@"ary data---%@",ary);
        
        ary_data=[dictionary1 objectForKey:@"school_calender"];
        
        
        ary_data_id=[[NSMutableArray alloc]init];
        
        ary_assign=[[NSMutableArray alloc]initWithObjects:@"Events",@"Assignments", nil];
        
        NSLog(@"ary data---%@",ary_data);
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
    
    if ([cp_flag isEqualToString:@"1"]) {
        
        //txt_cal.text=inbox_data;
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
        [self loaddata1];
        
        
    }
    else
    {
        
    }
    
    [txt_cal resignFirstResponder];
}








- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
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
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
            });
        });
        
        
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




-(void)alldata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSMutableDictionary *dic1678=[[NSMutableDictionary alloc]init];
    NSString *strt78=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];
    ary_stdlist=[[NSMutableArray alloc]init ];
    ary_stdname=[[NSMutableArray alloc]init ];
    
    ary_stdid=[[NSMutableArray alloc]init ];
    ary_stdlist=[[appDelegate.dic_techinfo objectForKey:@"students_list"]mutableCopy ];
    
    for (int i=0; i<[ary_stdlist count]; i++) {
        
        
        if ([strt78 isEqual:[[ary_stdlist  objectAtIndex:i]objectForKey:@"ID"]]) {
            dic1678=[ary_stdlist objectAtIndex:i];
            
            [ary_stdid  addObject:[dic1678 objectForKey:@"ID"]];
            
            
            NSLog(@"-----------%@",ary_stdid);
            [ary_stdname addObject:[dic1678 objectForKey:@"VALUE"]];
            
            s_name=true;
            break;
            
            
        }
        
    }
    
    if (s_name==true) {
        
        txt_cal.text=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
    }
    
    else
    {
        
        txt_cal.text=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
        
    }
    
    
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
        
        
        return ary_stdname.count;
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
        return [ary_stdname objectAtIndex:row];
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
        
        
        
        
        txt_cal.text=(NSString *)[ary_stdname objectAtIndex:row];
        NSString *strC1 =(NSString *)[ary_stdname objectAtIndex:row];
        coperiod=[ary_stdid objectAtIndex:[ary_stdname indexOfObjectIdenticalTo:strC1]];
        //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSString *strkk =(NSString *)[ary_stdid objectAtIndex:row];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
        dic_8 = [appDelegate.dic mutableCopy];
        [dic_8 setObject:strkk forKey:@"selected_student"];
        appDelegate.dic = [dic_8 mutableCopy];
        
        
        cp_flag=@"1";
        
    }
    
    if (pickerView.tag==7) {
        
        
        
        
        
        inbox_data =(NSString *)[ary_assign objectAtIndex:row];
        
        flag_i=@"1";
        
        
    }
    if (pickerView.tag==3) {
        
        
        self.text_mon_day_yr.text = [arr_picker objectAtIndex:row];
        //    NSString *str_12=[NSString stringWithFormat:@"%@",self.text_mon_day_yr.text];
        //    if ([str_12 isEqualToString:@"Month"]) {
        //
        //        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        MonthViewController *obj=[s instantiateViewControllerWithIdentifier:@"month"];
        //        [self.navigationController pushViewController:obj animated:YES];
        //
        //    }
        //    }
        
    }
    
}

- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 61.0f;
    
}

-(IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ary.count;
}
- (list1 *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // static NSString *CellIdentifier = @"studentscheduleviewcell";
    
    //static NSString *cellid = @"cell";
    //UITableViewCell *cell;
    list1 *cell;
    
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"list1"];
    
    //  cell.lbl_period.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"DESCRIPTION"]];
    
    
    cell.lbl_title.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TITLE"]]];
    
    
    
    
    //   cell.lbl_period.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"ASSIGNED_DATE"]];
    
    
    cell.lbl_time.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"SCHOOL_DATE"]]];
    cell.lbl_period.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"DESCRIPTION"]]];
    ///  cell.lbl_term.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"DUE_DATE"]];
    
    
    
    
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
    //     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Week"]) {
        
        
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"ParentStoryboard" bundle:nil];
        P_WeekViewController *obj=[s instantiateViewControllerWithIdentifier:@"p_week"];
        [self.navigationController pushViewController:obj animated:YES];

        
    }
    
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Month"]) {
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"ParentStoryboard" bundle:nil];
        P_MonthViewController *obj=[s instantiateViewControllerWithIdentifier:@"p_month"];
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


-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ParentStoryboard" bundle: nil];
    pdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"pdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
    
}
-(IBAction)thirdButton:(id)sender
{
    NSLog(@"Third Button");
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
    P_msg1 * mvc=[[P_msg1 alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_msg1"];
    [self.navigationController pushViewController:mvc animated:NO];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
}


@end







