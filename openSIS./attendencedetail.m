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
#import "CellTableViewCell1.h"
#import "attendencedetail.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "attendencedetail.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
@interface attendencedetail()
{
    
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

////////////////////////////
@property (strong, nonatomic) IBOutlet UIButton *btn_save;


@end

@implementation attendencedetail
@synthesize dic,img_profile,data12,ary_data1;
@synthesize staff_id,school_id,str_date,cpv_id,arr_data,stu_id,atten_code,dic_techinfo;
@synthesize STR_TITLE,allvalue;
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
-(void)loaddata1
{
   
    NSMutableArray *INFO=[[NSMutableArray alloc]init];
    INFO=[dic_techinfo objectForKey:@"tech_info"];
    
    CURRENT_SCHOOL_ID=[[INFO objectAtIndex:0]objectForKey:@"CURRENT_SCHOOL_ID"];
    staff_id=[[INFO objectAtIndex:0]objectForKey:@"STAFF_ID"];
    SYEAR=[[INFO objectAtIndex:0]objectForKey:@"SYEAR"];
    NSMutableArray *INFO1=[[NSMutableArray alloc]init];
    INFO1=[dic_techinfo objectForKey:@"tech_info"];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    dic=appDelegate.dic;
    NSLog(@"tanay------%@",dic);
    NSString *cpv_value;
//    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
//    
//    if ([course_period_ary count]>0) {
//        course_period_title= [[NSMutableArray alloc] init];
//        course_period_id = [[NSMutableArray alloc] init];
//        for (int i = 0; i<[course_period_ary count]; i++) {
//            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
//            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
//            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
//            
//        }
//        
//    }
//    else {
//        NSLog(@"No  list");
//    }
//    
//    
//    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
//    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
//    NSLog(@"-----fffffff---%@",allvalue);
//    
//    NSLog(@"course ary----%@",course_period_ary);
//    for (int i=0; i<[course_period_ary count]; i++) {
//        
//        
//        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
//            dic177=[course_period_ary objectAtIndex:i];
//       
//            c_ap=true;
//            break;
//            
//        }
//        
//        
//        else
//        {
//            
//            
//            //  coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//            //  courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//            //  str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"period_id"]];
//        }
//        
//    }
//    
//    if (c_ap==true) {
//     //  cpv_value=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
//      //  courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
//        cpv_value=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"cpv_id"]];
//      
//    }
//    
//    else
//    {
//        
//        
//       // coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//      //  courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//      cpv_value=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
//        //s_lbl.text=str_cp1;
//        
//    }
//    

   // NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
   // cpv_id=[df objectForKey:@"cpv_id"];
    NSLog(@"cpv_id------%@",cpv_id);
    staff_id=[[INFO1 objectAtIndex:0]objectForKey:@"STAFF_ID"];
    NSString *cpid=[allvalue objectForKey:@"CPV_ID"];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/take_attendance_view.php?school_id=%@&staff_id=%@&cpv_id=%@&date=%@",school_id,staff_id,cpid,str_date];
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
            
            NSLog(@"aty---%@",aty);
            if ([aty count]>0) {
                for (int i = 0; i<[aty count]; i++) {
                    NSDictionary *dic9 = [aty objectAtIndex:i];
                    [course_title addObject:[dic9 objectForKey:@"SHORT_NAME"]];
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
            
            nodata.hidden=NO;
            mtable.hidden=YES;
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            
           // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         //   [alert show];
            
            nodata.text=str_msg;
            
            
            
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
    [self loaddata];
    [self droptable];
      [self  atten_data];
    [self dateandweek];
   
    arr_data_code=[[NSMutableArray alloc]init];
    state_code=[[NSMutableArray alloc]init];

    
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
   // [self currentcourse];
    [self courseperiod123];
    [self courseperiodname];
    [self tabledata];
    
    //*currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName
    
    
    newView.frame=CGRectMake(0, 0, self.view.frame.size.width - 50, self.view.frame.size.height);
    int x = newView.frame.size.width;
    slidewidth = x / 2;
    int y = newView.frame.size.height;
    
    slideheight = y / 2;
    //[Xbutton setFrame:CGRectMake(213, 0, 46, 30)];
    
    [newView addSubview:Xbutton];
    // Do any additional setup after loading the view.
  /*  UITapGestureRecognizer *tapmainview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    tapmainview.numberOfTapsRequired = 1;
 //   tapmainview.delegate = self;
   // [self.view addGestureRecognizer:tapmainview];
    [baseView addGestureRecognizer:tapmainview];*/
    
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
#pragma mark TopViewAnimation

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
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.463f green:0.463f blue:0.463f alpha:1.00f]CGColor];
    
    
    
    

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
   
    
    
   /* course_period_ary=[dic objectForKey:@"course_period_list"];
    
    if ([course_period_ary count]>0) {
       course_period_title= [[NSMutableArray alloc] init];
  course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"period_id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }*/
    
    course_period_title=[[NSMutableArray alloc]initWithObjects:@"Alphabetically",@"User Id", nil];
 //   NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",course_period_ary);
    
    
    
    
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

-(void)labelborderset:(UILabel*)lbl1
{

    lbl1.layer.borderWidth=4.0f;
    lbl1.layer.borderColor=[UIColor clearColor].CGColor;
    lbl1.layer.cornerRadius=2.0f;
    
    lbl1.clipsToBounds=YES;


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


-(void)term{
    
    
    
    
    
   marking_period=[dic objectForKey:@"marking_period_list"];
    
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
            
            term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
            
        }
        
        else
        {
        
             term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
        
        }
        
    }
  

    
    
    
    
    
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
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
  term.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
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



-(void)currentsubject
{
    
    
    
    
    
    subject_ary=[dic objectForKey:@"subject_list"];
    
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
    

    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserSubject"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",subject_ary);
    for (int i=0; i<[subject_ary count]; i++) {
        
        
        if ([strt isEqual:[[subject_ary  objectAtIndex:i]objectForKey:@"id"]]) {
            dic16=[subject_ary objectAtIndex:i];
            NSLog(@"dic16---%@",dic16);
            
            subject.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
            
        }
        
        else
        {
        
           subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
        
        }
        
    }
  
    
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
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
  subject.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}



-(void)currentschoolyear
{
    
    
    
  
    
  school_year=[dic objectForKey:@"Schoolyear_list"];
    
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
    

    
    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SYEAR"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",school_year);
    for (int i=0; i<[school_year count]; i++) {
        
        
        if ([strt isEqual:[[school_year  objectAtIndex:i]objectForKey:@"start_date"]]) {
            dic16=[school_year objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16);
            
            schoolYear.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
            

        }
        
        else
        {
        
            
            schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
        
        }
        
    }
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
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
schoolYear.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

-(void)currentschool
{
    
    
    
    
    
    c_school=[dic objectForKey:@"School_list"];
    
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
    
    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SCHOOL_ID"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",c_school);
    for (int i=0; i<[c_school count]; i++) {
        
        
        if ([strt isEqual:[[c_school objectAtIndex:i]objectForKey:@"id"]]) {
            dic16=[c_school objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16);
            
            currentSchool.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];

            
            
        }
        
        else
        {
        
              currentSchool.text=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"title" ]];
        
        }
        
    }
    
    

    
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
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
   currentSchool.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
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
else if (pickerView.tag==500)
{
    
    return course_title.count;
}
    

else if (pickerView.tag==60)
{
    
    return course_period_title.count;
}
    
  return 0;
    
    
}

-(IBAction)done:(id)sender
{

    
    view1236.hidden=YES;
    
   
    
    

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
    
    else if (pickerView.tag==500)
    {
        return [course_title objectAtIndex:row];
    }
    
  
    
    else if (pickerView.tag==60)
    {
        return [course_period_title objectAtIndex:row];
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
    }
    
    
    
  else  if (pickerView.tag==2) {
        
        
        
        
      schoolYear.text=(NSString *)[school_year_title objectAtIndex:row];
 
        NSString *strC1 =(NSString *)[school_year_title objectAtIndex:row];
      school_year123 = [school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
      
        NSLog(@"-------%@",strC1);
    }
    
    
  else  if (pickerView.tag==3) {
      
      
      
      
      term.text=(NSString *)[marking_period_title objectAtIndex:row];
    // term.text=[marking_period_title objectAtIndex:[selectcustomerpicker selectedRowInComponent:0]];
      NSString *strC1 =(NSString *)[marking_period_title objectAtIndex:row];
      period123 = [marking_period_id objectAtIndex:[marking_period_title indexOfObjectIdenticalTo:strC1]];
      
      NSLog(@"-------%@",period123);
  }

    
  else  if (pickerView.tag==4) {
      
      
      
      
      
    subject.text=(NSString *)[subject_title objectAtIndex:row];
      NSString *strC1 =(NSString *)[subject_title objectAtIndex:row];
      sub123 = [subject_id objectAtIndex:[subject_title indexOfObjectIdenticalTo:strC1]];
      
      NSLog(@"-------%@",sub123);
  }
    
    
    else if (pickerView.tag==500)
    {
    
    
        [self.arr_data replaceObjectAtIndex:selectedIndexpath withObject:[course_title objectAtIndex:[pick12 selectedRowInComponent:0]]];
         //  NSString *strC1 =(NSString *)[course_title objectAtIndex:row];
           //coperiod= [atten_id objectAtIndex:[course_title indexOfObjectIdenticalTo:strC1]];
          [self.atten_code replaceObjectAtIndex:selectedIndexpath withObject:[atten_id objectAtIndex:[pick12 selectedRowInComponent:0]]];
        [arr_data_code replaceObjectAtIndex:selectedIndexpath withObject:[state_code objectAtIndex:[pick12 selectedRowInComponent:0]]];
        //[self.data12 replaceObjectAtIndex:selectedIndexpath withObject:<#(id)#>];
        NSMutableDictionary *dicnew = [[self.data12 objectAtIndex:selectedIndexpath]mutableCopy];
        [dicnew setObject:[atten_id objectAtIndex:[pick12 selectedRowInComponent:0]] forKey:@"ATTENDANCE_CODE"];
        [dicnew setObject:[state_code objectAtIndex:[pick12 selectedRowInComponent:0]] forKey:@"STATE_CODE"];
        [self.data12 replaceObjectAtIndex:selectedIndexpath withObject:dicnew];
        NSLog(@"attendance_code: %@\nstate_code: %@",[dicnew objectForKey:@"ATTENDANCE_CODE"],[dicnew objectForKey:@"STATE_CODE"]);
        
//        coperiod= [atten_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
//        
//        NSLog(@"-------%@",coperiod);

        [mtable reloadData];
        view1236.hidden=YES;
    
    }
    
  else  if (pickerView.tag==5) {
      
      
      
      
      
      course.text=(NSString *)[course_title objectAtIndex:row];
      NSString *strC1 =(NSString *)[course_title objectAtIndex:row];
    cou123 = [course_id objectAtIndex:[course_title indexOfObjectIdenticalTo:strC1]];
      
      NSLog(@"-------%@",cou123);
  }
    

    
  else  if (pickerView.tag==60) {
      
      
      
      
      
      courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
      NSString *strC1 =[NSString stringWithFormat:@"%@",courseperiodName.text];
      
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


#pragma MARK:  SAVEDATA

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
    
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        dic=appDelegate.dic;
        NSLog(@"tanay------%@",dic);
        NSString *cpv_value;
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
            //  cpv_value=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
            //  courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
            cpv_value=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"cpv_id"]];
            
        }
        
        else
        {
            
            
            // coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
            //  courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
            cpv_value=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
            //s_lbl.text=str_cp1;
            
        }
        
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
        NSString *strt1=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
      
        
        NSLog(@"course ary----%@",marking_period);
        for (int i=0; i<[marking_period count]; i++) {
            
            
            if ([strt1 isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"id"]]) {
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
        
        NSString *str_t;
        
        if (t==true) {
            
       
            str_t=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
            
            
        }
        
        else
        {
          
            str_t=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"id"]];
            
        }
        
        
        
        NSString *cpid=[allvalue objectForKey:@"CPV_ID"];
        NSString *periodid=[allvalue objectForKey:@"PERIOD_ID"];
        
        
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    NSString * str111 = [Base64 encode:data];
    str111=[arrData JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);

    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
  
    NSString *post = [NSString stringWithFormat:@"student_attendanceArr=%@",str111];
    
    NSLog(@"post = %@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    //NSString *urlStr = [NSString stringWithFormat:@"http://localhost/tanay/customer_information.php?id=%d",[self.strCustomer_ID  intValue]];
    NSString *urlStr = [NSString stringWithFormat:@"/save_attendance.php?staff_id=%@&cpv_id=%@&mp_id=%@&date=%@",staff_id,cpid,periodid,str_date];
  
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
  //  UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"atten"];
  attendence *obj=[storyboard instantiateViewControllerWithIdentifier:@"atten"];
     obj.dic=dic;
    obj.dic_techinfo=dic_techinfo;
    [self.navigationController pushViewController:obj animated:NO];
    
    
    
    }
    
    
  
    
    
}
#pragma mark Tabbar
-(IBAction)home:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    [self.navigationController pushViewController:vc animated:NO];
}

-(IBAction)thirdbutton:(id)sender
{
    NSLog(@"third");
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


-(void)tabledata
{
    
    mtable.tableFooterView=[[UIView alloc]init];
    




}

-(void)pickerDoneClicked1

{
    NSLog(@"Done Clickedhh");
    
    [currentSchool resignFirstResponder];
     [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
     [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField !=courseperiodName) {
        [self animateTextField:coursePeriod up:YES];
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField !=courseperiodName) {
        [self animateTextField:coursePeriod up:NO];
    }

    
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
    
   
    NSLog(@"ATTEN_CODE------------%@",[self.atten_code objectAtIndex:indexPath.row]);
    NSLog(@"ATTEN_ID------------%@",[[data12 objectAtIndex:indexPath.row]objectForKey:@"STUDENT_ID"]);
 
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
      //  int b=[[[data12 objectAtIndex:indexPath.row]objectForKey:@"STUDENT_ID"]intValue];
        
       cell.lbl_id.text=[NSString stringWithFormat:@"ID:%@",[[data12 objectAtIndex:indexPath.row]objectForKey:@"STUDENT_ID"]];
      //  cell.lbl_id.text=[NSString stringWithFormat:@"%d",b];
        cell.lbl_name.text=[[self.data12 objectAtIndex:indexPath.row]objectForKey:@"FULL_NAME"];
        NSString *str_id=[atten_code objectAtIndex:indexPath.row];
     //    NSString *str_id1=[arr_data_code objectAtIndex:indexPath.row];
        NSLog(@"str---%@",str_id);
        if ([str_id isEqualToString:@"1"]) {
        
            
            cell.atten.text= @"P";       //[arr_data objectAtIndex:indexPath.row];
            
        }
      else if  ([str_id isEqualToString:@"2"]) {
         cell.btn.backgroundColor=[UIColor colorWithRed:212.0/255.0f green:50.0/255.0f blue:53.0/255.0f alpha:1.0f];
          
            cell.atten.text= @"A";  //[arr_data objectAtIndex:indexPath.row];
            
        }
        
      else if  ([str_id isEqualToString:@"3"]) {
        //  cell.btn.backgroundColor=[UIColor colorWithRed:249.0/255.0f green:135.0/255.0f blue:0.0/255.0f alpha:1.0f];
              cell.btn.backgroundColor=[UIColor colorWithRed:68.0/255.0f green:127.0/255.0f blue:0.0/255.0f alpha:1.0f];
          cell.atten.text=@"T";//[arr_data objectAtIndex:indexPath.row];
          
      }
        
        else
        {
        
            cell.btn.backgroundColor=[UIColor colorWithRed:68.0/255.0f green:127.0/255.0f blue:0.0/255.0f alpha:1.0f];
             cell.atten.text=@"L";//[arr_data objectAtIndex:indexPath.row];
        
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    attendence * vc = [storyboard instantiateViewControllerWithIdentifier:@"atten"];
    vc.dic=dic;
    vc.dic_techinfo=dic_techinfo;
    
    
    
    
    [self.navigationController pushViewController:vc animated:NO];

    
}
@end
