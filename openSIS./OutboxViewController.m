//
//  TeacherDashboardViewController.m
//  openSiS
//
//  Created by EjobIndia on 17/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "AppDelegate.h"
#import "P_mailview.h"
#import "takeattendance.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "CellTableViewCell1.h"
#import "attendencedetail.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "P_msg1.h"
#import "TableViewCell.h"
#import "P_MessageGroupController.h"
#import "SlideViewController.h"
#import "P_composeViewController.h"
#import "OutboxViewController.h"
#import "P_trash1.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "TeacherDashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_composeViewController.h"
#import "P_SettingViewController.h"
#import "OutboxViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "Msg_compose_ViewController.h"
#import "MsgViewController.h"
#import "Msgcell.h"
#import "MsgvwViewController.h"
#import "S_TrashViewController.h"
#import "S_msg_groupViewController.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"


@interface OutboxViewController()
{
    
    NSString    *staff_id_d,*   marking_period_type;
    NSString *term_flag;
    BOOL y1,t1,su1,co,cp;
    SlideViewController *slide;
    NSMutableArray *cellindex;
    
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    
}
@property (strong, nonatomic)NSString *view_select;
@property (strong, nonatomic) IBOutlet UIView *view_currentSchool;
@property (strong, nonatomic) IBOutlet UIView *view_schoolyear;
@property (strong, nonatomic) IBOutlet UIView *view_subject;
@property (strong, nonatomic) IBOutlet UIView *view_courseperiod;
@property (strong, nonatomic) IBOutlet UIView *view_course;
@property (strong, nonatomic) IBOutlet UIView *view_term;
@property (strong, nonatomic) IBOutlet UIView *view_coursePeriodName;
@property (strong, nonatomic) IBOutlet UIView *view_topblue;
@property (strong, nonatomic) IBOutlet UIView *view_topgrey;
- (IBAction)save:(id)sender;
- (IBAction)back:(id)sender;

//////////////////////////////////sidebarlabels

@property (strong, nonatomic) IBOutlet UILabel *lbl_currenschool;
@property (strong, nonatomic) IBOutlet UILabel *lbl_schoolyear;
@property (strong, nonatomic) IBOutlet UILabel *lbl_term;
@property (strong, nonatomic) IBOutlet UILabel *lbl_subject;
@property (strong, nonatomic) IBOutlet UILabel *lbl_course;
@property (strong, nonatomic) IBOutlet UILabel *lbl_courseperiod;
@property (strong, nonatomic) IBOutlet UIButton *btn_ok;
@property (strong, nonatomic) IBOutlet UILabel *lbl_logout;

////////////////////////////////////
@property (strong, nonatomic) IBOutlet UILabel *lbl_takeattendance;
@property (strong, nonatomic) IBOutlet UIButton *btn_save;




@end

@implementation OutboxViewController
@synthesize dic,img_profile,data12,ary_data1;
@synthesize staff_id,str_date,cpv_id,arr_data,stu_id,atten_code,dic_techinfo;
@synthesize STR_TITLE;
@synthesize s_lbl;
@synthesize view_select;

@synthesize  school_id,school_year1,str_term1,str_sub1,str_cou1,str_cp1;
@synthesize  school_name,school_year_name,school_term,school_sub,school_course,school_courseperiod,school_courseperiodname;
-(void)loaddata
{
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    mtable.hidden=NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        });
    });
    
    
}
-(void)viewonload
{
    
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/compose_mail_view.php?staff_id=2&school_id=1&syear=2015&mp_type=QTR&mp_id=16&action_type=&mail_id=
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *MARKING_PERIOD_TYPE=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"marking_period_type"]];
    NSString *MARKING_PERIOD_ID=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/compose_mail_view.php?staff_id=%@&school_id=%@&syear=%@&mp_type=%@&mp_id=%@",STAFF_ID_K,school_id1,year_id,MARKING_PERIOD_TYPE,MARKING_PERIOD_ID];
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
        NSLog(@"ONLOAD is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        /* NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
         NSLog(@"str_123-----%@",str_123);
         if([str_123 isEqualToString:@"1"])
         
         
         
         {
         [self loaddata];
         
         //self.ary_data1=[dictionary1 objectForKey:@"group_info"];
         [mtable reloadData];
         }
         
         
         else
         {
         //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
         lbl_show.hidden=NO;
         mtable.hidden=YES;
         //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
         //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
         // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         // [alert show];
         
         
         
         }*/
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        transparentView.hidden=NO;
        NSLog(@"ok----");
        [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    
    
    
    
    
    
}


- (IBAction)action_DeleteMembers:(id)sender {
    // [self calldelete];
    
    NSLog(@"selected array: %@", cellindex);
    member_ids = @"" ;
    for (int i = 0; i < cellindex.count; ++i) {
        NSInteger k1 = [[cellindex objectAtIndex:i] integerValue];
        member_ids = [member_ids stringByAppendingString:[[self.ary_data1 objectAtIndex:k1] objectForKey:@"MAIL_ID"]];
        
        if (i + 1 !=cellindex.count) {
            member_ids = [member_ids stringByAppendingString:@","];
        }
    }
    NSLog(@"memberID list: %@",member_ids);
    
    [self calldelete];
}

- (void)calldelete
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(trashdata) withObject:nil afterDelay:1.0];
        });
    });
    
}




-(void)trashdata
{
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/trash.php?staff_id=2&school_id=1&syear=2015&view=inbox&mail_ids=10
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_trash.php?student_id=%@&school_id=%@&syear=%@&view=sentmail&mail_ids=%@",student_id,s_year_id,s_year,member_ids];    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
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
        //  NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        //    NSLog(@"str_123-----%@",str_123);
        //  if([str_123 isEqualToString:@"1"])
        
        
        
        //  {
        //[self loaddata];
        [cellindex removeAllObjects];
        //self.ary_data1=[dictionary1 objectForKey:@"group_info"];
        [mtable reloadData];
        //   }
        
        
        //  else
        //  {
        //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
        //     lbl_show.hidden=NO;
        //    mtable.hidden=YES;
        //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
        //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
        // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        // [alert show];
        
        
        
        //  }
        
        // [self loaddata];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        transparentView.hidden=NO;
        NSLog(@"ok----");
        [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}





-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



-(IBAction)compose:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    Msg_compose_ViewController *msgcm=[[Msg_compose_ViewController alloc]init];
    msgcm=[sb instantiateViewControllerWithIdentifier:@"msgcompose"];
    [self.navigationController pushViewController:msgcm animated:YES];
}



-(IBAction)alertOK:(id)sender
{
    transparentView.hidden = TRUE;
    [transparentView removeFromSuperview];
}




-(void)dateandweek
{
    
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:str_date];
    
    
    [formatter setDateFormat:@"EEEE - MMMM dd, yyyy"];
    NSString *output = [formatter stringFromDate:date];
    
    
    lbl_date.text = output;
    show_title.text=STR_TITLE;
    
    
    
    
}

-(void)searchbox
{
    
    
    
    
    
}

-(void)loaddata1
{
    // NSString *inbox=@"inbox";
    view_select=@"sentmail";
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    //NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_message_inbox.php?student_id=%@&school_id=%@&syear=%@&view=%@",student_id,s_year_id,s_year,view_select];

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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            self.ary_data1=[dictionary1 objectForKey:@"mail_data"];
            [mtable reloadData];
            
            
            
        }
        
        
        else
        {
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            lbl_show.hidden=NO;
            mtable.hidden=YES;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        transparentView.hidden=NO;
        NSLog(@"ok----");
        [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}
-(void)loaddata123
{
    
    [self.atten_code removeAllObjects];
    [self.data12 removeAllObjects];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/take_attendance_view.php?school_id=%@&staff_id=%@&cpv_id=%@&date=%@",school_id123456,staff_id,s_lbl.text,str_date];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            self.btn_save.hidden=NO;
            mtable.hidden=NO;
            atten_id=[[NSMutableArray alloc]init];
            self.ary_data1=[[NSMutableArray alloc]init];
            NSMutableArray  *aty=[[NSMutableArray alloc]init];
            self.ary_data1=[dictionary1 objectForKey:@"students"];
            self.data12=[[dictionary1 objectForKey:@"students"]mutableCopy ];
            aty=[dictionary1 objectForKey:@"attendance_code"];
            
            NSLog(@"aty---%@",aty);
            if ([aty count]>0) {
                for (int i = 0; i<[aty count]; i++) {
                    NSDictionary *dic9 = [aty objectAtIndex:i];
                    //[course_title addObject:[dic9 objectForKey:@"SHORT_NAME"]];
                    [atten_id addObject:[dic9 objectForKey:@"ID"]];
                    [state_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
                    
                }
                NSLog(@"courese_title----%@",course_title);
            }
            
            for (int i=0; i<[data12 count]; i++) {
                
                NSDictionary *dic9 = [data12 objectAtIndex:i];
                [self.arr_data addObject:[dic9 objectForKey:@"STATE_CODE"]];
                [arr_data_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
                [self.stu_id addObject:[dic9 objectForKey:@"STUDENT_ID"]];
                [self.atten_code addObject:[dic9 objectForKey:@"ATTENDANCE_CODE"]];
            }
            [mtable reloadData];
            //            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"conf_msg"]];
            //
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            //            [alert show];
            //
            //
            //            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            //            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
            //
            //
            //            [self.navigationController pushViewController:vc animated:NO];
            
        }
        
        
        else
        {
            lbl_show.hidden=NO;
            mtable.hidden=YES;
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            //            [alert show];
            
            lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        transparentView.hidden=NO;
        NSLog(@"ok----");
        [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self loaddata];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"dic---%@",dic);
    //[self viewonload];
    view_select=@"sentmail";
    
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.layer.borderColor=[[UIColor lightGrayColor]CGColor ];
    _view_coursePeriodName.clipsToBounds = YES;
    courseperiodName.text=@"Outbox";
    cellindex=[[NSMutableArray alloc]init];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
    // dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    
    
    NSLog(@"dic===========%@----term-----%@-------sub------%@----course---%@",dic,appDelegate.dic_term,appDelegate.dic_sub,appDelegate.dic_course);
    
    NSMutableArray *INFO1=[[NSMutableArray alloc]init];
    INFO1=[dic_techinfo objectForKey:@"tech_info"];
    
    
    staff_id_d=[[INFO1 objectAtIndex:0]objectForKey:@"STAFF_ID"];
    // [self loaddata];
    [self droptable];
    [self  atten_data];
    [self dateandweek];
    [self loadcaleder];
    arr_data_code=[[NSMutableArray alloc]init];
    state_code=[[NSMutableArray alloc]init];
    
    self.ary_data1=[[NSMutableArray alloc]init];
    self.stu_id=[[NSMutableArray alloc]init];
    self.atten_code=[[NSMutableArray alloc]init];
    self.arr_data=[[NSMutableArray alloc]init];
    course_title=[[NSMutableArray alloc]init];
    c_school=[[NSMutableArray alloc]init];
    school_year=[[NSMutableArray alloc]init];
    marking_period=[[NSMutableArray alloc]init];
    subject_ary=[[NSMutableArray alloc]init];
    course_ary=[[NSMutableArray alloc]init];
    course_period_ary=[[NSMutableArray alloc]init];
    course_period_title=[[NSMutableArray alloc]initWithObjects:@"Inbox",@"Groups",@"Trash",@"Compose", nil];
    [self courseperiod123];
    [self courseperiodname];
    
    [self tabledata];
    
    
    
    // Do any additional setup after loading the view.
    
    //[table addGestureRecognizer:tapmainview];
    //newView.userInteractionEnabled = NO;
    
    
    [labelView setFrame:CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, self.view.frame.size.width, 0)];
    labelView.backgroundColor = [UIColor redColor];
    
    flag =0;k=0;z=0;change =0;
    
    if (self.view.frame.size.height == 568) {
        incdecheight = 30;
    }
    else if (self.view.frame.size.height == 667)
    {
        incdecheight = 35;
    }
    else if (self.view.frame.size.height == 736)
    {
        incdecheight = 39;
    }
    
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"msg1"];
    
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    
    
}

-(void)open
{
    [slide open:self.view];
}
-(void)close
{
    [slide close:nil];
}


-(void)loadcaleder
{
    
    datePicker1 = [[UIDatePicker alloc] init];
    
    datePicker1.datePickerMode =UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(click_calender:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    txt_click_calender.inputView = datePicker1;
    // Set UITextfield's inputAccessoryView as UIToolbar
    txt_click_calender.inputAccessoryView = datePickerToolbar1;
    
}
-(IBAction)dismissPicker1:(id)sender

{
    //  str_hidden_date= [formatter1 stringFromDate:selectedDate];
    //   NSLog(@"date------%@",str_hidden_date);
    
    mtable.hidden=YES;
    [self.data12 removeAllObjects];
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata123) withObject:nil afterDelay:2];
        });
    });
    
    [txt_click_calender  resignFirstResponder];
    
}


-(IBAction)click_calender:(id)sender
{
    NSDate *selectedDate = datePicker1.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEEE - MMMM dd, yyyy"];
    [lbl_date setText:[df stringFromDate:selectedDate]];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    // str_hidden_date= [formatter1 stringFromDate:selectedDate];
    str_date= [formatter1 stringFromDate:selectedDate];
    //    NSLog(@"date------%@",str_hidden_date);
    //
    //    mtable.hidden=YES;
    //    [self.data12 removeAllObjects];
    //    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //            [self performSelector:@selector(loaddata123) withObject:nil afterDelay:2];
    //        });
    //    });
    //
    //
    
    
    
}
#pragma mark

-(IBAction)goup:(id)sender
{
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5f animations:^{
            //            _view_topgrey.frame =
            //            CGRectMake(_view_topgrey.frame.origin.x,
            //                       _view_topgrey.frame.origin.y - incdecheight,
            //                       _view_topgrey.frame.size.width,
            //                       _view_topgrey.frame.size.height);
            _view_topblue.frame =
            CGRectMake(_view_topblue.frame.origin.x,
                       _view_topblue.frame.origin.y - incdecheight,
                       _view_topblue.frame.size.width,
                       _view_topblue.frame.size.height);
            mtable.frame =
            CGRectMake(mtable.frame.origin.x,
                       mtable.frame.origin.y - incdecheight ,
                       mtable.frame.size.width,
                       mtable.frame.size.height + incdecheight);
        }];
        flag = 1;
        
    }
}

-(IBAction)godown:(id)sender
{
    if (flag == 1) {
        [UIView animateWithDuration:0.5f animations:^{
            //            _view_topgrey.frame =
            //            CGRectMake(_view_topgrey.frame.origin.x,
            //                       _view_topgrey.frame.origin.y + incdecheight,
            //                       _view_topgrey.frame.size.width,
            //                       _view_topgrey.frame.size.height);
            _view_topblue.frame =
            CGRectMake(_view_topblue.frame.origin.x,
                       _view_topblue.frame.origin.y + incdecheight,
                       _view_topblue.frame.size.width,
                       _view_topblue.frame.size.height);
            mtable.frame =
            CGRectMake(mtable.frame.origin.x,
                       mtable.frame.origin.y + incdecheight,
                       mtable.frame.size.width,
                       mtable.frame.size.height- incdecheight);
            
        }];
        flag = 0;
        
    }
    
}

-(void)setoffforscroll:(float)y
{
    if (y > z && z == 0) {
        k = 1;
        z = y;
    }
    else if ( y > z && change == 0 )
    {
        k=0;
        z = y;
    }
    else if ( y > z && change == 1 )
    {
        k=1;
        z = y;
    }
    else if (y < z )
    {
        change = 1;
        k = -1;
        z = y;
    }
    else if ( y < z)
    {
        k = 0;
        z = y;
    }
    
    //    else if (y == 0) {
    //        k = -1;
    //        z = y;
    //    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    
    [self setoffforscroll:scrollView.contentOffset.y];
    
    
    
    
    if (k == 1) {
        [self goup:nil];
        
    }
    else if ( k == -1 ){
        [self godown:nil];
        
    }
    
    //NSLog(@"x offset:  %f", scrollView.contentOffset.x);
    //NSLog(@"y offset:  %f", scrollView.contentOffset.y);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == courseperiodName) {
        [courseperiodName resignFirstResponder];
        
    }
    
    return YES;
}
-(void)droptable{
    
    [msg_count sizeToFit];
    [notofi sizeToFit];
    [msg_count_tab sizeToFit];
    lbl_notification1.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
    
    lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
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
    NSLog(@"lbl___---%@",lbl_hidden.text);
}





-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    coursePeriod.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    coursePeriod.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}
-(void)pickerDoneClicked1
{
    courseperiodName.text=inbox_data;
    [courseperiodName resignFirstResponder];
    if ([term_flag isEqualToString:@"1"]) {
        if ([inbox_data isEqualToString:@"Inbox"]) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
            MsgViewController*msgvc = [sb instantiateViewControllerWithIdentifier:@"msg"];
            [self.navigationController pushViewController:msgvc animated:NO];
            
        }
        
        else    if ([inbox_data isEqualToString:@"Trash"]) {
            
            
            
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
            S_TrashViewController *msgcm=[[S_TrashViewController alloc]init];
            msgcm=[sb instantiateViewControllerWithIdentifier:@"strash"];
            [self.navigationController pushViewController:msgcm animated:YES];
            
            
            
            
            
        }
        
        else  if ([inbox_data isEqualToString:@"Groups"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
            S_msg_groupViewController *mgc = [sb instantiateViewControllerWithIdentifier:@"groupp"];
            [self.navigationController pushViewController:mgc animated:YES];
        }
        
        else
        {
            
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
            Msg_compose_ViewController *msgcm=[[Msg_compose_ViewController alloc]init];
            msgcm=[sb instantiateViewControllerWithIdentifier:@"msgcompose"];
            [self.navigationController pushViewController:msgcm animated:NO];
            
        }
        
        
    }
    else
    {
        
        courseperiodName.text=@"Outbox";
        
    }
    
    
    
    
    
    
}



-(void)labelborderset:(UILabel*)lbl1
{
    
    lbl1.layer.borderWidth=4.0f;
    lbl1.layer.borderColor=[UIColor clearColor].CGColor;
    lbl1.layer.cornerRadius=2.0f;
    
    lbl1.clipsToBounds=YES;
    
    
}

-(void)pickerDoneClicked12
{
    
    [txt_shorting resignFirstResponder];
    
}
-(void)courseperiodname
{
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    courseperiodName.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    courseperiodName.inputAccessoryView = mypickerToolbar;
    
    
}



-(void)atten_data
{
    
    
    
    
    
    
    
    /*  if ([course_ary count]>0) {
     course_title = [[NSMutableArray alloc] init];
     course_id= [[NSMutableArray alloc] init];
     for (int i = 0; i<[course_ary count]; i++) {
     NSDictionary *dic15 = [course_ary objectAtIndex:i];
     [course_title  addObject:[dic15 objectForKey:@"title"]];
     [course_id addObject:[dic15 objectForKey:@"id"]];
     
     }
     
     }
     else {
     NSLog(@"No  list");
     }
     
     NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
     NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCourse"]];
     NSLog(@"%@",strt);
     
     NSLog(@"course ary----%@",course_ary);
     for (int i=0; i<[course_ary count]; i++) {
     
     
     if ([strt isEqual:[[course_ary  objectAtIndex:i]objectForKey:@"id"]]) {
     dic16=[course_ary objectAtIndex:i];
     
     NSLog(@"dic16---%@",dic16);
     
     course.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
     }
     
     else
     {
     course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
     
     }
     
     }*/
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=5;
    course.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    course.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}






- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    
    
    return course_period_title.count;
    
    
    
    
    
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return [course_period_title objectAtIndex:row];
    
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    
    
    
    
    inbox_data =(NSString *)[course_period_title objectAtIndex:row];
    
    
    courseperiodName.text=inbox_data;
    
    
    term_flag=@"1";
    
    
    
}


-(IBAction)save:(id)sender
{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(savedata) withObject:nil afterDelay:2];
        });
    });
    
    
    
}



#pragma mark - SAVEDATA

-(void)savedata
{
    
    if (self.data12.count==0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"No Data Found" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }
    
    else
    {
        
        NSMutableArray *INFO=[[NSMutableArray alloc]init];
        INFO=[dic_techinfo objectForKey:@"tech_info"];
        
        CURRENT_SCHOOL_ID=[[INFO objectAtIndex:0]objectForKey:@"CURRENT_SCHOOL_ID"];
        staff_id=[[INFO objectAtIndex:0]objectForKey:@"STAFF_ID"];
        SYEAR=[[INFO objectAtIndex:0]objectForKey:@"SYEAR"];
        NSMutableArray *INFO1=[[NSMutableArray alloc]init];
        INFO1=[dic_techinfo objectForKey:@"tech_info"];
        
        
        staff_id=[[INFO1 objectAtIndex:0]objectForKey:@"STAFF_ID"];
        NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
        NSLog(@"%@",strt);
        NSMutableDictionary *dict;
        NSMutableArray*arrData=[[NSMutableArray alloc]init];
        
        NSLog(@"VALUE IS---%@",self.data12);
        for (int i=0; i<self.data12.count; i++) {
            dict=[[NSMutableDictionary alloc]init];
            
            NSString *id_student=[self.stu_id objectAtIndex:i];
            NSString *attendece_code=[self.atten_code objectAtIndex:i];
            
            
            
            
            
            // [AFJSONResponseSerializer serializer];
            [dict setValue:id_student forKey:@"student_id"];
            [dict setValue:attendece_code forKey:@"attendance_code"];
            
            NSLog(@"%@",dict);
            [arrData addObject:dict];
        }
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
        NSString * str111 = [Base64 encode:data];
        str111=[arrData JSONRepresentation];
        
        NSLog(@"----String To Post To Server ---%@",str111);
        
        ip_url *obj123=[[ip_url alloc]init];
        NSString *str123=[obj123 ipurl];
        
        NSString *post = [NSString stringWithFormat:@"student_attendanceArr=%@",str111];
        
        NSLog(@"post = %@",post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
        //NSString *urlStr = [NSString stringWithFormat:@"http://localhost/tanay/customer_information.php?id=%d",[self.strCustomer_ID  intValue]];
        NSString *urlStr = [NSString stringWithFormat:@"/save_attendance.php?staff_id=%@&cpv_id=%@&mp_id=%@&date=%@",staff_id,s_lbl.text,str_term1,str_date];
        
        NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
        
        NSLog(@"----%@",url12);
        [request setURL:[NSURL URLWithString:url12]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSError *error;
        NSURLResponse *response;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        // NSLog(@"url Data.....%@",urlData);
        
        NSString *retVal=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        retVal = [retVal stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSLog(@"retval...%@",retVal);
        
        NSDictionary *dicvv=[retVal JSONValue];
        NSString *str_msg=[NSString stringWithFormat:@"%@",[dicvv objectForKey:@"information"]];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        
        
        
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        //    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"atten"];
        //
        //    [self.navigationController pushViewController:vc animated:NO];
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
        vc.dic=dic;
        vc.dic_techinfo=dic_techinfo;
        
        
        [self.navigationController pushViewController:vc animated:NO];
        
        
    }
    
    
    
}


-(void)tabledata
{
    
    mtable.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
}


#pragma mark SideBarOpenFunction

-(IBAction)click:(id)sender
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField !=courseperiodName && textField !=term && textField != currentSchool && textField != schoolYear && textField != subject && textField != course) {
        [self animateTextField:coursePeriod up:NO];
    }
    
    
}


#pragma mark Tabbar
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
    [self.navigationController pushViewController:mvc animated:NO];}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}


-(IBAction)ok:(id)sender
{
    NSLog(@"Ok pressed");
    [self close:nil];
}

-(IBAction)logout:(id)sender
{
    NSLog(@"Logout button pressed");
    // [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.ary_data1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [mtable deselectRowAtIndexPath:indexPath animated:YES];
    // MAIL_ID
    
    NSString *str_mail_id=[NSString stringWithFormat:@"%@",[[self.ary_data1 objectAtIndex:indexPath.row]objectForKey:@"MAIL_ID"]];
    
    NSLog(@"----------");
    UIStoryboard *s1=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
    P_mailview *obj=[s1 instantiateViewControllerWithIdentifier:@"p_mail"];
    obj.MAIL_ID=str_mail_id;
    obj.view_select=view_select;
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
    
    
}

-(void)syncButtonAction:(UIButton*)sender{
    NSLog(@"kkdkkf");
    
    UIButton *targetButton = (UIButton *)sender;
    NSString *str4=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSLog(@"heloooo__%@",str4);
    if([cellindex containsObject:str4]){
        [targetButton setSelected:NO];
        
        //        [arry_total removeObject:[mdcnary objectAtIndex:sender.tag]];
        //        [arry_total1 removeObject:[genrcary objectAtIndex:sender.tag]];
        //        [arry_total2 removeObject:[descrptnary objectAtIndex:sender.tag]];
        
        [cellindex removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        NSLog(@"Count of arr selected %@",cellindex);
        
        [sender setBackgroundImage:[UIImage imageNamed:@"uncheckbox"]
                          forState:UIControlStateNormal];
    }
    else{
        [targetButton setSelected:YES];
        NSLog(@"caslllllaaaa %ld",(long)sender.tag);
        //strw=[NSString stringWithFormat:@"%d",sender.tag];
        
        //        [arry_total addObject:[mdcnary objectAtIndex:sender.tag]];
        //        [arry_total1 addObject:[genrcary objectAtIndex:sender.tag]];
        //        [arry_total2 addObject:[descrptnary objectAtIndex:sender.tag]];
        
        
        [cellindex addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        NSLog(@"Count of arr unselect %@",cellindex);
        [sender setBackgroundImage:[UIImage imageNamed:@"checkbox"]
                          forState:UIControlStateNormal];
        
        
    }
    
}


- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (TableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] objectAtIndex:0];
   	}
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    // cell.BackgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_green.png"]];
    
    //    if (tableView
    
    //    {
    
    
    NSString *str_date_value=[NSString stringWithFormat:@"%@",[[self.ary_data1 objectAtIndex:indexPath.row]objectForKey:@"MAIL_DATE"]];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy-mm-dd"];
    NSDate *datefor=[dateformat dateFromString:str_date_value];
    [dateformat setDateFormat:@"dd MMM"];
    NSString *dateStr=[dateformat stringFromDate:datefor];
    
    cell.date1.text=dateStr;
    
    cell.name.text=[NSString stringWithFormat:@"%@",[[self.ary_data1 objectAtIndex:indexPath.row]objectForKey:@"FROM_USER"]];
    
    cell.msg1.text=[NSString stringWithFormat:@"%@",[[self.ary_data1 objectAtIndex:indexPath.row]objectForKey:@"MAIL_SUBJECT"]];
    
    cell.name.backgroundColor = [UIColor clearColor];
    
    //cell.show.tag = indexPath.row;
    //[button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
    // UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
    // [cell.show setBackgroundImage:[UIImage imageNamed:@"checkbox.png"]
    // forState:UIControlStateHighlighted];
    
    UIButton *show1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    show1.frame = CGRectMake(12.0f, 21.0f, 32.0f, 32.0f);
    [show1 setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"]
                     forState:UIControlStateNormal];
    [show1 setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    
    
    show1.tag = indexPath.row;
    [show1 addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.contentView addSubview:show1];
    
    NSString *str4=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"heloooo__%@",str4);
    if([cellindex containsObject:str4])
        
        
    {
        NSLog(@"checkkk");
        [show1 setBackgroundImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    }
    else {
        NSLog(@"uncheckkk");
        [show1 setBackgroundImage:[UIImage imageNamed:@"uncheckbox"] forState:UIControlStateNormal];
        //}
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        // [cell.show addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
    
    
}


-(IBAction)atten1:(UIButton*)sender
{
    
    UIButton *button = sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    selectedIndexpath= indexPath.row;
    //    UIView *view123=[[UIView alloc]init];
    //    view123.frame=CGRectMake(0, 0, 200, 100);
    //    view123.backgroundColor=[UIColor redColor];
    CGPoint midpoint;
    midpoint.x = super.view.frame.size.width / 2;
    midpoint.y = super.view.frame.size.height / 2;
    view1236.center = CGPointMake(midpoint.x, midpoint.y);
    
    view1236.hidden=NO;
    [self.view addSubview:view1236];
    
    NSLog(@"---------");
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 68.0f;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*if (indexPath.row%2 == 0) {
     
     [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0f]];
     }else
     {
     
     
     UIColor *color1=[UIColor colorWithRed:244.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0f];
     cell.contentView.backgroundColor=color1;
     }*/
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


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
