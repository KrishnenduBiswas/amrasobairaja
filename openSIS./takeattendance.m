//
//  TeacherDashboardViewController.m
//  openSiS
//
//  Created by EjobIndia on 17/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "AppDelegate.h"

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
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface takeattendance()
{

     NSString    *staff_id_d,*   marking_period_type;
    NSString *term_flag;
    BOOL y1,t1,su1,co,cp;

}
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

@implementation takeattendance
@synthesize dic,img_profile,data12,ary_data1;
@synthesize staff_id,str_date,cpv_id,arr_data,stu_id,atten_code,dic_techinfo;
@synthesize STR_TITLE;
@synthesize s_lbl;


@synthesize  school_id,school_year1,str_term1,str_sub1,str_cou1,str_cp1;
@synthesize  school_name,school_year_name,school_term,school_sub,school_course,school_courseperiod,school_courseperiodname;
-(void)loaddata
{
 transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1];
        });
    });


}
   

-(void)term{
    
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=3;
    term.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(termClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    term.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

#pragma MARK SCHOOL
-(void)dropdowndata
{
    
    
    //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin;
    if ([flag123 isEqualToString:@"1"]) {
        
        // http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_school_dropdown.php?school_id=1&staff_id=2
        str_checklogin=[NSString stringWithFormat:@"/manage_school_dropdown.php?school_id=%@&staff_id=%@",school_id1,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        
        str_checklogin=[NSString stringWithFormat:@"/manage_school_dropdown.php?school_id=%@&staff_id=%@",school_id1,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
        
    }
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
        
        dic= (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            school_year1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"SYEAR"]];
            
            
            
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:school_year1 forKey:@"school_year"];
            
            school_year=[[dictionary1 objectForKey:@"Schoolyear_list"]mutableCopy];
            
            if ([school_year count]>0) {
                school_year_title = [[NSMutableArray alloc] init];
                school_year_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[school_year count]; i++) {
                    NSDictionary *dic15 = [school_year objectAtIndex:i];
                    [school_year_title  addObject:[dic15 objectForKey:@"title"]];
                    [school_year_id addObject:[dic15 objectForKey:@"start_date"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            
            NSMutableDictionary *S_YEAR=[[NSMutableDictionary alloc]init];
            NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SYEAR"]];
            NSLog(@"%@",strt);
            
            
            for (int i=0; i<[school_year count]; i++) {
                
                
                if ([strt isEqual:[[school_year  objectAtIndex:i]objectForKey:@"start_date"]]) {
                    S_YEAR=[school_year objectAtIndex:i];
                    
                    
                 //   schoolYear.text=[NSString stringWithFormat:@"%@",[S_YEAR objectForKey:@"title"]];
                    y1=true;
                    break;
                    
                }
                
                else
                {
                    
                    
                  //  schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
                    
                }
                
            }
            
            if (y1==true) {
                 schoolYear.text=[NSString stringWithFormat:@"%@",[S_YEAR objectForKey:@"title"]];
                
                schoolYear.text=[NSString stringWithFormat:@"%@",[S_YEAR objectForKey:@"title"]];
                school_year1=[NSString stringWithFormat:@"%@",[S_YEAR objectForKey:@"start_date"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:school_year1 forKey:@"school_year"];

            }
            
            
            
            else
            {
              
                schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
                school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"start_date"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:school_year1 forKey:@"school_year"];
            }
            
            
            
        }
        
        
        
        
        else
        {
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
           // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
           // [alert show];
            
            
            
        }
        
        
        
       
        
   
     
     
     
     
     
         
    
     [self dropdowndatayear];
     
     

     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}


-(void)dropdowndatayear
{
    //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin;
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_syear_dropdown.php?school_id=1&syear=2015&staff_id=2
    
    if ([flag123 isEqualToString:@"1"]) {
        // NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        
        str_checklogin=[NSString stringWithFormat:@"/manage_syear_dropdown.php?school_id=%@&syear=%@&staff_id=%@",
                        school_id1,school_year12,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_syear_dropdown.php?school_id=%@&syear=%@&staff_id=%@",
                        school_id1,school_year12,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
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
        dic= (NSMutableDictionary *)responseObject;
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        // appDelegate.dic=dic;
        appDelegate.dic_term=dictionary1;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            str_term1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserMP"]];
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:str_term1 forKey:@"period"];
            
            marking_period_type=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"marking_period_type"]];
            
            [df setObject:marking_period_type forKey:@"tanay"];
            
            ////tERM/////
            [marking_period removeAllObjects];
            [marking_period_title removeAllObjects];
            [marking_period_id removeAllObjects];
            marking_period=[[dictionary1 objectForKey:@"marking_period_list"]mutableCopy];
            
            if ([marking_period count]>0) {
                marking_period_title= [[NSMutableArray alloc] init];
                marking_period_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[marking_period count]; i++) {
                    NSDictionary *dic15 = [marking_period objectAtIndex:i];
                    [marking_period_title  addObject:[dic15 objectForKey:@"title"]];
                    [marking_period_id addObject:[dic15 objectForKey:@"id"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            NSMutableDictionary *TERM=[[NSMutableDictionary alloc]init];
            NSString *st_T=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
            
            NSLog(@"course ary----%@",marking_period);
            for (int i=0; i<[marking_period count]; i++) {
                
                
                if ([st_T isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"id"]]) {
                    TERM=[marking_period objectAtIndex:i];
                    
                    
                  //  term.text=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"title"]];
                    t1=true;
                    break;
                    
                }
                
                else
                {
                    
                 //  term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
                    
                }
                
            }
            
            
            if (t1==true) {
                 term.text=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"title"]];
            }
            
            else
            {
                
                 term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
            
            }
        }
        
        
        
        else
        {
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
          //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
           // [alert show];
            
            
            
        }
        
        [self dropdowndataterm];
        [self dropdowndatasub];
        [self dropdowndatacourse];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}

-(void)dropdowndataterm
{
    
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_marking_period_dropdown.php?school_id=1&syear=2015&staff_id=2&mp_id=16
    
    //   marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
    //   term123=[df objectForKey:@"period"];
    str_term1=[df objectForKey:@"period"];
    marking_period_type=[df objectForKey:@"tanay"];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin;
    if ([flag123 isEqualToString:@"1"]) {
        //   NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        //        school_id=[df objectForKey:@"school"];
        //        school_year=[df objectForKey:@"year"];
        
        
        
        
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_marking_period_dropdown.php?school_id=%@&syear=%@&staff_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
        
        
    }
    
    else
    {
        
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_marking_period_dropdown.php?school_id=%@&syear=%@&staff_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
        
        
    }
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
        
        
        dic= (NSMutableDictionary *)responseObject;
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.dic_sub=dictionary1;
        
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            str_sub1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserSubject"]];
            
            
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:str_sub1 forKey:@"sub"];
            
            
            
            ///SUBJECT////
            [subject_ary removeAllObjects];
            [subject_title removeAllObjects];
            [subject_id removeAllObjects];
            subject_ary=[[dictionary1 objectForKey:@"subject_list"]mutableCopy];
            
            if ([subject_ary count]>0) {
                subject_title = [[NSMutableArray alloc] init];
                subject_id= [[NSMutableArray alloc] init];
                for (int i = 0; i<[subject_ary count]; i++) {
                    NSDictionary *dic15 = [subject_ary objectAtIndex:i];
                    [subject_title  addObject:[dic15 objectForKey:@"title"]];
                    [subject_id addObject:[dic15 objectForKey:@"id"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            NSMutableDictionary *SUB=[[NSMutableDictionary alloc]init];
            NSString *strt_SUB=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserSubject"]];
            
            
            NSLog(@"course ary----%@",subject_ary);
            for (int i=0; i<[subject_ary count]; i++) {
                
                
                if ([strt_SUB isEqual:[[subject_ary  objectAtIndex:i]objectForKey:@"id"]]) {
                    SUB=[subject_ary objectAtIndex:i];
                    
                    su1=true;
                    break;
                   // subject.text=[NSString stringWithFormat:@"%@",[SUB objectForKey:@"title"]];
                    
                }
                
                else
                {
                    
                   // subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
                    
                }
            }
                if (su1==true) {
                    subject.text=[NSString stringWithFormat:@"%@",[SUB objectForKey:@"title"]];
                }
                else
                {
                     subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
                
                }
                
           
            
            [self dropdowndatasub];
            [self dropdowndatacourse];
            
            
        }
        
        
        
        
        else
        {
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
          //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
          //  [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}



-(void)dropdowndatasub
{
    //   http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_course_dropdown.php?school_id=1&syear=2015&staff_id=2&course_id=17
    //   NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
    //  NSString *term123=[df objectForKey:@"period"];
    str_sub1=[df objectForKey:@"sub"];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin;
    
    if ([flag123 isEqualToString:@"1"]) {
        //  NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        //  school_id=[df objectForKey:@"school"];
        //  school_year=[df objectForKey:@"year"];
        
        //  str_term1=[df objectForKey:@"period"];
        
        str_checklogin=[NSString stringWithFormat:@"/manage_subject_dropdown.php?school_id=%@&syear=%@&staff_id=%@&subject_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_sub1,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        
          str_checklogin=[NSString stringWithFormat:@"/manage_subject_dropdown.php?school_id=%@&syear=%@&staff_id=%@&subject_id=%@",school_id1,school_year12,staff_id_d,str_sub1];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            
            str_cou1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserCourse"]];
            str_cp1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserCoursePeriod"]];
            NSLog(@"str____course--%@",str_cou1);
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:str_cou1 forKey:@"course"];
            
            ////COURSE///
            
            [course_ary removeAllObjects];
            [course_title removeAllObjects];
            [course_id removeAllObjects];
            course_ary=[[dictionary1 objectForKey:@"course_list"]mutableCopy];
            
            if ([course_ary count]>0) {
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
            
            NSMutableDictionary *COURSE=[[NSMutableDictionary alloc]init];
            NSString *strt_C=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCourse"]];
            
            
            NSLog(@"course ary----%@",course_ary);
            for (int i=0; i<[course_ary count]; i++) {
                
                
                if ([strt_C isEqual:[[course_ary  objectAtIndex:i]objectForKey:@"id"]]) {
                    COURSE=[course_ary objectAtIndex:i];
                    
                    co=true;
                    break;
                    
                   // course.text=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"title"]];
                }
                
                else
                {
                   // course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
                    
                }
                
            }
            
            
            if (co==true) {
                 course.text=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"title"]];
            }
            else
            {
                course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
            
            }
        }
        
        
        
        
        else
        {
          //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
           // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
           // [alert show];
            
            
            
        }
        [self dropdowndatacourse];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}

-(void)dropdowndatacourse
{
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_course_dropdown.php?school_id=1&syear=2015&staff_id=2&course_id=17
    //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
    NSString *cou123456=[df objectForKey:@"course"];
    NSLog(@"courename-----%@",course);
    [course_period_ary removeAllObjects];
    [course_period_title removeAllObjects];
    [course_period_id removeAllObjects];
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin;
    if ([flag123 isEqualToString:@"1"]) {
        
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_course_dropdown.php?school_id=%@&syear=%@&staff_id=%@&course_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,cou123456,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    else
    {
        
           str_checklogin=[NSString stringWithFormat:@"/manage_course_dropdown.php?school_id=%@&syear=%@&staff_id=%@&course_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,cou123456,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
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
        // dictionary1 = (NSMutableDictionary *)responseObject;
        //    dic= (NSMutableDictionary *)responseObject;
        dictionary1=[responseObject mutableCopy];
        [dictionary1 setObject:school_id1 forKey:@"SCHOOL_ID"];
        [dictionary1 setObject:school_year12 forKey:@"SYEAR"];
        [dictionary1 setObject:school_year forKey:@"Schoolyear_list"];
        [dictionary1 setObject:str_term1 forKey:@"UserMP"];
        [dictionary1 setObject:str_sub1 forKey:@"UserSubject"];
        [dictionary1 setObject:marking_period_type forKey:@"marking_period_type"];
        [dictionary1 setObject:subject_ary forKey:@"subject_list"];
        [dictionary1 setObject:  marking_period forKey:@"marking_period_list"];
        
        [dictionary1 setObject:cou123456   forKey:@"UserCourse"];
        [dictionary1 setObject:course_ary   forKey:@"course_list"];
        [dictionary1 setObject:c_school   forKey:@"School_list"];
        
        
        
        
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.dic=dictionary1;
        
        NSLog(@"value is-dddddd------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            
            
            
            
            /////COURSE pERIOD//
            course_period_ary=[[dictionary1 objectForKey:@"course_period_list"]mutableCopy];
            
            if ([course_period_ary count]>0) {
                course_period_title= [[NSMutableArray alloc] init];
                course_period_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[course_period_ary count]; i++) {
                    NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
                    [course_period_title  addObject:[dic15 objectForKey:@"title"]];
                    [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            NSMutableDictionary *C_PERIOD=[[NSMutableDictionary alloc]init];
            NSString *strt_P=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
            
            //  NSLog(@"course ary----%@",course_period_ary);
            for (int i=0; i<[course_period_ary count]; i++) {
                
                
                if ([strt_P isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
                    C_PERIOD=[course_period_ary objectAtIndex:i];
                    
                    cp=true;
                    break;
//                    coursePeriod.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
//                    courseperiodName.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
//                    str_cp1=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"cpv_id"]];
//                    
//                    NSLog(@"str_cp1yyyyyy---%@",str_cp1);
//                    
                }
                
                
                else
                {
                    
                    
//                    coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//                    courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//                    str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
//                       NSLog(@"str_cp1---%@",str_cp1);
                }
                
                
                
                
                
            }
            
            
            if (cp==true) {
                coursePeriod.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
                courseperiodName.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
                str_cp1=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"cpv_id"]];
                
                NSLog(@"str_cp1yyyyyy---%@",str_cp1);
                s_lbl.text=str_cp1;
                 [self loaddata123];
            }
            
            else
            {
            
                coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
                courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
                str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
                NSLog(@"str_cp1---%@",str_cp1);
                s_lbl.text=str_cp1;
                 [self loaddata123];
                
            }
            
        }
        
        
        
        
        else
        {
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
          //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
           // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}


-(void)termClicked1

{
    
    
    if ([term_flag isEqualToString:@"1"]) {
        
        
        NSLog(@"Done Clicked");
        NSLog(@"-------%@",period123);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        
        
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:period123 forKey:@"period"];
        
        
        NSLog(@"strterm---%@",str_term1);
        flag123=@"1";
        [self dropdowndataterm];
        
        [self currentsubject];
        [self currentcourse];
        
        [self courseperiod123];
         NSLog(@"-------%@",str_cp1);
         s_lbl.text=str_cp1;
        [self loaddata];
        term_flag=@"0";
    }
    
    
    else
    {
        NSLog(@"okkkkkk");
        
        
        
    }
    
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}
-(void)courseClicked1

{
    
    if ([term_flag isEqualToString:@"1"]) {
        NSLog(@"Done Clicked");
        NSLog(@"-------%@",cou123);
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:cou123 forKey:@"course"];
        
        
        flag123=@"1";
        [self dropdowndatacourse];
        [self courseperiod123];
         NSLog(@"-------%@",str_cp1);
     //   s_lbl.text=str_cp1;
       // [self loaddata];
         term_flag=@"0";
    }
    
    else
    {
        
    }
     s_lbl.text=str_cp1;
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}


-(void)subClicked1

{
    if ([term_flag isEqualToString:@"1"]) {
        NSLog(@"Done Clicked");
        
        NSLog(@"-------%@",sub123);
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        //      [course_ary removeAllObjects];
        //      [course_title removeAllObjects];
        //      [course_id removeAllObjects];
        
        NSLog(@"course title----%@",course_title);
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:sub123 forKey:@"sub"];
        // school_sub_p=[DEF objectForKey:@"sub"];
        
        flag123=@"1";
        [self dropdowndatasub];
        // [self dropdowndatacourse];
        [self currentcourse];
        
        [self courseperiod123];
        // [self courseperiodname];
        
        
         NSLog(@"---ttttttt----%@",str_cp1);
       // s_lbl.text=str_cp1;
     //  [self loaddata123];
        
         term_flag=@"0";
        
        
        
        
    }
    
    else
    {
        
    }
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}

-(void)yearClicked1

{
    if ([term_flag isEqualToString:@"1"]) {
        NSLog(@"Done Clicked");
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year_p forKey:@"school_year"];
        flag123=@"1";
        [self dropdowndatayear];
        
        [self term];
        [self currentsubject];
        [self currentcourse];
        
        [self courseperiod123];
         NSLog(@"-------%@",str_cp1);
      //  s_lbl.text=str_cp1;
       // [self loaddata];
         term_flag=@"0";
    }
    else
    {
        
    }
    
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}
-(void)schoolClicked1

{  if ([term_flag isEqualToString:@"1"]) {
    NSLog(@"Done Clicked");
     NSLog(@"-------%@",str_cp1);
   //  s_lbl.text=str_cp1;
    //[self loaddata];
    //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //        [self dropdowndata];
    //        [self currentschoolyear];
    //        [self term];
    //        [self currentsubject];
    //        [self currentcourse];
    //
    //        [self courseperiod123];
    

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self dropdowndata];
    
    [self currentschoolyear];
    [self term];
    [self currentsubject];
    [self currentcourse];
    
    [self courseperiod123];
    term_flag=@"0";

}
else
{
    
}
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}



-(void)pickerDoneClicked1

{
        if ([term_flag isEqualToString:@"1"]) {
        NSLog(@"Done Clicked");
          NSLog(@"-------%@",str_cp1);
       s_lbl.text=str_cp1;
         [self loaddata123];
          
    }
    else
    {
        
    }
  
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}


    
    
   


-(void)currentcourse
{
    
    
    
    
    
    
    
    
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
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(courseClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    course.inputAccessoryView = mypickerToolbar;
    
    
  //    [course_ary removeAllObjects];
  //  [course_title removeAllObjects];
    
    
    
}



-(void)currentsubject
{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=4;
    subject.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(subClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    subject.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}



-(void)currentschoolyear
{
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=2;
    schoolYear.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(yearClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    schoolYear.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

-(void)currentschool
{
    
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=1;
    currentSchool.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(schoolClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    currentSchool.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
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



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField !=courseperiodName && textField != term && textField != currentSchool && textField != schoolYear && textField != subject && textField != course) {
        [self animateTextField:coursePeriod up:YES];
    }
    
    
    if (textField ==term) {
        
        old_term=str_term1;
        
        NSLog(@"oldterm---%@",old_term);
        
        
        
    }
    if (textField==subject) {
        
        old_sub=str_sub1;
        NSLog(@"old sub------%@",old_sub);
        
    }
    
    if (textField==course) {
        
        old_co=str_cou1;
        NSLog(@"old-course%@",old_co);
    }
    
    
    if (textField==currentSchool) {
        
        old_sc=school_id;
        NSLog(@"old school---%@",old_sc);
        
    }
    
    if (textField==schoolYear) {
        
        old_year=school_year1;
        NSLog(@"old year---%@",old_year);
        
    }
    
    
    
    
}


-(void)alldata
{
    
      AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.dic=dic;
    marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:marking_period_type forKey:@"tanay"];
    search_ary_data=[[NSMutableArray alloc]initWithObjects:@"Alphabetically",@"User Id", nil];
    marking_period=[[dic objectForKey:@"marking_period_list"]mutableCopy];
    
    if ([marking_period count]>0) {
        marking_period_title= [[NSMutableArray alloc] init];
        marking_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[marking_period count]; i++) {
            NSDictionary *dic15 = [marking_period objectAtIndex:i];
            [marking_period_title  addObject:[dic15 objectForKey:@"title"]];
            [marking_period_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",marking_period);
    for (int i=0; i<[marking_period count]; i++) {
        
        
        if ([strt isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"id"]]) {
            dic16=[marking_period objectAtIndex:i];
            NSLog(@"dic16---%@",dic16);
            
            //   term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
            //  str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
            
            t=true;
            break;
            
        }
        
        else
        {
            
            //    term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
            //  str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
            
            
            
        }
        
        
        
        
    }
    
    
    if (t==true) {
        
        term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
        str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
        
        
    }
    
    else
    {
        term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
        str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"id"]];
        
    }
    
    
    
    
    
    
    
    
    
    
    c_school=[[dic objectForKey:@"School_list"]mutableCopy];
    
    if ([c_school count]>0) {
        c_school_title = [[NSMutableArray alloc] init];
        c_school_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[c_school count]; i++) {
            NSDictionary *dic15 = [c_school objectAtIndex:i];
            [c_school_title addObject:[dic15 objectForKey:@"title"]];
            [c_school_id addObject:[dic15 objectForKey:@"id"]];
            NSLog(@"dffg %@",c_school_title);
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    
    NSLog(@"c_school---%@",c_school);
    
    NSMutableDictionary *dic16q=[[NSMutableDictionary alloc]init];
    NSString *strtq=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SCHOOL_ID"]];
    
    NSLog(@"course ary----%@",c_school);
    for (int i=0; i<[c_school count]; i++) {
        
        
        if ([strtq isEqual:[[c_school objectAtIndex:i]objectForKey:@"id"]]) {
            dic16q=[c_school objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16q);
            
            //  currentSchool.text=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"title"]];
            
            // school_id=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"id"]];
            
            s=true;
            break;
        }
        
        else
        {
            
            //  currentSchool.text=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"title" ]];
            // school_id=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"id"]];
        }
        
    }
    
    if (s==true) {
        currentSchool.text=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"title"]];
        
        school_id=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"id"]];
    }
    else
    {
        
        currentSchool.text=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"title" ]];
        school_id=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"id"]];
        
    }
    
    
    
    school_year=[[dic objectForKey:@"Schoolyear_list"]mutableCopy];
    
    if ([school_year count]>0) {
        school_year_title = [[NSMutableArray alloc] init];
        school_year_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[school_year count]; i++) {
            NSDictionary *dic15 = [school_year objectAtIndex:i];
            [school_year_title  addObject:[dic15 objectForKey:@"title"]];
            [school_year_id addObject:[dic15 objectForKey:@"start_date"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    
    NSMutableDictionary *dic167=[[NSMutableDictionary alloc]init];
    NSString *strt7=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SYEAR"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",school_year);
    for (int i=0; i<[school_year count]; i++) {
        
        
        if ([strt7 isEqual:[[school_year  objectAtIndex:i]objectForKey:@"start_date"]]) {
            dic167=[school_year objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16);
            
            //  schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"title"]];
            // school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"start_date"]];
            y=true;
            break;
            
            
        }
        
        else
        {
            
            
            //  schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
            //  school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"start_date"]];
        }
        
    }
    
    if (y==true) {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"title"]];
        school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"start_date"]];
        
    }
    
    else
    {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
        school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"start_date"]];
    }
    
    
    
    subject_ary=[[dic objectForKey:@"subject_list"]mutableCopy];
    
    if ([subject_ary count]>0) {
        subject_title = [[NSMutableArray alloc] init];
        subject_id= [[NSMutableArray alloc] init];
        for (int i = 0; i<[subject_ary count]; i++) {
            NSDictionary *dic155 = [subject_ary objectAtIndex:i];
            [subject_title  addObject:[dic155 objectForKey:@"title"]];
            [subject_id addObject:[dic155 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic1665=[[NSMutableDictionary alloc]init];
    NSString *strt_s5=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserSubject"]];
    
    
    NSLog(@"course ary----%@",subject_ary);
    for (int i=0; i<[subject_ary count]; i++) {
        
        
        if ([strt_s5 isEqual:[[subject_ary  objectAtIndex:i]objectForKey:@"id"]]) {
            dic1665=[subject_ary objectAtIndex:i];
            
            
            //  subject.text=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"title"]];
            //  str_sub1=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"id"]];
            su=true;
            break;
        }
        
        else
        {
            
            //subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
            // str_sub1=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"id"]];
            
        }
        
    }
    
    if (su==true) {
        subject.text=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"title"]];
        str_sub1=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"id"]];
    }
    
    else
    {
        
        
        subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
        str_sub1=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"id"]];
        
    }
    
    
    
    
    
    course_ary=[[dic objectForKey:@"course_list"]mutableCopy];
    
    if ([course_ary count]>0) {
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
    NSLog(@"course--tit-------%@",course_title);
    NSMutableDictionary *dic168=[[NSMutableDictionary alloc]init];
    NSString *strt8=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCourse"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",course_ary);
    for (int i=0; i<[course_ary count]; i++) {
        
        
        if ([strt8 isEqual:[[course_ary  objectAtIndex:i]objectForKey:@"id"]]) {
            dic168=[course_ary objectAtIndex:i];
            
            
            c_a=true;
            break;
            //   course.text=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"title"]];
            //str_cou1=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"id"]];
            
            
        }
        
        else
        {
            //  course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
            //  str_cou1=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"id"]];
        }
        
    }
    if (c_a==true) {
        
        course.text=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"title"]];
        str_cou1=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"id"]];
        
        
    }
    
    else
    {
        course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
        str_cou1=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"id"]];
        
        
    }
    
    
    
    
    
    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    
    
    
    [self labelborderset:notofi];
    [self labelborderset:msg_count];
    [self labelborderset:msg_count_tab];
    
    
    _view_term.layer.borderWidth = 1.0f;
    _view_subject.layer.borderWidth = 1.0f;
    _view_schoolyear.layer.borderWidth = 1.0f;
    _view_currentSchool.layer.borderWidth = 1.0f;
    _view_courseperiod.layer.borderWidth = 1.0f;
    _view_course.layer.borderWidth = 1.0f;
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    
    _view_coursePeriodName.clipsToBounds = YES;
    _view_courseperiod.clipsToBounds = YES;
    _view_course.clipsToBounds = YES;
    _view_currentSchool.clipsToBounds = YES;
    _view_schoolyear.clipsToBounds = YES;
    _view_subject.clipsToBounds = YES;
    _view_term.clipsToBounds = YES;
    
    
    
    _view_course.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_courseperiod.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_currentSchool.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_schoolyear.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_subject.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_term.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    
    
    
    
    
    NSLog(@"dicvalue---%@",dic);
    NSMutableArray *INFO=[[NSMutableArray alloc]init];
    INFO=[dic_techinfo objectForKey:@"tech_info"];
    
    
    
    lbl_username.text=[NSString stringWithFormat:@"%@ %@",[[INFO objectAtIndex:0]objectForKey:@"FIRST_NAME"],[[INFO objectAtIndex:0]objectForKey:@"LAST_NAME"]];
    
    lbl_useremail.text=[NSString stringWithFormat:@"%@",[[INFO objectAtIndex:0]objectForKey:@"EMAIL"]];
    
    NSString *gender12=[NSString stringWithFormat:@"%@",[[INFO objectAtIndex:0]objectForKey:@"GENDER"]];
    if ([gender12 isEqualToString:@"Female"]) {
        //  self.img_profile.layer.cornerRadius = img_profile.frame.size.width / 2;
        self.img_profile.layer.borderWidth = 4.0f;
        self.img_profile.layer.borderColor = [UIColor whiteColor].CGColor;
        // self.img_profile.clipsToBounds = YES;
        self.img_profile.image=[UIImage imageNamed:@"female"];
        [self.img_profile applyPhotoFrame];
        
    }
    
    else
    {
        //  self.img_profile.layer.cornerRadius = img_profile.frame.size.width / 2;
        self.img_profile.layer.borderWidth = 4.0f;
        self.img_profile.layer.borderColor = [UIColor whiteColor].CGColor;
        // self.img_profile.clipsToBounds = YES;
        self.img_profile.image=[UIImage imageNamed:@"male"];
        [self.img_profile applyPhotoFrame];
        
        
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger weekday1 = [comps weekday];
    NSLog(@"The week day number: %ld", (long)weekday1);
    NSString *day;
    if (weekday1==1) {
        day=@"Sunday";
    }
    else  if (weekday1==2) {
        day=@"Monday";
    }
    else  if (weekday1==3) {
        day=@"Tuesday";
    }
    else  if (weekday1==4) {
        day=@"Wednesday";
    }
    
    else  if (weekday1==5) {
        day=@"Thursday";
        
    }
    
    
    else  if (weekday1==6) {
        day=@"Friday";
    }
    
    else  if (weekday1==7) {
        day=@"Saturday";
    }
    else
    {
        
        
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd,yyyy"];
    NSLog(@"date and time------%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    lbl_currentDate.text=[NSString stringWithFormat:@"%@ %@",day,[dateFormatter stringFromDate:[NSDate date]]];
    
    
    
    
    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
    
    
    NSLog(@"course ary----%@",course_period_ary);
    for (int i=0; i<[course_period_ary count]; i++) {
        
        
        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
            dic177=[course_period_ary objectAtIndex:i];
            NSLog(@"dic16---%@",dic16);
            c_ap=true;
            break;
            
        }
        
        
        else
        {
            
            
            //  coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
            //  courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
            //  str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"period_id"]];
        }
        
    }
    
    if (c_ap==true) {
        coursePeriod.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"cpv_id"]];
         s_lbl.text=str_cp1;
    }
    
    else
    {
        
        
        coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
         s_lbl.text=str_cp1;
        
    }
    
    
    
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
            atten_id=[[NSMutableArray alloc]init];
            self.ary_data1=[[NSMutableArray alloc]init];
            NSMutableArray  *aty=[[NSMutableArray alloc]init];
            self.ary_data1=[dictionary1 objectForKey:@"students"];
            self.data12=[[dictionary1 objectForKey:@"students"]mutableCopy ];
            aty=[dictionary1 objectForKey:@"attendance_code"];
            attendance_value=[[NSMutableArray alloc]init];
            NSLog(@"aty---%@",aty);
            if ([aty count]>0) {
                for (int i = 0; i<[aty count]; i++) {
                    NSDictionary *dic9 = [aty objectAtIndex:i];
                    [attendance_value addObject:[dic9 objectForKey:@"SHORT_NAME"]];
                    [atten_id addObject:[dic9 objectForKey:@"STATE_CODE"]];
                    [state_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
                    
                }
                NSLog(@"courese_title----%@",attendance_value);
            }
            
            for (int i=0; i<[data12 count]; i++) {
                
                NSDictionary *dic9 = [data12 objectAtIndex:i];
                [self.arr_data addObject:[dic9 objectForKey:@"STATE_CODE"]];
                [arr_data_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
                [self.stu_id addObject:[dic9 objectForKey:@"STUDENT_ID"]];
                [self.atten_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
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
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            lbl_show.hidden=NO;
            mtable.hidden=YES;
          //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
              lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
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
                [self.atten_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
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

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"dic---%@",dic);
    
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
    [self loaddata];
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
    [self currentschool];
    [self currentschoolyear];
    [self term];
    [self currentsubject];
    [self currentcourse];
    [self courseperiod123];
    [self courseperiodname];
      [self alldata];
    [self tabledata];
    [self shortingpicker];
   
    
    newView.frame=CGRectMake(0, 0, self.view.frame.size.width - 50, self.view.frame.size.height);
    int x = newView.frame.size.width;
    slidewidth = x / 2;
    int y = newView.frame.size.height;
    
    slideheight = y / 2;
    //[Xbutton setFrame:CGRectMake(213, 0, 46, 30)];
    
    [newView addSubview:Xbutton];
    // Do any additional setup after loading the view.
  UITapGestureRecognizer *tapmainview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    tapmainview.numberOfTapsRequired = 1;
 //   tapmainview.delegate = self;
   // [self.view addGestureRecognizer:tapmainview];
    [baseView addGestureRecognizer:tapmainview];    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    mtable.userInteractionEnabled = YES;
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
            _view_topgrey.frame =
            CGRectMake(_view_topgrey.frame.origin.x,
                       _view_topgrey.frame.origin.y - incdecheight,
                       _view_topgrey.frame.size.width,
                       _view_topgrey.frame.size.height);
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
            _view_topgrey.frame =
            CGRectMake(_view_topgrey.frame.origin.x,
                       _view_topgrey.frame.origin.y + incdecheight,
                       _view_topgrey.frame.size.width,
                       _view_topgrey.frame.size.height);
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


-(void)shortingpicker
{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=70;
    txt_shorting.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked12)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    txt_shorting.inputAccessoryView = mypickerToolbar;
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
    
    
    if (pickerView.tag==1) {
        
        return c_school_title.count;
    }
    else if (pickerView.tag==2)
    {
        
        return school_year_title.count;
    }
    
    else if (pickerView.tag==3)
    {
        
        return marking_period_title.count;
    }
    else if (pickerView.tag==4)
    {
        
        return subject_title.count;
    }
    else if (pickerView.tag==5)
    {
        
        return course_title.count;
    }
    
    else if (pickerView.tag==6)
    {
        
        return course_period_title.count;
    }
    else if (pickerView.tag==60)
    {
        
        return course_period_title.count;
    }
    
    else if (pickerView.tag==70)
    {
        
        return search_ary_data.count;
    }
    else if (pickerView.tag==500)
    {
        
        return  attendance_value.count;
    }

    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView.tag==1) {
        
        
        return [c_school_title objectAtIndex:row];
    }
    else if (pickerView.tag==2)
    {
        return [school_year_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==3)
    {
        return [marking_period_title objectAtIndex:row];
    }
    
    
    else if (pickerView.tag==4)
    {
        return [subject_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==5)
    {
        return [course_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==6)
    {
        return [course_period_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==60)
    {
        return [course_period_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==70)
    {
        
        return [search_ary_data objectAtIndex:row];
    }
    else if (pickerView.tag==500)
    {
        
        return  [attendance_value  objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
        
    
    if (pickerView.tag==1) {
        
        
        
        
        
        currentSchool.text=(NSString *)[c_school_title objectAtIndex:row];
        NSString *strC =(NSString *)[c_school_title objectAtIndex:row];
        str_c_school_id123 = [c_school_id objectAtIndex:[c_school_title indexOfObjectIdenticalTo:strC]];
        
        NSLog(@"-------%@",str_c_school_id123);
        
        
        school_id_p=[c_school_id objectAtIndex:[c_school_title indexOfObjectIdenticalTo:strC]];
        
        NSLog(@"school id---%@",school_id_p);
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_id_p forKey:@"school_id1"];
        flag123=@"1";
        term_flag=@"1";
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [self dropdowndata];
//        [self currentschoolyear];
//        [self term];
//        [self currentsubject];
//        [self currentcourse];
//        
//        [self courseperiod123];
        
        
    }
    
    
    
    else  if (pickerView.tag==2) {
        
        
        
        
        schoolYear.text=(NSString *)[school_year_title objectAtIndex:row];
        
        NSString *strC1 =(NSString *)[school_year_title objectAtIndex:row];
        school_year123 = [school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"-------%@",strC1);
        
        //   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        school_year_p=[school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
        //        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        //        [df setObject:school_year_p forKey:@"school_year"];
        //        flag123=@"1";
        //        [self dropdowndatayear];
        //
        //          [self term1];
        //        [self currentsubject];
        //        [self currentcourse];
        //
        //        [self courseperiod123];
        
        term_flag=@"1";
    }
    
    
    else  if (pickerView.tag==3) {
        
        
        
        
        term.text=(NSString *)[marking_period_title objectAtIndex:row];
        // term.text=[marking_period_title objectAtIndex:[selectcustomerpicker selectedRowInComponent:0]];
        NSString *strC1 =(NSString *)[marking_period_title objectAtIndex:row];
        period123 = [marking_period_id objectAtIndex:[marking_period_title indexOfObjectIdenticalTo:strC1]];
        term_flag=@"1";
        //        NSLog(@"-------%@",period123);
        //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //
        //        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        //        [DEF setObject:period123 forKey:@"period"];
        //
        //
        //        NSLog(@"strterm---%@",str_term1);
        //        flag123=@"1";
        //        [self dropdowndataterm];
        //
        //        [self currentsubject];
        //        [self currentcourse];
        //
        //        [self courseperiod123];
    }
    
    
    else  if (pickerView.tag==4) {
        
        
        
        
        
        subject.text=(NSString *)[subject_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[subject_title objectAtIndex:row];
        sub123 = [subject_id objectAtIndex:[subject_title indexOfObjectIdenticalTo:strC1]];
          term_flag=@"1";
        //
        //        NSLog(@"-------%@",sub123);
        //
        //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //
        //        //      [course_ary removeAllObjects];
        //        //      [course_title removeAllObjects];
        //        //      [course_id removeAllObjects];
        //
        //        NSLog(@"course title----%@",course_title);
        //        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        //        [DEF setObject:sub123 forKey:@"sub"];
        //       // school_sub_p=[DEF objectForKey:@"sub"];
        //
        //        flag123=@"1";
        //        [self dropdowndatasub];
        //       // [self dropdowndatacourse];
        //       [self currentcourse];
        //
        //        [self courseperiod123];
        //      // [self courseperiodname];
        
        
        
    }
    
    else  if (pickerView.tag==5) {
        
        
        
        
        
        course.text=(NSString *)[course_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_title objectAtIndex:row];
        cou123 = [course_id objectAtIndex:[course_title indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"-------%@",cou123);
        term_flag=@"1";
        //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        
        //        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        //        [DEF setObject:cou123 forKey:@"course"];
        //       
        //        
        //        flag123=@"1";
        //        [self dropdowndatacourse];
        //           [self courseperiod123];
        
    }
    
    
        
        else  if (pickerView.tag==6) {
            
            
            
            
            
            coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
            courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
            NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
            coperiod=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
            str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
            NSLog(@"course period id------%@",course_period_ary);
            NSLog(@"-------%@",str_cp1);
          //  s_lbl.text=str_cp1;
          //  [self loaddata];
            
             term_flag=@"1";
        }
    
        else  if (pickerView.tag==60) {
            
            
            
            
            
            courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
            coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
            NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
            coperiod=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
            NSLog(@"course period id1111------%@",course_period_ary);
            str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
            NSLog(@"-------%@",str_cp1);
        //    s_lbl.text=str_cp1;
          //  [self loaddata];
         NSLog(@"-------%@",str_cp1);
              term_flag=@"1";

        }
    
  else if (pickerView.tag==500)
  {
      
      
      [self.arr_data replaceObjectAtIndex:selectedIndexpath withObject:[attendance_value objectAtIndex:[pick12 selectedRowInComponent:0]]];
      //  NSString *strC1 =(NSString *)[course_title objectAtIndex:row];
      //coperiod= [atten_id objectAtIndex:[course_title indexOfObjectIdenticalTo:strC1]];
      [self.atten_code replaceObjectAtIndex:selectedIndexpath withObject:[atten_id objectAtIndex:[pick12 selectedRowInComponent:0]]];
      [arr_data_code replaceObjectAtIndex:selectedIndexpath withObject:[state_code objectAtIndex:[pick12 selectedRowInComponent:0]]];
      //[self.data12 replaceObjectAtIndex:selectedIndexpath withObject:<#(id)#>];
      NSMutableDictionary *dicnew = [[self.data12 objectAtIndex:selectedIndexpath]mutableCopy];
     // [dicnew setObject:[atten_id objectAtIndex:[pick12 selectedRowInComponent:0]] forKey:@"STATE_CODE"];
      [dicnew setObject:[state_code objectAtIndex:[pick12 selectedRowInComponent:0]] forKey:@"STATE_CODE"];
      [self.data12 replaceObjectAtIndex:selectedIndexpath withObject:dicnew];
      NSLog(@"attendance_code: %@\nstate_code: %@",[dicnew objectForKey:@"ATTENDANCE_CODE"],[dicnew objectForKey:@"STATE_CODE"]);
      
      //        coperiod= [atten_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
      //
      //        NSLog(@"-------%@",coperiod);
      
      [mtable reloadData];
      view1236.hidden=YES;
      
  }
    
    
    
    else  if (pickerView.tag==70) {
      
      
      
      
      
      txt_shorting.text=(NSString *)[search_ary_data objectAtIndex:row];
      NSString *strC1 =[NSString stringWithFormat:@"%@",txt_shorting.text];
      
      [self.stu_id removeAllObjects];
      [self.atten_code removeAllObjects];
      [self.arr_data removeAllObjects];
      [arr_data_code removeAllObjects];
      if ([strC1 isEqualToString:@"Alphabetically"]) {
          
          for (int i=0;i<self.data12.count; i++) {
              
              
              NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"FULL_NAME" ascending:YES];
              
              sortedArray=[self.data12 sortedArrayUsingDescriptors:@[sd]];
              
              
              
          }
          
          
          
          
          
          
          if ([self.data12 count]>0) {
              
              
              NSLog(@"Shorted array value is : %@",sortedArray);
              
              [self.data12 removeAllObjects];
              NSLog(@"ary_data value is : %@",ary_data);
              [self.data12 addObjectsFromArray:sortedArray];
              NSLog(@"Shorted for loop outside array value is : %@",sortedArray);
              NSLog(@"ary3 for loop outside array value is : %@",self.data12);
              for (int i=0; i<[data12 count]; i++) {
                  
                  NSDictionary *dic9 = [data12 objectAtIndex:i];
                  [self.arr_data addObject:[dic9 objectForKey:@"STATE_CODE"]];
                  [arr_data_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
                  [self.stu_id addObject:[dic9 objectForKey:@"STUDENT_ID"]];
                  [self.atten_code addObject:[dic9 objectForKey:@"ATTENDANCE_CODE"]];
              }
              [mtable reloadData];
              
          }
      }
      
      
      else
      {
          
          for (int i=0;i<self.data12.count; i++) {
              
              
              //    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"STUDENT_ID" ascending:NSOrderedAscending];
              NSSortDescriptor *sd = [[NSSortDescriptor alloc]initWithKey:@"STUDENT_ID"  ascending:YES selector:@selector(localizedStandardCompare:)];
              //NSArray *desc = [NSArray arrayWithObjects:sd,nil];
              sortedArray=[self.data12 sortedArrayUsingDescriptors:@[sd]];
              
              
              //
          }
          
          
          
          
          
          
          if ([self.data12 count]>0) {
              
              
              NSLog(@"Shorted array value is : %@",sortedArray);
              
              [self.data12 removeAllObjects];
              NSLog(@"ary_data value is : %@",ary_data);
              [self.data12 addObjectsFromArray:sortedArray];
              NSLog(@"Shorted for loop outside array value is : %@",sortedArray);
              NSLog(@"ary3 for loop outside array value is : %@",self.data12);
              for (int i=0; i<[data12 count]; i++) {
                  
                  NSDictionary *dic9 = [data12 objectAtIndex:i];
                  [self.arr_data addObject:[dic9 objectForKey:@"STATE_CODE"]];
                  [arr_data_code addObject:[dic9 objectForKey:@"STATE_CODE"]];
                  [self.stu_id addObject:[dic9 objectForKey:@"STUDENT_ID"]];
                  [self.atten_code addObject:[dic9 objectForKey:@"ATTENDANCE_CODE"]];
              }
              [mtable reloadData];
              
          }
          
      }
      
  }
    

    
    else
    {
        NSLog(@"----");
    
    }
    
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
   
    [newView setCenter:CGPointMake(-slidewidth, slideheight)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    [newView setCenter:CGPointMake(slidewidth, slideheight)];
    
    [self.view addSubview:newView];
    [UIView commitAnimations];
  mtable.userInteractionEnabled=NO;
    
}
-(IBAction)close:(id)sender
{
   mtable.userInteractionEnabled=YES;
  
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.3f];
    [newView setCenter:CGPointMake(-slidewidth, slideheight)];

    [UIView commitAnimations];
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
     [course resignFirstResponder];
    [coursePeriod resignFirstResponder];

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

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
   TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    vc.dic=dic;
    
    vc.dic_techinfo=dic_techinfo;
    
    
    
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

    return self.data12.count;
}
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//     NSString *str =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"SCHOOL_DATE"];
//    
//    NSString *cpv_id =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"CPV_ID"];
//      NSString *SCHOOL_ID =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"SCHOOL_ID"];
//    UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
   /* attendetail *obj1=[s instantiateViewControllerWithIdentifier:@"ad"];
   obj1.str_date=str;
    
      obj1.cpv_id=cpv_id;
     obj1.staff_id=staff_id;
    
    obj1.school_id=SCHOOL_ID;
    [self.navigationController pushViewController:obj1 animated:YES];*/
   
    
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
    
   
    


}



- (CellTableViewCell1 *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    //static NSString *cellid = @"cell";
    //UITableViewCell *cell;
    CellTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (CellTableViewCell1*)[[[NSBundle mainBundle] loadNibNamed:@"CellTableViewCell1" owner:nil options:nil] objectAtIndex:0];
        
        
    }
    [cell.img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[data12 objectAtIndex:indexPath.row]objectForKey:@"PHOTO"]]]];
placeholderImage:[UIImage imageNamed:@"cart.png"];
    
    
    cell.btn.tag=indexPath.row;
    cell.tempview.backgroundColor = cell.backgroundColor;
    [cell.btn addTarget:self action:@selector(atten1:) forControlEvents:UIControlEventTouchUpInside];
 //   int b=[[[data12 objectAtIndex:indexPath.row]objectForKey:@"STUDENT_ID"]intValue];
    
            cell.lbl_id.text=[NSString stringWithFormat:@"ID:%@",[[data12 objectAtIndex:indexPath.row]objectForKey:@"STUDENT_ID"]];
   // cell.lbl_id.text=[NSString stringWithFormat:@"%d",b];
    cell.lbl_name.text=[[self.data12 objectAtIndex:indexPath.row]objectForKey:@"FULL_NAME"];
    NSString *str_id=[atten_code objectAtIndex:indexPath.row];
    //    NSString *str_id1=[arr_data_code objectAtIndex:indexPath.row];
    NSLog(@"str---%@",str_id);
    if ([str_id isEqualToString:@"P"]) {
        
        
       // cell.atten.text= @"P";       //[arr_data objectAtIndex:indexPath.row];
        
    }
    else if  ([str_id isEqualToString:@"A"]) {
        cell.btn.backgroundColor=[UIColor colorWithRed:212.0/255.0f green:50.0/255.0f blue:53.0/255.0f alpha:1.0f];
        
      //  cell.atten.text= @"A";  //[arr_data objectAtIndex:indexPath.row];
        
    }
    
    else if  ([str_id isEqualToString:@"T"]) {
        //  cell.btn.backgroundColor=[UIColor colorWithRed:249.0/255.0f green:135.0/255.0f blue:0.0/255.0f alpha:1.0f];
        cell.btn.backgroundColor=[UIColor colorWithRed:68.0/255.0f green:127.0/255.0f blue:0.0/255.0f alpha:1.0f];
      //  cell.atten.text=@"T";//[arr_data objectAtIndex:indexPath.row];
        
    }
    
    else
    {
        
        cell.btn.backgroundColor=[UIColor colorWithRed:68.0/255.0f green:127.0/255.0f blue:0.0/255.0f alpha:1.0f];
      //  cell.atten.text=@"L";//[arr_data objectAtIndex:indexPath.row];
        
    }
    
    
    cell.atten.text=[NSString stringWithFormat:@"%@",[[data12 objectAtIndex:indexPath.row]objectForKey:@"STATE_CODE"]];
    
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

 if (indexPath.row%2 == 0) {
 
 [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:255.0/255.0f alpha:1.0f]];
 }else
 {
 

        UIColor *color1=[UIColor colorWithRed:244.0/255.0f green:244.0/255.0f blue:244.0/255.0f alpha:1.0f];
     cell.contentView.backgroundColor=color1;
 }
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
