//
//  CourseManagerCourse.m
//  openSiS
//
//  Created by os4ed on 1/12/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "CourseManagerCourse.h"
#import "CourseManagerSubject.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "CourseManagerCourseCell.h"
#import "CourseManagerCourse.h"
#import "CourseManagerPeriod.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface CourseManagerCourse ()
@property (strong, nonatomic) IBOutlet UITableView *table_v;
@property (strong, nonatomic) IBOutlet UIView *view_blue_sub;
@property (strong, nonatomic) IBOutlet UILabel *lbl_subtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_blueheader;

@property (strong, nonatomic) IBOutlet UITextField *text_blueheader;
@end

@implementation CourseManagerCourse

{
    NSMutableArray *array_subjects;
    UIPickerView *selectcustomerpicker;
    NSMutableArray *array_forpicker;
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
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    self.lbl_blueheader.text=self.str_header_lbl;
    array_subjects = [[NSMutableArray alloc] init];
    [self dodesigns:self.view_blue_sub];
    [self loaddata];
    self.table_v.tableFooterView = [[UIView alloc]init];
    
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


-(void)loaddata1
{
    // NSString *inbox=@"inbox";
    
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/course_manager.php?staff_id=2&school_id=1&syear=2015&mp_id=17&view_type=subject&subject_id=&course_id=&cp_id=
    
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/course_manager.php?staff_id=2&school_id=1&syear=2015&mp_id=17&view_type=course&subject_id=1&course_id=&cp_id=
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF = [NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K = [DF objectForKey:@"iphone"];
    NSString *school_id1 = [NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id = [NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/course_manager.php?staff_id=%@&school_id=%@&syear=%@&mp_id=%@&view_type=course&subject_id=%@&course_id=&cp_id=",STAFF_ID_K,school_id1,year_id,mp_id,self.subject_id];
    
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
        
        
        NSString *slectedSub = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_subject"]];

        array_forpicker = [[NSMutableArray alloc]init];
        array_forpicker = [dictionary1 objectForKey:@"subjects"];
        
        for (int i =0; i < array_forpicker.count; ++i) {
            NSString *temp = [[array_forpicker objectAtIndex:0] objectForKey:@"SUBJECT_ID"];
            if ([temp isEqualToString:slectedSub]) {
                self.lbl_blueheader.text = [[array_forpicker objectAtIndex:0] objectForKey:@"TITLE"];
            }
        }
        
        
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        
        if([str_123 isEqualToString:@"1"])
        {
            array_subjects = [dictionary1 objectForKey:@"courses"];
            self.lbl_subtitle.text = [NSString stringWithFormat:@"Courses (%lu)", (unsigned long)array_subjects.count];
            [self.table_v reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array_subjects.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseManagerCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseManagerCourseCell"];
    
    cell.lbl_subName.text = [self nullChecker:[NSString stringWithFormat:@"%@", [[array_subjects objectAtIndex:indexPath.row] objectForKey:@"TITLE"]]];
    cell.lbl_count.text = [self nullChecker:[NSString stringWithFormat:@"%@", [[array_subjects objectAtIndex:indexPath.row] objectForKey:@"PERIOD_COUNT"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"schoolinfo" bundle:[NSBundle mainBundle]];
    CourseManagerPeriod *obj  = [sb instantiateViewControllerWithIdentifier:@"CourseManagerPeriod"];
    obj.course_id = [self nullChecker:[NSString stringWithFormat:@"%@", [[array_subjects objectAtIndex:indexPath.row] objectForKey:@"COURSE_ID"]]];
    obj.subject_id = self.subject_id;
    
    obj.str_header_lbl=[self nullChecker:[NSString stringWithFormat:@"%@", [[array_subjects objectAtIndex:indexPath.row] objectForKey:@"TITLE"]]];
    [self.navigationController pushViewController:obj animated:YES];
    
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
    [self loaddata];
    
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
        return [[array_forpicker objectAtIndex:row] objectForKey:@"TITLE"];
    }
    
    return nil;
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        self.text_blueheader.text =(NSString*)[[array_forpicker objectAtIndex:row] objectForKey:@"TITLE"];
        self.lbl_blueheader.text = (NSString*)[[array_forpicker objectAtIndex:row] objectForKey:@"TITLE"];
        self.subject_id = [[array_forpicker objectAtIndex:row] objectForKey:@"SUBJECT_ID"];

        //str_selectedgroupID = (NSString*)[[array_forpicker objectAtIndex:row] objectForKey:@"id"];
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
