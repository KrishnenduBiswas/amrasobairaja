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
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface StudentScheduleViewController ()<UITableViewDataSource,UITabBarDelegate, UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) NSString *str_date;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *view_mon_day_yr;
@property (strong, nonatomic) IBOutlet UILabel *label_date;
@property (strong, nonatomic) IBOutlet UITextField *text_mon_day_yr;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker1;
@property (strong, nonatomic) IBOutlet UIView *view_blackDate;

@end

@implementation StudentScheduleViewController
{
    NSMutableArray *ary;
    UIPickerView *picker1;
    NSMutableArray *arr_picker;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ary = [[NSMutableArray alloc]init];
    
    NSDate *date = [NSDate date];
    self.str_date = [ self convertDate:date];
    
    
    arr_picker = [[NSMutableArray alloc]initWithObjects:@"Date",@"Week",@"Month", @"Year", nil];
    
    [self showdateinLabel:self.str_date];
    [self dodesignsforTextViews:self.view_mon_day_yr];
    [self loadPicker1];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loaddata];
    self.table.tableFooterView = [[UIView alloc]init];
    
    
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
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

    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/view_schedule.php?school_id=%@&syear=%@&staff_id=%@&mp_id=%@&student_id=%@&date=%@",school_id123456,str_school_year,STAFF_ID_K,mp_id,self.studentID,self.str_date];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
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
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Not Found" message:[dictionary1 objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alrt show];
        }
        
        
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
- (StudentScheduleViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //static NSString *CellIdentifier = @"studentscheduleviewcell";
    
    //static NSString *cellid = @"cell";
    //UITableViewCell *cell;
    StudentScheduleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentlistcell"];
//    if (cell == nil) {
//        cell = (StudentScheduleViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"CellTableViewCell" owner:self options:nil] objectAtIndex:0];
//        
//        
//    }
    
    cell.lbl_title.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TITLE"]];
    cell.lbl_period.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"PERIOD_PULLDOWN"]];
    cell.lbl_room.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"ROOM"]];
    cell.lbl_term.text=[NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TERM"]];
    
    NSString *timestr = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]objectForKey:@"TIME_PERIOD"]];
    
    NSRange rr = [timestr rangeOfString:@","];
    
    if (rr.length == 0) {
        cell.lbl_time.text= timestr;
        cell.lbl_time2.text = @"";
    }
    else
    {
        cell.lbl_time.text = [timestr substringToIndex:rr.location];
        cell.lbl_time2.text = [timestr substringFromIndex:rr.location+1];
    }
    
    NSArray *array_days = [[NSArray alloc]init];
    array_days = [[ary objectAtIndex:indexPath.row] objectForKey:@"DAYS"];
    
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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([self.text_mon_day_yr.text isEqualToString:@"Week"]) {
        WeekViewController *wv = [[WeekViewController alloc]init];
        wv = [sb instantiateViewControllerWithIdentifier:@"weekview"];
        wv.studentID = self.studentID;
        wv.studentName = self.studentName;
        [self.navigationController pushViewController:wv animated:YES];
    }
    else if ([self.text_mon_day_yr.text isEqualToString:@"Month"])
    {
        MonthViewController *wv = [[MonthViewController alloc]init];
        wv = [sb instantiateViewControllerWithIdentifier:@"month"];
        wv.studentID = self.studentID;
        wv.studentName = self.studentName;
        [self.navigationController pushViewController:wv animated:YES];

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
    
}

@end
