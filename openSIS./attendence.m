//
//  TeacherDashboardViewController.m
//  openSiS
//
//  Created by EjobIndia on 17/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//
#import "AppDelegate.h"
#import "attendence.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "attendencedetail.h"
#import "attendetail.h"
#import "Month1ViewController.h"

#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
@interface attendence()
@property (strong, nonatomic) IBOutlet UIView *view_currentSchool;
@property (strong, nonatomic) IBOutlet UIView *view_schoolyear;
@property (strong, nonatomic) IBOutlet UIView *view_subject;
@property (strong, nonatomic) IBOutlet UIView *view_courseperiod;
@property (strong, nonatomic) IBOutlet UIView *view_course;
@property (strong, nonatomic) IBOutlet UIView *view_term;
@property (strong, nonatomic) IBOutlet UIView *view_coursePeriodName;


//////////////////////////////////sidebarlabels

@property (strong, nonatomic) IBOutlet UILabel *lbl_currenschool;
@property (strong, nonatomic) IBOutlet UILabel *lbl_schoolyear;
@property (strong, nonatomic) IBOutlet UILabel *lbl_term;
@property (strong, nonatomic) IBOutlet UILabel *lbl_subject;
@property (strong, nonatomic) IBOutlet UILabel *lbl_course;
@property (strong, nonatomic) IBOutlet UILabel *lbl_courseperiod;
@property (strong, nonatomic) IBOutlet UIButton *btn_ok;
@property (strong, nonatomic) IBOutlet UILabel *lbl_logout;

///////////////----------------------------------

@property (strong, nonatomic) IBOutlet UILabel *lbl_missingattendance;



@end

@implementation attendence
@synthesize dic,img_profile;
@synthesize  school_id,school_year1,str_term1,str_sub1,str_cou1,str_cp1,dic_techinfo;
 @synthesize  school_name,school_year_name,school_term,school_sub,school_course,school_courseperiod,school_courseperiodname,flag_pass_data;
-(void)loaddata
{
 transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:2];
        });
    });



}
-(IBAction)alertOK:(id)sender
{
    transparentView.hidden = TRUE;
    [transparentView removeFromSuperview];
}

-(void)loaddata1
{
    ary_data=[[NSMutableArray alloc]init];
    NSMutableArray *INFO=[[NSMutableArray alloc]init];
    INFO=[self.dic_techinfo objectForKey:@"tech_info"];
    
    CURRENT_SCHOOL_ID=[[INFO objectAtIndex:0]objectForKey:@"CURRENT_SCHOOL_ID"];
    staff_id=[[INFO objectAtIndex:0]objectForKey:@"STAFF_ID"];
    SYEAR=[[INFO objectAtIndex:0]objectForKey:@"SYEAR"];

    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/missing_attendance.php?staff_id=%@&school_id=%@&syear=%@",staff_id,CURRENT_SCHOOL_ID,SYEAR];
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
       // NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            ary_data=[dictionary1 objectForKey:@"ma_list"];
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
            // NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg_mod"]];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No data" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            
            
            
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

    [super viewWillAppear:YES];
   

}

-(void)fetchdata
{
    
    ip_url *obj=[[ip_url alloc]init];
    NSString*  ip=[obj ipurl];
    //NSLog(@"%@",ip);
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
        dic_techinfo = (NSMutableDictionary *)responseObject;
        // NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"success"]];
     //   NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            
            
            
        
            lbl_notification1.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
            
            lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
            notofi.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"notification_count"]];
            NSString *str_count=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            if ([str_count isEqualToString:@"0"]) {
                msg_count_tab.hidden=YES;
               // msg_count.hidden=YES;
            }
            else
            {
                msg_count_tab.hidden=NO;
               // msg_count.hidden=NO;
            }

            
            
            
        }
        
        
        else
        {
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            
            //  transparentView.hidden=NO;
            // NSLog(@"ok----");
            //[self.view addSubview:transparentView];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
    
    
    
    
    
    
    
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"dic---%@",dic);
    
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"missingattendance"];
    
   AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
  //  dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    
    NSLog(@"info---%@",dic_techinfo);
    [self loaddata];
  //  [self droptable];
   
    [self tabledata];
    
    //*currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName
    
    
      //[Xbutton setFrame:CGRectMake(213, 0, 46, 30)];
    
   // [newView addSubview:Xbutton];
    // Do any additional setup after loading the view.
  /*  UITapGestureRecognizer *tapmainview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    tapmainview.numberOfTapsRequired = 1;
 //   tapmainview.delegate = self;
   // [self.view addGestureRecognizer:tapmainview];
    [baseView addGestureRecognizer:tapmainview];*/
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    mtable.userInteractionEnabled = YES;
    //[table addGestureRecognizer:tapmainview];
    //newView.userInteractionEnabled = NO;
    
    flag =0;k=0;
    [labelView setFrame:CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, self.view.frame.size.width, 0)];
    labelView.backgroundColor = [UIColor redColor];
    

}
-(IBAction)click:(id)sender
{
    flag_pass_data=@"1";
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
}


/*-(void)droptable{
    
   // [msg_count sizeToFit];
   // [notofi sizeToFit];
   // [msg_count_tab sizeToFit];
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
    }
}*/



-(void)tabledata
{
    
    
    mtable.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
}


#pragma mark Tabbar
-(IBAction)home:(id)sender
{
   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
   TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
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

    return ary_data.count;
}
- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:str_cp1 forKey:@"cpv_id"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSString *str =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"SCHOOL_DATE"];
    
   // NSString *cpv_id =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"CPV_ID"];
      NSString *SCHOOL_ID =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"SCHOOL_ID"];
    UIStoryboard *s1=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
   attendencedetail *obj1=[s1 instantiateViewControllerWithIdentifier:@"adt"];
   obj1.str_date=str;
    obj1.allvalue=[ary_data objectAtIndex:indexPath.row];
     // obj1.cpv_id=str_cp1;
     obj1.staff_id=staff_id;
    obj1.dic=dic;
    obj1.dic_techinfo=dic_techinfo;
    obj1.school_id=SCHOOL_ID;
    obj1.STR_TITLE=[[ary_data objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    [self.navigationController pushViewController:obj1 animated:YES];


}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

   
    UITableViewCell *cell;
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"cellatten" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
   
    lbl.text=[[ary_data objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    
    NSString *str =[[ary_data objectAtIndex:indexPath.row]objectForKey:@"SCHOOL_DATE"];/// here this is your date with format yyyy-MM-dd
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date..
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: str]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM/dd/yyyy"];// here set format which you want...
    
    NSString *convertedString = [dateFormatter stringFromDate:date]; //here convert date in NSString
    NSLog(@"Converted String : %@",convertedString);
  lbl_cell_date.text=convertedString;
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 52.0f;

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
