//
//  StudentScheduleViewController.m
//  openSiS
//
//  Created by os4ed on 12/10/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "StudentScheduleViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "StudentScheduleViewCell.h"
#import "WeekViewController.h"
#import "MonthViewController.h"
#import "coursecat.h"
#import "ccc.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface coursecat ()<UITableViewDataSource,UITabBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) NSString *str_date;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *view_mon_day_yr;
@property (strong, nonatomic) IBOutlet UILabel *label_date;
@property (strong, nonatomic) IBOutlet UITextField *text_mon_day_yr;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (strong, nonatomic) IBOutlet UIView *view_blackDate;

@end

@implementation coursecat
{
    NSMutableArray *ary;
    UIPickerView *picker1;
    NSMutableArray *arr_picker;
    
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


- (void)viewDidLoad {
    [super viewDidLoad];
    cou_id=@"";
    sub_id=@"";
    mp_id=@"";
    [self loadPicker2];
    [self loadPicker3];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    
    [view_cal.layer setCornerRadius:1.0f];
    view_cal.clipsToBounds = YES;
    [view_cal.layer setBorderWidth:1.0f];
    view_cal.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    ary = [[NSMutableArray alloc]init];
    
    [view_assign.layer setBorderWidth:1.0f];
    view_assign.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
    
    [view_period.layer setBorderWidth:1.0f];
    view_period.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
    
    NSDate *date = [NSDate date];
    self.str_date = [ self convertDate:date];
    
    
    arr_picker = [[NSMutableArray alloc]init];
    
    [self showdateinLabel:self.str_date];
    [self dodesignsforTextViews:self.view_mon_day_yr];
    [self loadPicker1];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loaddata];
    // txt_cal.text=[NSString stringWithFormat:@"%@",[array_title objectAtIndex:0]];
    self.table.tableFooterView = [[UIView alloc]init];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    self.view_blackDate.hidden = YES;
     self.text_mon_day_yr.text = @"Date";
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
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:3.0];
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

  //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/course_catalog.php?staff_id=2&school_id=1&syear=2015&mp_id=&subject_id=&course_id=
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
   // NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/course_catalog.php?staff_id=%@&school_id=%@&syear=%@&mp_id=%@&subject_id=%@&course_id=%@",STAFF_ID_K,school_id123456,str_school_year,mp_id,sub_id,cou_id];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"schedule_success"]];
        NSLog(@"success is: -----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            [self.table setHidden:NO];
            [label_nodata setHidden:YES];
            ary = [dictionary1 objectForKey:@"schedule_data"];
         
            
            
            [self.table reloadData];
            
        }
        else
        {
            [self.table setHidden:YES];
            [label_nodata setHidden:NO];
         //   UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Not Found" message:[dictionary1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         //   [alrt show];
        }
        
       
        
          arr_picker=[dictionary1 objectForKey:@"mp_data"];
    
  //      NSString *str_selected_mp=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_mp"]];
   //      NSString *str_selected_sub=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_subject"]];
     //      NSString *str_selected_cou=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_course"]];
      //  if ([str_selected_mp isEqualToString:mp_id]||[str_selected_sub isEqualToString:@""]||[str_selected_cou isEqualToString:@""]) {
            
           
        //mp_id=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_mp"]];
     ///   sub_id=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_subject"]];
       //  cou_id=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_course"]];
       //   NSMutableDictionary *mp=[[NSMutableDictionary alloc]init];

        
        if ([arr_picker count]>0) {
            array_title = [[NSMutableArray alloc] init];
            array_id= [[NSMutableArray alloc] init];
            for (int i = 0; i<[arr_picker count]; i++) {
                NSDictionary *dic15 = [arr_picker objectAtIndex:i];
                [array_title  addObject:[dic15 objectForKey:@"TITLE"]];
                [array_id addObject:[dic15 objectForKey:@"MARKING_PERIOD_ID"]];
                
                
               
                
//                if ([mp_id isEqual:[[arr_picker objectAtIndex:i]objectForKey:@"MARKING_PERIOD_ID"]]) {
//                    mp=[arr_picker objectAtIndex:i];
//                    a=true;
//                    break;
//                }
//                
//                else
//                {
//                
//                    a=false;
//                    break;
//                }
                
                
            }
           //  txt_cal.text=[NSString stringWithFormat:@"%@",[array_title objectAtIndex:0]];
            view2.hidden=YES;
            view3.hidden=YES;
         //   -20,62,344,455
         //   self.table.frame=CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y-40, self.table.frame.size.width, self.table.frame.size.height+90);
             // self.table.frame=CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y-50, self.table.frame.size.width, 455);
            
        }
        
       
        else {
            NSLog(@"No  list");
            view2.hidden=NO;
            view3.hidden=NO;
        }
        
        
        
        
//        if (a==true) {
//            
//            
//            txt_cal.text=[mp objectForKey:@"Title"];
//             mp_id=[NSString stringWithFormat:@"%@",[mp objectForKey:@"MARKING_PERIOD_ID"]];
//        }
//        
//        
//        else
//        {
//        txt_cal.text=@"ALL";
//        
//        }
         NSMutableDictionary *sub_dic=[[NSMutableDictionary alloc]init];
        
            sub=[[NSMutableArray alloc]init];
            sub=[dictionary1 objectForKey:@"sub_data"];
            if ([sub count]>0) {
                sub_title= [[NSMutableArray alloc] init];
               sub_id1= [[NSMutableArray alloc] init];
                for (int i = 0; i<[sub count]; i++) {
                    NSDictionary *dic15 = [sub objectAtIndex:i];
                    [sub_title  addObject:[dic15 objectForKey:@"TITLE"]];
                    [sub_id1 addObject:[dic15 objectForKey:@"SUBJECT_ID"]];
                    
//                    if ([sub_id isEqual:[[sub objectAtIndex:i]objectForKey:@"SUBJECT_ID"]]) {
//                        sub_dic=[sub objectAtIndex:i];
//                        b=true;
//                        break;
//                    }
//                    
//                    else
//                    {
//                        
//                        b=false;
//                        break;
//                    }

                }
              //  txt_assign.text=[NSString stringWithFormat:@"%@",[sub_title objectAtIndex:0]];
                view2.hidden=NO;
               // -20,97,344,420
                
            //    self.table.frame=CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y-25, self.table.frame.size.width, self.table.frame.size.height+45);
            }
            
            
            else {
                NSLog(@"No  list");
                
                view3.hidden=YES;
            }
            
//            
//        if (b==true) {
//            
//            
//            txt_assign.text=[mp objectForKey:@"Title"];
//            sub_id=[NSString stringWithFormat:@"%@",[sub_dic objectForKey:@"SUBJECT_ID"]];
//        }
//        
//        
//        else
//        {
//            
//            
//        }
            //  NSMutableDictionary *cou_dic=[[NSMutableDictionary alloc]init];
        
            period=[[NSMutableArray alloc]init];
            period=[dictionary1 objectForKey:@"course_data"];
            if ([period count]>0) {
                period_title= [[NSMutableArray alloc] init];
                period_id= [[NSMutableArray alloc] init];
                for (int i = 0; i<[period count]; i++) {
                    NSDictionary *dic15 = [period objectAtIndex:i];
                    [period_title  addObject:[dic15 objectForKey:@"TITLE"]];
                    [period_id addObject:[dic15 objectForKey:@"COURSE_ID"]];
//                    if ([cou_id isEqual:[[sub objectAtIndex:i]objectForKey:@"COURSE_ID"]]) {
//                        cou_dic=[period objectAtIndex:i];
//                        c=true;
//                        break;
//                    }
//                    
//                    else
//                    {
//                        
//                        c=false;
//                        break;
//                    }
                    

                }
               // txt_assign.text=[NSString stringWithFormat:@"%@",[sub_title objectAtIndex:0]];
                view3.hidden=NO;
              //  -20,132,344,385
                // self.table.frame=CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y, self.table.frame.size.width, self.table.frame.size.height);
                
            }
            
            
            else {
                NSLog(@"No  list");
                
                view3.hidden=YES;
            }
//        if (c==true) {
//            
//            
//            txt_period.text=[mp objectForKey:@"Title"];
//            cou_id=[NSString stringWithFormat:@"%@",[cou_dic objectForKey:@"COURSE_ID"]];
//        }
//        
//        
//        else
//        {
//            
//            
//        }

        
    //    }
    /*    else if ([str_selected_mp isEqualToString:@""]||[str_selected_sub isEqualToString:@""]||[str_selected_cou isEqualToString:@""]) {
            
            view2.hidden=NO;
            view3.hidden=YES;
        }*/

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.table setHidden:YES];
        [label_nodata setHidden:NO];

    }];
    [operation start];
    
  [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)home:(id)sender
{
    
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // NSLog(@"dic===========%@",dic);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    // vc.dic=dic;
    // vc.dic_techinfo=dic_techinfo;
    // appDelegate.dic=dic;
    // appDelegate.dic_techinfo=dic_techinfo;
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ary.count;
}
- (ccc *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //static NSString *CellIdentifier = @"studentscheduleviewcell";
    
    //static NSString *cellid = @"cell";
    //UITableViewCell *cell;
    ccc *cell = [tableView dequeueReusableCellWithIdentifier:@"ccc"];
//    if (cell == nil) {
//        cell = (StudentScheduleViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"CellTableViewCell" owner:self options:nil] objectAtIndex:0];
//        
//        
//    }
    
    cell.lbl_title.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"COURSE"]];
    cell.lbl_period.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TEACHER"]];
    cell.lbl_room.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"MP"]];
    cell.lbl_term.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"LOCATION"]];
    
    NSString *timestr = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"PERIOD_TIME"]];
    cell.lbl_time.text=timestr;
    cell.lbl_time2.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"PERIOD"]];
   /* NSRange rr = [timestr rangeOfString:@","];
    
    if (rr.length == 0) {
        cell.lbl_time.text= timestr;
        cell.lbl_time2.text = @"";
    }
    else
    {
        cell.lbl_time.text = [timestr substringToIndex:rr.location];
        cell.lbl_time2.text = [timestr substringFromIndex:rr.location+1];
    }*/
    
    NSArray *array_days = [[NSArray alloc]init];
    array_days = [[ary objectAtIndex:indexPath.row] objectForKey:@"DAYS_OF_WEEK"];
    
    NSString *status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:0] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day1.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day1.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:1] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day2.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day2.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:2] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day3.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day3.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:3] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day4.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day4.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:4] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day5.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day5.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:5] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day6.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day6.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    status = [NSString stringWithFormat:@"%@", [[array_days objectAtIndex:6] objectForKey:@"status"]];
    
    if ([status isEqualToString:@"1"]) {
        cell.day7.textColor = [UIColor colorWithRed:1.000f green:0.400f blue:0.000f alpha:1.00f];
    }
    else
    {
        cell.day7.textColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.00f];
    }
    
    
    
    
    
    
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
    txt_cal.inputView = picker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    txt_cal.inputAccessoryView = mypickerToolbar;
    
}


-(void)loadPicker2{
    
    picker1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker1  .delegate = self;
    picker1 .dataSource = self;
    
    [ picker1  setShowsSelectionIndicator:YES];
    picker1.tag=4;
    txt_assign.inputView = picker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker2)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    txt_assign.inputAccessoryView = mypickerToolbar;
    
}


-(void)loadPicker3{
    
    picker1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker1  .delegate = self;
    picker1 .dataSource = self;
    
    [ picker1  setShowsSelectionIndicator:YES];
    picker1.tag=5;
    txt_period.inputView = picker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker3)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    txt_period.inputAccessoryView = mypickerToolbar;
    
}



- (void)dismisspicker
{
    if ([flag isEqualToString:@"1"]) {
        txt_cal.text=show_title;
        NSLog(@"mp_id-------%@",mp_id);
        [self loaddata1];
        
        
    }
    else
    {
    
    
    }
    [txt_cal resignFirstResponder];
    
    
}

- (void)dismisspicker2
{
    if ([flag1 isEqualToString:@"1"]) {
        txt_assign.text=sub1_title;
        NSLog(@"mp_id-------%@",mp_id);
        [self loaddata1];
        
        
    }
    else
    {
        
        
    }
    [txt_assign resignFirstResponder];
    
    
}
- (void)dismisspicker3
{
    if ([flag2 isEqualToString:@"1"]) {
        txt_period.text=per_title;
        NSLog(@"mp_id-------%@",mp_id);
        [self loaddata1];
        
        
    }
    else
    {
        
        
    }
    [txt_period resignFirstResponder];
    
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if (pickerView.tag==3) {
        
        return array_title.count;
        
    }
    else if (pickerView.tag==4)
    {
    
        return sub_title.count;
    
    }
    
    else if (pickerView.tag==5)
    {
    
         return period_title.count;
    }
    
    
    return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    
    if (pickerView.tag==3) {
        
         return [array_title objectAtIndex:row];
        
    }
    else if (pickerView.tag==4)
    {
        
        return [sub_title objectAtIndex:row];
        
    }
    
    else if (pickerView.tag==5)
    {
        
        return [period_title objectAtIndex:row];
    }
    
    
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==3) {
        
    
   show_title = [array_title objectAtIndex:row];
    NSString *strC =(NSString *)[array_title objectAtIndex:row];
    mp_id= [array_id objectAtIndex:[array_title indexOfObjectIdenticalTo:strC]];
    flag=@"1";
    }
    if (pickerView.tag==4) {
        
        
       sub1_title = [sub_title objectAtIndex:row];
        NSString *strC =(NSString *)[sub_title objectAtIndex:row];
        sub_id= [sub_id1 objectAtIndex:[sub_title indexOfObjectIdenticalTo:strC]];
        flag1=@"1";
    }
    
    if (pickerView.tag==5) {
        
        
        per_title = [period_title objectAtIndex:row];
        NSString *strC =(NSString *)[period_title objectAtIndex:row];
        cou_id= [period_id objectAtIndex:[period_title indexOfObjectIdenticalTo:strC]];
        flag2=@"1";
    }
    
}

@end
