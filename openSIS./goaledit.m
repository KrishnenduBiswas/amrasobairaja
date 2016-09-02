//
//  MyInformationCertification.m
//  openSiS
//
//  Created by os4ed on 1/11/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//
#import "AdvancedStudentScheduleController.h"
#import "Student.h"
#import "TeacherDashboardViewController.h"
#import "SettingsMenu.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "Advancedstd.h"
#import "MystdInformationGeneral.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import <MapKit/MapKit.h>
#import "mapkitViewController.h"
#import "MyInformationAddress.h"
#import "MyInformationCertification.h"
#import "MyInformationSchoolInfo.h"
#import "TeacherDashboardViewController.h"
#import "SettingsMenu.h"
#import "goal.h"
#import "MyInformationCertification.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "parents.h"
#import "TeacherDashboardViewController.h"
#import "MyInformationAddress.h"
#import "MyInformationGeneral.h"
#import "MyInformationSchoolInfo.h"
#import "MyInformationCertificationCell.h"
#import "enroll.h"
#import "comment.h"

#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "goaledit.h"
#import "goaledit.h"
#import "stdadd.h"
@interface goaledit()
<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>

{

    NSString  *end_date;
    IBOutlet UILabel *LBL_TITLE;
    IBOutlet UIButton *btn_cancel,*btn_update;
    UIDatePicker *datePicker1,*datePicker2;
    NSString *date_string,*assign_flag;
    int multiheight;
    IBOutlet  UIView *view_info;
    NSString *end_date_flag;
    NSIndexPath *currentIndex;

}
@property (strong, nonatomic) IBOutlet UIView *view_onlongpress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_TopTitle;
@property (weak, nonatomic) IBOutlet UITableView *table_cert;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_menu;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_viewforSegment;
@property (strong, nonatomic) IBOutlet UITextField *date_value;
@property (strong, nonatomic) IBOutlet UITextView *txt_view;
@property (strong, nonatomic) IBOutlet UITextField *GOAL_TITLE;
@property (strong, nonatomic) IBOutlet UIView *VIEW_STARTDATE;
@property (strong, nonatomic) IBOutlet UIView *view_enddate;
@property (strong, nonatomic) IBOutlet UITextField *end_date1;
@property (strong, nonatomic) IBOutlet UILabel *nodatafound;

@end

@implementation goaledit
{
    NSMutableArray *array_cert;
}


- (IBAction)dhongsho:(id)sender {
    
    NSLog(@"Button ta kintu click hocche");
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{


    [textField resignFirstResponder];
    return YES;

}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.view.frame.size.height == 568) {
        multiheight = 32;
    }
    else if (self.view.frame.size.height == 667)
    {
        multiheight = 37;
    }
    else if (self.view.frame.size.height == 736)
    {
        multiheight = 41;
    }
}


#pragma mark - calendar and picker
-(IBAction)dismissPicker1:(id)sender
{
    
   
    if ([assign_flag isEqualToString:@"1"]) {
        
        
        
    //    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
      //  [dateFormatter setDateFormat:@"MMM dd, yyyy"];
      //  NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
      //  NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
       // [formatter1 setDateFormat:@"yyyy-MM-dd"];
        
        
        
        
        
       // date_string=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:[NSDate date]]];
      //  self.date_value.text =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] ;
        

        NSLog(@"date1-------%@",self.date_string);
    }
    
    else
    {
    
       NSLog(@"date2-------%@",self.date_string);
    
    }
   
    [self.date_value resignFirstResponder];
    
    
    
}
#pragma mark - calendar and picker
-(IBAction)dismissPicker12:(id)sender
{
    
    
    if ([end_date_flag isEqualToString:@"1"]) {
        
        
        
        //    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        //  [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        //  NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        //  NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        // [formatter1 setDateFormat:@"yyyy-MM-dd"];
        
        
        
        
        
        // date_string=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:[NSDate date]]];
        //  self.date_value.text =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] ;
        
        
        NSLog(@"date1-------%@",self.end_date);
    }
    
    else
    {
        
        NSLog(@"date2-------%@",self.end_date);
        
    }
    
    [self.end_date1 resignFirstResponder];
    
    
    
}

-(IBAction)click_calender:(id)sender
{
    // NSDate *selectedDate = datePicker1.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy"];
    //[self.text_assigndate setText:[df stringFromDate:selectedDate]];
    //datestr = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker1.date]];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    
self.date_string=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:datePicker1.date]];
    self.date_value.text =[NSString stringWithFormat:@"%@",[df stringFromDate:datePicker1.date]];;
    assign_flag=@"1";
}



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



-(IBAction)click_calender1:(id)sender
{
    // NSDate *selectedDate = datePicker1.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy"];
    //[self.text_assigndate setText:[df stringFromDate:selectedDate]];
    //datestr = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker1.date]];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    
   end_date=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:datePicker2.date]];
    self.end_date1.text =[NSString stringWithFormat:@"%@",[df stringFromDate:datePicker2.date]];;
    end_date_flag=@"1";
}

-(void)loadcalender
{
    
    datePicker1 = [[UIDatePicker alloc] init];
    
    datePicker1.datePickerMode =UIDatePickerModeDate;
    datePicker1.date = [NSDate date];
    [datePicker1 addTarget:self action:@selector(click_calender:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.date_value.inputView = datePicker1;
    
    // Set UITextfield's inputAccessoryView as UIToolbar
    
    self.date_value.inputAccessoryView = datePickerToolbar1;
}



-(void)loadcalender1
{
    
    datePicker2 = [[UIDatePicker alloc] init];
    
    datePicker2.datePickerMode =UIDatePickerModeDate;
    datePicker2.date = [NSDate date];
    [datePicker2 addTarget:self action:@selector(click_calender1:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker12:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.end_date1.inputView = datePicker2;
    
    // Set UITextfield's inputAccessoryView as UIToolbar
    
    self.end_date1.inputAccessoryView = datePickerToolbar1;
}

- (void)dodesignsforTextViews:(UITextView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    disview.clipsToBounds = YES;
}

- (void)dodesignforHeaders:(UIView *)disview
{
    // [disview.layer setBorderColor:[[UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.00f]CGColor]];
    //[disview.layer setBorderWidth:1.0f];
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    
}
- (void)dodesignforHeaders1:(UITextField *)disview
{
    // [disview.layer setBorderColor:[[UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.00f]CGColor]];
    //[disview.layer setBorderWidth:1.0f];
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    
}


-(IBAction)settings:(id)sender
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
}


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

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}


- (IBAction)action_segment:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        //        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]];
        //        MystdInformationGeneral *mia = [storyBoard instantiateViewControllerWithIdentifier:@"MyInformationGeneral"];
        //        [self.navigationController pushViewController:mia animated:YES];
        //        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        //        goal *mia = [storyBoard instantiateViewControllerWithIdentifier:@"goal"];
        //        mia.studentID=self.studentID;
        //        mia.studentName=self.studentName;
        //        [self.navigationController pushViewController:mia animated:YES];
        
        NSLog(@"This Page");
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        enroll*mia = [storyBoard instantiateViewControllerWithIdentifier:@"enroll"];
        mia.studentID=self.studentID;
        mia.studentName=self.studentName;
        [self.navigationController pushViewController:mia animated:NO];
    }
    else if (sender.selectedSegmentIndex == 2)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        stdadd*mia = [storyBoard instantiateViewControllerWithIdentifier:@"stdadd"];
        mia.studentID=self.studentID;
        mia.studentName=self.studentName;
        [self.navigationController pushViewController:mia animated:NO];
        //        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        //        goal *mia = [storyBoard instantiateViewControllerWithIdentifier:@"goal"];
        //        mia.studentID=self.studentID;
        //        mia.studentName=self.studentName;
        //        [self.navigationController pushViewController:mia animated:YES];
        
    }
    else if (sender.selectedSegmentIndex == 3)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        comment *mia = [storyBoard instantiateViewControllerWithIdentifier:@"comment"];
        mia.studentID=self.studentID;
        mia.studentName=self.studentName;
        [self.navigationController pushViewController:mia animated:YES];
    }
    else if (sender.selectedSegmentIndex == 4)
    {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
//        goal *mia = [storyBoard instantiateViewControllerWithIdentifier:@"goal"];
//        mia.studentID=self.studentID;
//        mia.studentName=self.studentName;
//        [self.navigationController pushViewController:mia animated:YES];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
        MystdInformationGeneral *slc = [[MystdInformationGeneral alloc]init];
        slc = [sb instantiateViewControllerWithIdentifier:@"MystdInformationGeneral"];
        
        [self.navigationController pushViewController:slc animated:YES];
    }
    
    
    else
    {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        parents *mia = [storyBoard instantiateViewControllerWithIdentifier:@"parents"];
        mia.studentID=self.studentID;
        mia.studentName=self.studentName;
        [self.navigationController pushViewController:mia animated:YES];
        
    }
    
}

-(IBAction)addcomment:(id)sender
{
    self.date_value.text=@"";
    self.txt_view.text=@"";
    view_upper.hidden=NO;
    self.table_cert.frame=CGRectMake(-18, 380, 340,140);
    btn_add.hidden=YES;
    btn_close.hidden=NO;
    btn_cancel.hidden=YES;
    view_info.hidden=YES;
    [btn_update setTitle:@"Add" forState:UIControlStateNormal];

}

-(IBAction)back:(id)sender
{
    
   // NSArray *ary = [self.navigationController viewControllers];
    
   // [self.navigationController popToViewController:[ary objectAtIndex:3] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    [super viewDidLoad];
    self.segment_menu.selectedSegmentIndex=0;
    self.GOAL_TITLE.text=[self nullChecker:[NSString stringWithFormat:@"%@",self.goal_title]];
    // date_string = [self nullChecker:[NSString stringWithFormat:@"%@",[[array_cert objectAtIndex:sender.tag] objectForKey:@"START_DATE"]]];
    
    self.txt_view.text  = [self nullChecker:[NSString stringWithFormat:@"%@",self.str_txt_view]];
    
    
    NSLog(@"DATE STRING---%@---END STRING------%@",date_string,end_date);
    NSString *str =self.date_string; /// here this is your date with format yyyy-MM-dd
    NSString *str11 =self.end_date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
    NSDate *date1 = [dateFormatter dateFromString: str11];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init] ;
    [dateFormatter1 setDateFormat:@"dd MMM, yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter1 stringFromDate:date]; //here convert date in NSString
    
    
    NSDateFormatter *dateFormatter12 = [[NSDateFormatter alloc] init] ;
    [dateFormatter12 setDateFormat:@"dd MMM, yyyy"];// here set format which you want...
    
    NSString *convertedString1 = [dateFormatter12 stringFromDate:date1];
    NSLog(@"Converted String : %@",convertedString1);
    self.date_value.text=convertedString;
    self.end_date1.text=convertedString1;
    
    
    
    
    
    view_upper.hidden=YES;
    btn_close.hidden=YES;
    [self loadcalender1];
//    self.table_cert.frame=CGRectMake(-18, 96, 340, 400);
    [self loadcalender];
    array_cert = [[NSMutableArray alloc]init];
  //  [self loaddata];
    [self dodesignforHeaders1:self.GOAL_TITLE];
     [self dodesignforHeaders:self.VIEW_STARTDATE];
     [self dodesignforHeaders:self.view_enddate];
    [self dodesignsforTextViews:self.txt_view];
    
    
    [self.scroll_viewforSegment setContentSize:CGSizeMake(self.segment_menu.frame.size.width, self.scroll_viewforSegment.frame.size.height)];
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressed:)];
    longpress.minimumPressDuration = 1.5;
    longpress.delegate = self;
    [self.table_cert addGestureRecognizer:longpress];
    [self.view_onlongpress setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    self.view_onlongpress.opaque = NO;
    
}
-(void)loaddata1
{
    // NSString *inbox=@"inbox";
    // 
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:http://107.170.94.176/openSIS_CE6_Mobile/webservice/teacher_info_tabs.php?staff_id=2&school_id=1&syear=2015@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
   NSString*str_checklogin=[NSString stringWithFormat:@"/student_info.php?staff_id=%@&school_id=%@&syear=%@&student_id=%@",STAFF_ID_K,school_id1,year_id,self.studentID];
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
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"goals_success"]];
        NSLog(@"str_123-----%@",str_123);
        self.lbl_TopTitle.text = [NSString stringWithFormat:@"%@",self.studentName];
        
        
        NSMutableArray *ary_data=[[NSMutableArray alloc]init];
        if([str_123 isEqualToString:@"1"])
        {
            
            self.nodatafound.hidden=YES;
            array_cert = [dictionary1 objectForKey:@"goals"];
            NSLog(@"tanay---%@",ary_data);
            
      //     calendar_name.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"CALENDAR"]] ];
          //  rolling.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"NEXT_SCHOOL"]]];
            
           // array_cert=[[ary_data objectAtIndex:0]objectForKey:@"SCHOOL_INFO"];
            //SCHOOL_INFO
            [self.table_cert reloadData];
        }
        
        
        else
        {
            
            
              self.nodatafound.hidden=NO;
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //   lbl_show.hidden=NO;
            //    mtable.hidden=YES;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(IBAction)cancel:(id)sender
{
    
    
    [self .navigationController popViewControllerAnimated:YES];
}


-(IBAction)view_close:(id)sender
{
    [self.view_onlongpress removeFromSuperview];
}
-(IBAction)close:(id)sender
{
     view_info.hidden=NO;
    self.date_value.text=@"";
    self.txt_view.text=@"";
    self.GOAL_TITLE.text=@"";
    self.end_date1.text=@"";
    view_upper.hidden=YES;
    self.table_cert.frame=CGRectMake(-18,130, 340,419);
    btn_add.hidden=NO;
    btn_close.hidden=YES;
    
}

    
 




- (IBAction)add:(id)sender {
    
    
    
    NSLog(@"hi");
        if ([self.GOAL_TITLE.text length]<1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter goal title" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        else    if ([self.date_value.text length]<1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter begin date" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else    if ([self.end_date1.text length]<1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter end date" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
             

 //   comment_details=[{"cm_text":"test2222","cm_date":"2016-01-12"}]
      
    else
    {
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/student_info.php?staff_id=2&school_id=1&syear=2015&student_id=13&mp_id=17&action_type=submit_comment&comment_details=[{%22cm_text%22:%22test%22,%22cm_date%22:%222016-01-12%22}]
       
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(edit_data) withObject:nil afterDelay:1.0];
        });
    });
    }
    }
    



-(void)add_data
{

//    http://107.170.94.176/openSIS_CE6_Mobile/webservice/student_info.php?staff_id=2&school_id=1&syear=2015&student_id=13&action_type=submit_comment&comment_id=4&comment_details=[{%22cm_text%22:%22test2222%22,%22cm_date%22:%222016-01-12%22}]
    
    
    
   // http://107.170.94.176/openSIS_CE6_Mobile/webservice/student_info.php?staff_id=2&school_id=1&syear=2015&student_id=13&action_type=submit_goal&goal_details=[{"goal_title":"test","goal_begin_date":"2016-01-12","goal_end_date":"2016-01-16","goal_desc":"test"}]
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id12=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
     NSString *mp=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
//    NSString*str_checklogin=[NSString stringWithFormat:@"/student_info.php?staff_id=%@&school_id=%@&syear=%@&student_id=%@",STAFF_ID_K,school_id1,year_id,self.studentID];
//    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    
    NSMutableArray *arry_value=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
    [dic_value setObject:self.GOAL_TITLE.text forKey:@"goal_title"];
    [dic_value setObject:self.date_string forKey:@"goal_begin_date"];
      [dic_value setObject:self.end_date forKey:@"goal_end_date"];
     [dic_value setObject:self.txt_view.text forKey:@"goal_desc"];
    [arry_value addObject:dic_value];
    NSString * str111;// = [Base64 encode:data];
    str111=[arry_value JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
    
    // NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    
  //  NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
  
    
    
    
    //    http://107.170.94.176/openSIS_CE6_Mobile/webservice/send_mail.php?staff_id=2&school_id=1&syear=2015&mail_details=
    
 
    
    NSString *urlStr = [NSString stringWithFormat:@"/student_info.php"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    //
    //    NSLog(@"----%@",url12);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
    // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id12 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"student_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[self.studentID dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"goal_details\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str111 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
  /*  [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[mp dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];*/
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"action_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *stryyy=@"submit_goal";
    [body appendData:[stryyy dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"======%@",returnData);
    //   NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary  *datadic=[[NSMutableDictionary alloc]init];
    datadic = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:NULL];
    NSLog(@"datadic-------%@",datadic);
    
 //   [self alertmsg:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]]];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    [self action_cancel:nil];
    
    self.table_cert.frame=CGRectMake(-18, 92, 340, 420);
   // [self loaddata];
    view_upper.hidden=YES;
    btn_add.hidden=NO;
    btn_close.hidden=YES;

}

-(void)edit_data
{
   
    //    http://107.170.94.176/openSIS_CE6_Mobile/webservice/student_info.php?staff_id=2&school_id=1&syear=2015&student_id=13&action_type=submit_comment&comment_id=4&comment_details=[{%22cm_text%22:%22test2222%22,%22cm_date%22:%222016-01-12%22}]
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
   STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id12=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
   // NSString *mp=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    //    NSString*str_checklogin=[NSString stringWithFormat:@"/student_info.php?staff_id=%@&school_id=%@&syear=%@&student_id=%@",STAFF_ID_K,school_id1,year_id,self.studentID];
    //    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    
    NSMutableArray *arry_value=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
    [dic_value setObject:self.GOAL_TITLE.text forKey:@"goal_title"];
    [dic_value setObject:self.date_string forKey:@"goal_begin_date"];
    [dic_value setObject:self.end_date forKey:@"goal_end_date"];
    [dic_value setObject:self.txt_view.text forKey:@"goal_desc"];
    [arry_value addObject:dic_value];
    NSString * str111;// = [Base64 encode:data];
    str111=[arry_value JSONRepresentation];
    
    
    
    // NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    
    //  NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    
   // http://107.170.94.176/openSIS_CE6_Mobile/webservice/student_info.php?staff_id=2&school_id=1&syear=2015&student_id=13&action_type=submit_comment&comment_id=4&comment_details=[{cm_text:kjkjkjlkjlkjlkj,cm_date:2016-01-12}]
    
    
    //    http://107.170.94.176/openSIS_CE6_Mobile/webservice/send_mail.php?staff_id=2&school_id=1&syear=2015&mail_details=
    
    
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/student_info.php?staff_id=2&school_id=1&syear=2015&student_id=13&action_type=submit_comment&comment_id=15&comment_details=[{"cm_text":"test2222","cm_date":"2016-01-12"}]
   
    
    NSString *urlStr = [NSString stringWithFormat:@"/student_info.php"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    //
    //    NSLog(@"----%@",url12);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
    // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id12 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"student_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[self.studentID dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"goal_details\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str111 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[mp dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"action_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *stryyy=@"submit_goal";
    [body appendData:[stryyy dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"goal_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[self.GOAL_ID dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
   // NSLog(@"======%@",returnData);
    //   NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary  *datadic=[[NSMutableDictionary alloc]init];
    datadic = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:NULL];
   // NSLog(@"datadic-------%@",datadic);
    NSString *succ=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"success"]];
if ([succ isEqualToString:@"1"]) {
        
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
    goal *mia = [storyBoard instantiateViewControllerWithIdentifier:@"goal"];
    
    mia.studentName=self.studentName;
    mia.studentID=self.studentID;
  
    [self.navigationController pushViewController:mia animated:YES];
    
        
   }
else
    {
    }
    //   [self alertmsg:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]]];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //    [self action_cancel:nil];
    
 //   self.table_cert.frame=CGRectMake(-18, 92, 340, 420);
   // [self loaddata];
    //view_upper.hidden=YES;
    // view_header.hidden=NO;
    
}





- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
    }
    
}

#pragma mark - Tabbar



@end
