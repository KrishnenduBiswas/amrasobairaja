//
//  CourseManagerPeriodDetails.m
//  openSiS
//
//  Created by os4ed on 1/12/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "CourseManagerPeriodDetails.h"
#import "CourseManagerPeriod.h"
#import "CourseManagerCourse.h"
#import "CourseManagerSubject.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "CourseManagerPeriodCell.h"
#import "CourseManagerCourse.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"


@interface CourseManagerPeriodDetails ()
@property (strong, nonatomic) IBOutlet UIView *view_blue_sub;
@property (strong, nonatomic) IBOutlet UILabel *lbl_shrtname;
@property (strong, nonatomic) IBOutlet UILabel *lbl_calendar;
@property (strong, nonatomic) IBOutlet UILabel *lbl_seats;
@property (strong, nonatomic) IBOutlet UILabel *lbl_availabeSeats;
@property (strong, nonatomic) IBOutlet UILabel *lbl_credithour;
@property (strong, nonatomic) IBOutlet UILabel *lbl_grading;
@property (strong, nonatomic) IBOutlet UILabel *lbl_primaryTeacher;
@property (strong, nonatomic) IBOutlet UISwitch *switch_teacherGradebookScale;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Duration;
@property (strong, nonatomic) IBOutlet UILabel *lbl_scheduletype;

@property (strong, nonatomic) IBOutlet UILabel *lbl_period;

@property (strong, nonatomic) IBOutlet UILabel *lbl_sun;
@property (strong, nonatomic) IBOutlet UILabel *lbl_mon;
@property (strong, nonatomic) IBOutlet UILabel *lbl_tue;
@property (strong, nonatomic) IBOutlet UILabel *lbl_wed;
@property (strong, nonatomic) IBOutlet UILabel *lbl_thu;
@property (strong, nonatomic) IBOutlet UILabel *lbl_fri;
@property (strong, nonatomic) IBOutlet UILabel *lbl_sat;

@property (strong, nonatomic) IBOutlet UISwitch *switch_takeAttendance;
@property (weak, nonatomic) IBOutlet UILabel *lbl_blueheader;
@property (strong, nonatomic) IBOutlet UITextField *text_blueheader;

@end

@implementation CourseManagerPeriodDetails
{
    UIPickerView *selectcustomerpicker;
     NSMutableArray *array_forpicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata];
    [self dodesigns:self.view_blue_sub];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    
}
-(void)loaddata
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        });
    });
    
    
}
-(IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dodesigns:(UIView *)view_design
{
    [view_design.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    [view_design.layer setBorderWidth:1.0f];
    [view_design.layer setCornerRadius:2.0f];
    view_design.clipsToBounds = YES;
}

-(void)loaddata1
{
    // NSString *inbox=@"inbox";
    
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/course_manager.php?staff_id=2&school_id=1&syear=2015&mp_id=17&view_type=subject&subject_id=&course_id=&cp_id=
    
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/course_manager.php?staff_id=2&school_id=1&syear=2015&mp_id=17&view_type=course&subject_id=1&course_id=&cp_id=
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/course_manager.php?staff_id=2&school_id=1&syear=2015&mp_id=17&view_type=period&subject_id=2&course_id=18&cp_id=
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF = [NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K = [DF objectForKey:@"iphone"];
    NSString *school_id1 = [NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id = [NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    NSString *cp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriod"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/course_manager.php?staff_id=%@&school_id=%@&syear=%@&mp_id=%@&view_type=details&subject_id=%@&course_id=%@&cp_id=%@",STAFF_ID_K,school_id1,year_id,mp_id,self.subject_id, self.course_id,cp_id];
    
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    
    NSString *url12 = [NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
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
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        
        if([str_123 isEqualToString:@"1"])
        {
//            array_subjects = [dictionary1 objectForKey:@"periods"];
//            self.lbl_subtitle.text = [NSString stringWithFormat:@"Period (%lu)", (unsigned long)array_subjects.count];
//            [self.table_v reloadData];
            NSArray *ary = [dictionary1 objectForKey:@"details"];
            NSArray *day = [[[[ary objectAtIndex:0] objectForKey:@"PERIOD_DETAILS"] objectAtIndex:0] objectForKey:@"DAYS_OF_WEEK"];
            
            self.lbl_availabeSeats.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"AVAILABLE_SEATS"]]];
            
            self.lbl_calendar.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"CALENDAR_NAME"]]];
            
            self.lbl_credithour.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"CREDITS"]]];
            
            self.lbl_Duration.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"MP_TITLE"]]];
            
            self.lbl_grading.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"GRADE_SCALE_NAME"]]];
            
            self.lbl_period.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[[[ary objectAtIndex:0] objectForKey:@"PERIOD_DETAILS"] objectAtIndex:0] objectForKey:@"PERIOD_NAME"]]];
            
            self.lbl_primaryTeacher.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"PRIMARY_TEACHER"]]];
            
            self.lbl_scheduletype.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"SCHEDULE_TYPE"]]];
            
            self.lbl_seats.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"TOTAL_SEATS"]]];
            
            self.lbl_shrtname.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"SHORT_NAME"]]];
            
            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:0] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_sun setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_sun setTextColor:[UIColor grayColor]];
            }
            
            
//            self.lbl_mon.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:1] objectForKey:@"status"]]];
            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:1] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_mon setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_mon setTextColor:[UIColor grayColor]];
            }

            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:2] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_tue setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_tue setTextColor:[UIColor grayColor]];
            }

            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:3] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_wed setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_wed setTextColor:[UIColor grayColor]];
            }

            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:4] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_thu setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_thu setTextColor:[UIColor grayColor]];
            }

            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:5] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_fri setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_fri setTextColor:[UIColor grayColor]];
            }

            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[day objectAtIndex:6] objectForKey:@"status"]]] isEqualToString:@"1"]) {
                [self.lbl_sat setTextColor:[UIColor orangeColor]];
            }
            else
            {
                [self.lbl_sat setTextColor:[UIColor grayColor]];
            }

            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[[[ary objectAtIndex:0] objectForKey:@"PERIOD_DETAILS"] objectAtIndex:0] objectForKey:@"DOES_ATTENDANCE"]]] isEqualToString:@"Y"]) {
                [self.switch_takeAttendance setOn:YES];
            }
            else
            {
                [self.switch_takeAttendance setOn:NO];
            }
            
            if ([[self nullChecker:[NSString stringWithFormat:@"%@",[[ary objectAtIndex:0] objectForKey:@"DOES_BREAKOFF"]]] isEqualToString:@"Y"]) {
                [self.switch_teacherGradebookScale setOn:YES];
            }
            else
            {
                [self.switch_teacherGradebookScale setOn:NO]    ;
            }
            
            
            
            
           
                       
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

#pragma mark - null Check korar



-(void)fetchdata
{
    
    ip_url *obj=[[ip_url alloc]init];
    NSString*  ip=[obj ipurl];
    // NSLog(@"%@",ip);
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    
    NSString *usernamr=[df objectForKey:@"u"];
    NSString *paa=[df objectForKey:@"p"];
    NSString *pro=[df objectForKey:@"pro"];
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/teacher_info.php?username=%@&password=%@&profile=%@",usernamr,paa,pro];
    //  NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",ip,str_checklogin];
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSMutableDictionary* dic_techinfo = (NSMutableDictionary *)responseObject;
        // NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"success"]];
        //  NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            //   NSLog(@"uuuuuu====%@",dic_techinfo);
            lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
            
            //missing attendence count ////
            NSString *str_missing_attendence=[NSString stringWithFormat:@"%@",lbl_hidden.text];
            if ([str_missing_attendence isEqualToString:@"0"]) {
                
            }
            
            else
            {
                
                //  [self droptable];
            }
            
            
            notofi.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"notification_count"]];
            NSString *str_count=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            if ([str_count isEqualToString:@"0"]) {
                msg_count_tab.hidden=YES;
                msg_count.hidden=YES;
            }
            else
            {
                msg_count_tab.hidden=NO;
                msg_count.hidden=NO;
                
                msg_count_tab.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
                msg_count.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            }
        }
        
        
        else
        {
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
            //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            //  [alert show];
            
            //  transparentView.hidden=NO;
            // NSLog(@"ok----");
            //[self.view addSubview:transparentView];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
    
    
    
    
    
    
    
    
    
    
    
}



- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}

#pragma mark - picker
-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag =  60;
    self.text_blueheader.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.text_blueheader.inputAccessoryView = mypickerToolbar;
    
}


-(void)pickerDoneClicked1
{
    [self.text_blueheader resignFirstResponder];
//    AppDelegate *appdel = (AppDelegate*)[[UIApplication sharedApplication]delegate] ;
//    NSMutableDictionary *dic = [appdel.dic mutableCopy];
//    [dic setObject:str_selectedgroupID forKey:@"UserMP"];
//    appdel.dic = [dic mutableCopy];
//    [self loaddata];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        return array_forpicker.count;
        
    }
    return 0;
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        return [[array_forpicker objectAtIndex:row] objectForKey:@"title"];
    }
    
    return nil;
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        self.text_blueheader.text =(NSString*)[[array_forpicker objectAtIndex:row] objectForKey:@"title"];
        //str_selectedgroupID = (NSString*)[[array_quaters objectAtIndex:row] objectForKey:@"id"];
    }
    
}
#pragma mark - Tabbar

-(IBAction)home:(id)sender
{
    
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    // NSLog(@"dic===========%@",dic);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    // vc.dic=dic;
    //vc.dic_techinfo=dic_techinfo;
    // appDelegate.dic=dic;
    //   appDelegate.dic_techinfo=dic_techinfo;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
    
}
-(IBAction)thirdButton:(id)sender
{
    NSLog(@"Third Button");
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"msg" bundle:nil];
    msg1*obj = [sb instantiateViewControllerWithIdentifier:@"msg1"];
    [self.navigationController pushViewController:obj animated:YES];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings"bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}


@end
