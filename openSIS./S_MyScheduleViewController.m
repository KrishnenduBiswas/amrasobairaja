//
//  S_MyScheduleViewController.m
//  openSiS
//
//  Created by os4ed on 5/21/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "S_MyScheduleViewController.h"
#import "tabcell.h"
#import "Colcell.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "S_MonthViewController.h"
#import "Month1ViewController.h"
#import "StudentScheduleViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "WeekViewCell1.h"
#import "VRGCalendarView.h"
#import "StudentScheduleViewController.h"
#import "CLWeeklyCalendarView.h"
#import "MonthViewController.h"
#import "list.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "S_WeekViewController.h"
#import "S_ListViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"
#import "S_slideViewController.h"
#import "S_schedule_month.h"
#import "S_schedule_day.h"

@interface S_MyScheduleViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *col;
@property (strong, nonatomic) IBOutlet UITableView *tbl;
@property (strong, nonatomic) NSString *str_date;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *view_mon_day_yr;
@property (strong, nonatomic) IBOutlet UILabel *label_date, *label_headerFullDate;
@property (strong, nonatomic) IBOutlet UITextField *text_mon_day_yr;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (strong, nonatomic) IBOutlet UIView *view_blackDate;
@property (strong, nonatomic) IBOutlet UIView *view_ForCalender;
@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;

@end

@implementation S_MyScheduleViewController
{
    
    
     NSMutableDictionary * dic;
    
    
  
    UIPickerView *picker1;
    NSMutableArray *arr_picker;
    VRGCalendarView *cal;
    CGRect   FrameTable;

    
     NSString    * student_id,*view_select,*s_year,*s_year_id , * term_flag,*mp_id;
    
    
    NSMutableArray *ary_gradebook, *ary_setup;
    
    S_slideViewController *slide;
    NSString *courseperiodnamestr;
    
   
    NSString *str_c_school_id123,*school_year123,*period123,*sub123,*cou123,*coperiod;
    

    NSString *startdate;
    NSString *enddate;
    
    NSString*start;
    NSString *end;
    
    NSString * nextdate,*previousdate;
    
    
    NSString * mpidselect;
    
    NSDate *next_date,*previous_date;
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mainary=[[NSMutableArray alloc]init];
    
    _tbl.tableFooterView=[[UIView alloc]init];
    
    
    NSLog(@"%@",mainary);
    
    
    slide = [[S_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"myschdulestudent"];
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;

    NSDateFormatter * dff=[[NSDateFormatter alloc]init];
    [dff setDateFormat:@"yyyy-MM-dd"];
    date_value=[dff stringFromDate:[NSDate date]];
    next_date=[NSDate date];
    previous_date=[NSDate date];

    [self dodesignsforTextViews:self.view_mon_day_yr];
    
    arr_picker = [[NSMutableArray alloc]initWithObjects:@"Week",@"Month",@"Year",@"Day", nil];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    [self loaddata:mp_id];
    
    scroll2.contentSize = CGSizeMake(654-235,scroll2.frame.size.width);
    
    
    
    [self designview];
    
    [self loadPicker1];
    
    [self courseperiod123];
    
    
    [self alldata];
    
    
    
    
    [self startdate:next_date];
    [self lastdate:next_date];
    
    
   

    
    
    
    
    
    
    
    
    
}
















-(IBAction)btnrght:(id)sender
{
    
    [self nextweek];
    
    
    
    
    
}


-(IBAction)btnleft:(id)sender
{
    
    
    
    [self previousweek];
    

    
    
    
    
    
    
    
    
    
    
    
}



-(void)nextweek
{
    
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.day = 7;
    next_date = [calendar dateByAddingComponents:comps toDate:next_date options:0];
    
    
    
    
    NSDateFormatter * dff=[[NSDateFormatter alloc]init];
    [dff setDateFormat:@"yyyy-MM-dd"];
    nextdate=[dff stringFromDate:next_date];
    
    
    NSDate*d1=[self startdate:next_date];
    
    NSDate*d2=[self lastdate:next_date];
    
    
    
    NSDateFormatter * dff1=[[NSDateFormatter alloc]init];
    [dff1 setDateFormat:@"yyyy-MM-dd"];
    NSString*str1=nextdate=[dff1 stringFromDate:d1];
    
    
    
    NSDateFormatter * dff2=[[NSDateFormatter alloc]init];
    [dff2 setDateFormat:@"yyyy-MM-dd"];
    NSString*str2=[dff2 stringFromDate:d2];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self loaddata_again:nextdate second:str1 third:str2];
    
    
    
    
    NSLog(@"...........%@",nextdate);
    
    
    
    
}

-(void)previousweek
{
    
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [NSDateComponents new];
    comps.day = -7;
    next_date = [calendar dateByAddingComponents:comps toDate:next_date options:0];
    
    
    
    
    NSDateFormatter * dff=[[NSDateFormatter alloc]init];
    [dff setDateFormat:@"yyyy-MM-dd"];
    previousdate=[dff stringFromDate:next_date];
    
    NSLog(@"...........%@",previousdate);
    
    
   NSDate*d1=[self startdate:next_date];
    
   NSDate*d2=[self lastdate:next_date];
    
    
    
    
    
    
    
    
    
    NSDateFormatter * dff1=[[NSDateFormatter alloc]init];
    [dff1 setDateFormat:@"yyyy-MM-dd"];
    NSString*str1=nextdate=[dff1 stringFromDate:d1];
    
    
    
    NSDateFormatter * dff2=[[NSDateFormatter alloc]init];
    [dff2 setDateFormat:@"yyyy-MM-dd"];
    NSString*str2=[dff2 stringFromDate:d2];
    
    

    
    
    [self loaddata_again:nextdate second:str1 third:str2];
    

    
    
    
    
    
    
    
    
}





-(NSString *)getCourseperiodtextfielddata
{
    courseperiodnamestr = [NSString stringWithFormat:@"%@",txt_cal.text];
    return courseperiodnamestr;
}
#pragma mark-------setdata
-(void)setCourseperiodtextfielddata:(NSString*)str
{
    courseperiodnamestr=str;
    txt_cal.text = courseperiodnamestr;
}

-(IBAction)click:(id)sender
{
    NSLog(@"slid open");
    [self open];
}

#pragma mark SideBarOpenFunction

-(void)open
{
    [slide open:self.view];
    
}
-(void)close
{
    [slide close:nil];
    //[self fetchdata];
    //[self showdata];
    
}


















-(NSDate*)startdate:(NSDate*)nextdate
{
    
    
    //NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumber =  [[calendar components: NSWeekCalendarUnit fromDate:nextdate] week];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comp = [gregorian components:NSYearCalendarUnit fromDate:nextdate];
    [comp setWeek:weekNumber];
    [comp setWeekday:1];
    
    NSDate *resultDate = [gregorian dateFromComponents:comp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    startdate = [formatter stringFromDate:resultDate];
    NSLog(@"--------Firstdate>>>>%@",startdate);
 
    
   

    
    
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"MMM d, yyyy"];
    
    start = [formatter1 stringFromDate:resultDate];
    
    
    
    return resultDate;
    
    
    
    
    
    
    
}


-(NSDate*)lastdate:(NSDate*)nextdate
{
    
    
    //NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumber =  [[calendar components: NSWeekCalendarUnit fromDate:nextdate] week];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comp = [gregorian components:NSYearCalendarUnit fromDate:nextdate];
    [comp setWeek:weekNumber];
    [comp setWeekday:7];
    
    NSDate *resultDate = [gregorian dateFromComponents:comp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    enddate = [formatter stringFromDate:resultDate];
    NSLog(@"--------lastdate>>>>%@",enddate);
    
    
    
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"MMM d, yyyy"];
    
    end = [formatter1 stringFromDate:resultDate];

    
    return resultDate;
    
    
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
    // UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Month"]) {
        
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
        S_schedule_month *obj=[s instantiateViewControllerWithIdentifier:@"s_sch_month"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Year"]) {
//        UIStoryboard *s=[UIStoryboard storyboardWithName:@"S_Calender" bundle:nil];
//        S_ListViewController *obj=[s instantiateViewControllerWithIdentifier:@"s_list"];
//        [self.navigationController pushViewController:obj animated:YES];
        
    }
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Day"]) {
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
        S_schedule_day *obj=[s instantiateViewControllerWithIdentifier:@"s_sch_day"];
        [self.navigationController pushViewController:obj animated:NO];
    }
    
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    
    if (pickerView.tag==60) {
        
        
        return course_period_title.count;
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
        return [course_period_title objectAtIndex:row];
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
        
        
        
        
        
        txt_cal.text=(NSString *)[course_period_title objectAtIndex:row];
        // coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
        coperiod=[ca_cp_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSString *strkk =(NSString *)[course_period_id objectAtIndex:row];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
        dic_8 = [appDelegate.dic mutableCopy];
        [dic_8 setObject:strkk forKey:@"UserMP"];
        appDelegate.dic = [dic_8 mutableCopy];
        NSLog(@"marking period id1111------%@",course_period_ary);
        
        NSLog(@"mp_id-------%@",strkk);
        
        mpidselect=strkk;
        
        cp_flag=@"1";
        
        
    }
    
    if (pickerView.tag==7) {
        
        
        
        
        
        inbox_data =(NSString *)[ary_assign objectAtIndex:row];
        
        flag_i=@"1";
        
        
    }
    if (pickerView.tag==3) {
        
        
        self.text_mon_day_yr.text = [arr_picker objectAtIndex:row];
        
        
        
    }
    
    
    
    
    
    
}





-(void)alldata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
    _dic_techinfo=appDelegate.dic_techinfo;
    _dic=appDelegate.dic;
    NSLog(@"dic===========%@",_dic);
    course_period_ary=[[_dic objectForKey:@"marking_period_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"id"]];
            [ca_cp_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[_dic objectForKey:@"UserMP"]];
    
    
    // NSLog(@"course ary----%@",course_period_ary);
    if ([course_period_ary count] > 0) {
        for (int i=0; i<[course_period_ary count]; i++) {
            
            
            if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"id"]]) {
                dic177=[course_period_ary objectAtIndex:i];
                
                c_ap=true;
                break;
                
            }
            
            
        }
    }
    
    
    
}


























-(void)loaddata:(NSString*)mpid
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1:) withObject:mpid afterDelay:2.0];
        });
    });
    
    
}



-(void)loaddata1:(NSString*)mpid
{
    [mainary removeAllObjects];
    
    
    
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_view_schedule.php?student_id=1&school_id=1&syear=2015&mp_id=17&date=2016-01-21&view_mode=week&week_start=2016-01-17&week_end=2016-01-23
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    

   
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    
    
    
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_view_schedule.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&date=%@&view_mode=week&week_start=%@&week_end=%@",student_id,s_year_id,s_year,mpid,date_value,startdate,enddate];
    
    
    
//    NSString*str_checklogin=[NSString stringWithFormat:@"http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_view_schedule.php?student_id=1&school_id=1&syear=2015&mp_id=17&date=2016-01-21&view_mode=week&week_start=2016-01-17&week_end=2016-01-23"];
//    
    
    
    
    
    
    
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
  //NSURL *url = [NSURL URLWithString:url12];
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
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        ary=[dictionary1 objectForKey:@"schedule_data"];
        NSLog(@"%@",ary);
        
        
        
        
        for (int i=0; i<ary.count; i++) {
            ary1=[[ary objectAtIndex:i]objectForKey:@"COURSE_DATA"];
            
            
            NSMutableDictionary*diccc=[[NSMutableDictionary alloc]init];
             NSMutableDictionary*diccc1=[[NSMutableDictionary alloc]init];
              NSMutableDictionary*diccc2=[[NSMutableDictionary alloc]init];
              NSMutableDictionary*diccc3=[[NSMutableDictionary alloc]init];
              NSMutableDictionary*diccc4=[[NSMutableDictionary alloc]init];
            if (ary1.count==0) {
             
                    
                    [diccc setObject:@"" forKey:@"DAY"];
                    [diccc setObject:@"" forKey:@"TITLE"];
                    [diccc setObject:@"" forKey:@"TEACHER_NAME"];
                    [diccc setObject:@"" forKey:@"ROOM"];
                    [diccc setObject:@"" forKey:@"SHORT_NAME"];
                
                
                [diccc1 setObject:@"" forKey:@"DAY"];
                [diccc1 setObject:@"" forKey:@"TITLE"];
                [diccc1 setObject:@"" forKey:@"TEACHER_NAME"];
                [diccc1 setObject:@"" forKey:@"ROOM"];
                [diccc1 setObject:@"" forKey:@"SHORT_NAME"];
                
                [diccc2 setObject:@"" forKey:@"DAY"];
                [diccc2 setObject:@"" forKey:@"TITLE"];
                [diccc2 setObject:@"" forKey:@"TEACHER_NAME"];
                [diccc2 setObject:@"" forKey:@"ROOM"];
                [diccc2 setObject:@"" forKey:@"SHORT_NAME"];
                
                [diccc3 setObject:@"" forKey:@"DAY"];
                [diccc3 setObject:@"" forKey:@"TITLE"];
                [diccc3 setObject:@"" forKey:@"TEACHER_NAME"];
                [diccc3 setObject:@"" forKey:@"ROOM"];
                [diccc3 setObject:@"" forKey:@"SHORT_NAME"];

                [diccc4 setObject:@"" forKey:@"DAY"];
                [diccc4 setObject:@"" forKey:@"TITLE"];
                [diccc4 setObject:@"" forKey:@"TEACHER_NAME"];
                [diccc4 setObject:@"" forKey:@"ROOM"];
                [diccc4 setObject:@"" forKey:@"SHORT_NAME"];

                
                

                    
                
                
                
                
                
                ary1=[[NSMutableArray alloc]initWithObjects:diccc,diccc1,diccc2,diccc3,diccc4, nil];
               
                
                
                NSLog(@"--------------%@",ary1);
            }
            
            else
            {
                
            }
            
            
            for (int j=0; j<ary1.count; j++) {
                ary2=[[ary1 objectAtIndex:j]objectForKey:@"SHORT_NAME"];
                
                [mainary addObject:ary2];
                
                
            }
            
            
            
            
        }
        
        NSLog(@"............%@",ary);
        
        [self.tbl reloadData];
        [self.col reloadData];
        
        [self showdateinLabel];
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
     
        NSLog(@"ok----");
      
        
        
        
        
        
        
        
        
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}



-(void)loaddata_again:(NSString*)currentdate second:(NSString*)startdate1 third:(NSString*)lastdate1
{
    [mainary removeAllObjects];
    
    
    
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_view_schedule.php?student_id=1&school_id=1&syear=2015&mp_id=17&date=2016-01-21&view_mode=week&week_start=2016-01-17&week_end=2016-01-23
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    
    
    
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_view_schedule.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&date=%@&view_mode=week&week_start=%@&week_end=%@",student_id,s_year_id,s_year,mp_id,currentdate,startdate1,lastdate1];
    
    
    
    //    NSString*str_checklogin=[NSString stringWithFormat:@"http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_view_schedule.php?student_id=1&school_id=1&syear=2015&mp_id=17&date=2016-01-21&view_mode=week&week_start=2016-01-17&week_end=2016-01-23"];
    //
    
    
    
    
    
    
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
    //NSURL *url = [NSURL URLWithString:url12];
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
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        ary=[dictionary1 objectForKey:@"schedule_data"];
        NSLog(@"%@",ary);
        
        
        
        
        for (int i=0; i<ary.count; i++) {
            ary1=[[ary objectAtIndex:i]objectForKey:@"COURSE_DATA"];
            
            for (int j=0; j<ary1.count; j++) {
                ary2=[[ary1 objectAtIndex:j]objectForKey:@"SHORT_NAME"];
                
                [mainary addObject:ary2];
                
                
            }
            
            
            
            
        }
        
        NSLog(@"............%@",ary);

        [self.tbl reloadData];
        [self.col reloadData];
        
        [self showdateinLabel];
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
        NSLog(@"ok----");
        
        
        
        
        
        
        
        
        
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
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

-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    [txt_cal resignFirstResponder];
    
    
    
    
    [self loaddata1:mpidselect];
    
    
    
    
    
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
- (void)viewWillAppear:(BOOL)animated
{
    
    self.view_blackDate.hidden = YES;
    //label_titleforthisPage.text = [NSString stringWithFormat:@"Schedule: %@",self.studentName];
    _text_mon_day_yr.text=@"Week";
}


-(NSString *)convertDate:(NSDate *)dateparam
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [df stringFromDate:dateparam];
    
    return str;
    
}
-(void)showdateinLabel{
    _label_date.text=[NSString stringWithFormat:@"%@ - %@",start,end];
    
}

- (void)dodesignsforTextViews:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.647f green:0.647f blue:0.647f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    disview.clipsToBounds = YES;
}








































- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mainary.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Colcell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"A" forIndexPath:indexPath];
    
    NSString *str=[mainary objectAtIndex:indexPath.row];
    cell.lbl.text=str;
    
    if ([cell.lbl.text length]>0) {
        
        cell.lbl.backgroundColor=[UIColor colorWithRed:254.0/255.0f green:219.0/255.0f blue:147.0/255.0f alpha:1.0];
    }
    
    else
    {
        cell.lbl.backgroundColor=[UIColor colorWithRed:217.0/255.0f green:217.0/255.0f blue:217.0/255.0f alpha:1.0];
    }
    
    return cell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tabcell *cell=[tableView dequeueReusableCellWithIdentifier:@"A"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"tabcell" owner:self options:nil];
        cell=(tabcell *)[nib objectAtIndex:0];
    }
    
    cell.lbl.text=[[ary objectAtIndex:indexPath.row]objectForKey:@"TIME_PERIOD"];
    cell.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:141.0/255.0f blue:39.0/255.0f alpha:1.0];
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 28.0f;
    
    
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










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
