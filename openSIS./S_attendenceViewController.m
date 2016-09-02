//
//  S_attendenceViewController.m
//  openSiS
//
//  Created by os4ed on 4/28/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "S_attendenceViewController.h"
#import "StudentScheduleViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "WeekViewCell.h"
#import "VRGCalendarView.h"
#import "StudentScheduleViewController.h"
#import "CLWeeklyCalendarView.h"
#import "SdashboardViewController.h"
#import "S_attendence_weekViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"
@interface S_attendenceViewController ()<CLWeeklyCalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,VRGCalendarViewDelegate>

{
    NSMutableArray *ary;
    UIPickerView *picker1;
    NSMutableArray *arr_picker;
    VRGCalendarView *cal;
    CGRect   FrameTable;
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
    
    NSDate *startdate,*lastdate;
    NSArray * s_schdle_data_ary;
    
    
}
@property (strong, nonatomic) NSString *str_date;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *view_mon_day_yr;
@property (strong, nonatomic) IBOutlet UILabel *label_date, *label_headerFullDate;
@property (strong, nonatomic) IBOutlet UITextField *text_mon_day_yr;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (strong, nonatomic) IBOutlet UIView *view_blackDate;
@property (strong, nonatomic) IBOutlet UIView *view_ForCalender;
@property (nonatomic, strong) CLWeeklyCalendarView* calendarView;

@property(strong,nonatomic)  VRGCalendarView *cal;
@end

@implementation S_attendenceViewController








@synthesize cal;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSDateFormatter * dff=[[NSDateFormatter alloc]init];
    [dff setDateFormat:@"yyyy-MM-dd"];
    date_value=[dff stringFromDate:[NSDate date]];

   
    
    
    
    
    
    
    
    
//    
//    NSDate *curDate = [NSDate date];
//    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
//    NSRange daysRange =
//    [currentCalendar
//     rangeOfUnit:NSDayCalendarUnit
//     inUnit:NSMonthCalendarUnit
//     forDate:curDate];
//    
//    // daysRange.length will contain the number of the last day
//    // of the month containing curDate
//    
//    NSLog(@"DDDDDDDD%lu", (unsigned long)daysRange.length);
//
    
    
    
    
    
    
    
    
    
    
    
    
    self.text_mon_day_yr.text=@"Month";
    cal=[[VRGCalendarView alloc] init];
    cal.delegate=self;
    // [cal setFrame:CGRectMake(0.0f, 20.0f, 320.0f, 320.0f)];
    [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
    
    FrameTable=[cal frame];
    [view1 addSubview:cal];
    cal.clipsToBounds=YES;
    cal.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    
    NSString *str_current_date;//=[NSString stringWithFormat:@"%@",[NSDate date]];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MMM dd, yyyy"];
    
    
    str_current_date=[df stringFromDate:[NSDate date]];
    NSLog(@">>>>>%@",str_current_date);
    NSDateFormatter *df1=[[NSDateFormatter alloc]init];
    //  NSDate *date1 = [df1 dateFromString:[NSDate date]];
    [df1 setDateFormat:@"MMM dd, yyyy"];
    self.label_date.text = str_current_date;
    
    NSDateFormatter *df12 = [[NSDateFormatter alloc]init];
    
    
    [df12 setDateFormat:@"EEEE, MMMM dd, yyyy"];
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
    
    arr_picker = [[NSMutableArray alloc]initWithObjects:@"Date",@"Week",@"Month", @"Year", nil];
    
    [self dodesignsforTextViews:self.view_mon_day_yr];
    [self loaddata];
    [self loadPicker1];
    self.table.tableFooterView = [[UIView alloc]init];
    
    [self.view_ForCalender addSubview:self.calendarView];
    
    self.calendarView.clipsToBounds=YES;
    self.calendarView.autoresizingMask=UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
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
























-(void)n1
{
    [cal showNextMonth];
    NSLog(@"------->>>%@",cal.currentMonth);
    
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



- (void)viewWillAppear:(BOOL)animated
{
    
    self.view_blackDate.hidden = YES;
    label_titleforthisPage.text = [NSString stringWithFormat:@"Schedule: %@",self.studentName];
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
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/view_schedule.php?school_id=1&syear=2015&staff_id=2&mp_id=16&student_id=13&date=2015-11-25
    
    
    
    
    
    
    [self startdate];
    [self enddate];
    
    
    
   
    
    NSLog(@"startdate>>>>>>>%@",startdate);
    NSLog(@"enddate>>>>>>>%@",lastdate);
    NSLog(@"currentdate>>>>>>>%@",date_value);
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
//    
//    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
//    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];

    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    //NSString*str_checklogin=[NSString stringWithFormat:@"/view_schedule.php?school_id=%@&syear=%@&staff_id=%@&mp_id=%@&student_id=%@&date=%@",school_id123456,str_school_year,STAFF_ID_K,mp_id,self.studentID,date_value];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_attendance.php?student_id=%@&school_id=%@&syear=%@&start_date=%@&end_date=%@&selected_date=%@&mp_id=%@",student_id,s_year_id,s_year,startdate,lastdate,date_value,mp_id];

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
        
        
        
       s_schdle_data_ary=[dictionary1 objectForKey:@"student_schedule_data"];
        
        
        
        
        
        
        
        
        
        
        
        
        
        [self.table reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self.table setHidden:YES];
//        [label_nodata setHidden:NO];
        
    }];
    [operation start];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
-(IBAction)Report:(id)sender
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return s_schdle_data_ary.count;
}
- (WeekViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  
    WeekViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weekviewcell"];
   
    cell.periodname_lbl.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[s_schdle_data_ary objectAtIndex:indexPath.row]objectForKey:@"COURSE_PERIOD"]]];
    cell.time_lbl.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[s_schdle_data_ary objectAtIndex:indexPath.row]objectForKey:@"TIME_PERIOD"]]];
    
    
    
    
   NSString * str=[self nullChecker:[NSString stringWithFormat:@"%@",[[s_schdle_data_ary objectAtIndex:indexPath.row]objectForKey:@"STATE_CODE"]]];
    
    
    
    if ([str isEqualToString:@"P"]) {
        cell.lbl_present.backgroundColor=[UIColor greenColor];
    }
    
    else if ([str isEqualToString:@"A"])
    
    {
        cell.lbl_present.backgroundColor=[UIColor redColor];
    }
    
    else if ([str isEqualToString:@"T"])
        
    {
        cell.lbl_present.backgroundColor=[UIColor orangeColor];
    }

    
    
    
    
    
    
    
    cell.lbl_present.text=str;
    
    

    
    
    
    
    
    
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


- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
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
    // picker1.tag=3;
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
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    if ([self.text_mon_day_yr.text isEqualToString:@"Week"]) {
//   
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    if ([self.text_mon_day_yr.text isEqualToString:@"Date"]) {
//        StudentScheduleViewController *wv = [[StudentScheduleViewController alloc]init];
//        wv = [sb instantiateViewControllerWithIdentifier:@"studentscheduleview"];
//        wv.studentID = self.studentID;
//        wv.studentName = self.studentName;
//        [self.navigationController pushViewController:wv animated:YES];
    
   // }
    
    
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Week"]) {
        
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
        S_attendence_weekViewController *obj=[s instantiateViewControllerWithIdentifier:@"s_week"];
        [self.navigationController pushViewController:obj animated:YES];
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arr_picker.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arr_picker objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.text_mon_day_yr.text = [arr_picker objectAtIndex:row];
    NSString *str_12=[NSString stringWithFormat:@"%@",self.text_mon_day_yr.text];
   
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
    self.str_date = [df stringFromDate:date];
    
    [self loaddata];
    
    [df setDateFormat:@"EEEE, MMMM dd, yyyy"];
    self.label_headerFullDate.text = [df stringFromDate:date];
    
    
    
}




@end







