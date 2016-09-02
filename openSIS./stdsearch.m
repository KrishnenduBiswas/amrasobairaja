//
//  StudentScheduleController.m
//  openSiS
//
//  Created by os4ed on 12/3/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "StudentScheduleController.h"
#import "TeacherDashboardViewController.h"
#import "AdvancedStudentScheduleController.h"
#import "Student.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "SettingsMenu.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "stdsearch.h"
@interface stdsearch ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *text_lastname, *text_firstname, *text_studentid, *text_altid, *text_streetaddress, *text_city, *text_state, *text_postcode, *text_grade, *text_activity;

@property (weak, nonatomic) IBOutlet UISwitch *switch_includeInactive;
@property (weak, nonatomic) IBOutlet UIButton *button_save;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UIView *view_lastname, *view_firstname, *view_studentid, *view_altid, *view_streetaddress, *view_city, *view_state, *view_postcode, *view_grade, *view_activity;

@property(strong, nonatomic) NSString *senderString;


- (IBAction)action_save:(id)sender;

- (IBAction)advancedSearch:(id)sender;

@end

@implementation stdsearch
{
    UIPickerView *picker1, *picker2;
    NSMutableArray *array_pick1, *array_pick2;
    NSString *grade_id,*activity_id;
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
    
    array_pick1 = [[NSMutableArray alloc]init];
    array_pick2 = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    [self.scroll setContentSize:CGSizeMake(self.scroll.frame.size.width, self.button_save.frame.origin.y + 80)];//
    grade_id = @""; activity_id = @"";
    [self loaddata];
    [self loadPicker1];
    [self loadPicker2];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
}
#pragma mark---Settings

-(IBAction)settings:(id)sender
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self dodesignsforTextViews:self.view_activity];
    [self dodesignsforTextViews:self.view_altid];
    [self dodesignsforTextViews:self.view_city];

    
    [self dodesignsforTextViews:self.view_firstname];
    [self dodesignsforTextViews:self.view_grade];
    [self dodesignsforTextViews:self.view_lastname];
    
    
    [self dodesignsforTextViews:self.view_postcode];
    [self dodesignsforTextViews:self.view_state];
    [self dodesignsforTextViews:self.view_streetaddress];
    
    
    [self dodesignsforTextViews:self.view_studentid];
    
}

#pragma mark - picker DataLoad Webservices

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
-(void)loaddata1
{
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/view_schedule_search.php?staff_id=2&syear=2015&school_id=1
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *str_school_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/view_schedule_search.php?staff_id=%@&syear=%@&school_id=%@",STAFF_ID_K,str_school_year,school_id123456];
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
       
        array_pick1 = [dictionary1 objectForKey:@"grade_data"];
        array_pick2 = [dictionary1 objectForKey:@"activity_data"];
        
        [picker1 reloadAllComponents];
        [picker2 reloadAllComponents];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [operation start];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



#pragma mark - Designs

- (void)dodesignsforTextViews:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:2.0f];
    disview.clipsToBounds = YES;
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

- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)gettheString
{
    self.senderString = @"";
    
    if (self.text_lastname.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&last=%@",self.senderString,self.text_lastname.text];
    }
    
    if (self.text_firstname.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&first=%@",self.senderString,self.text_firstname.text];
    }
    
    if (activity_id.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&activity_id=%@",self.senderString,activity_id];
    }
    
    if (self.text_altid.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&altid=%@",self.senderString,self.text_altid.text];
    }
    
//    if (self.text_city.text.length > 0) {
//        self.senderString = [NSString stringWithFormat:@"%@&city=%@",self.senderString,self.text_city.text];
//    }
    
    if (grade_id.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&grade=%@",self.senderString,grade_id];
    }
    
//    if (self.text_postcode.text.length > 0) {
//        self.senderString = [NSString stringWithFormat:@"%@&%@",self.senderString,self.text_postcode.text];
//    }
    
//    if (self.text_state.text.length > 0) {
//        self.senderString = [NSString stringWithFormat:@"%@&%@",self.senderString,self.text_state.text];
//    }
    
    if (self.text_streetaddress.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&addr=%@",self.senderString,self.text_streetaddress.text];
    }
    
    if (self.text_studentid.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&stuid=%@",self.senderString,self.text_studentid.text];
        
    }
    
    NSLog(@"The Parameter String: %@", self.senderString);
    return self.senderString;
}



- (IBAction)action_save:(id)sender
{
    
    
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
    Student *slc = [[Student alloc]init];
    slc = [sb instantiateViewControllerWithIdentifier:@"tstudentlist"];
    slc.senderString = [self gettheString];
    
    [self.navigationController pushViewController:slc animated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)advancedSearch:(id)sender
{
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AdvancedStudentScheduleController *assc = [[AdvancedStudentScheduleController alloc]init];
    assc = [sb instantiateViewControllerWithIdentifier:@"studentscheduleadvanced"];
    assc.senderString = [self gettheString];
    
    NSLog(@"the parameter string Simple Search: %@", [self gettheString]);
    [self.navigationController pushViewController:assc animated:YES];
}


-(void)loadPicker1{
    
    picker1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker1  .delegate = self;
    picker1 .dataSource = self;
    
    [ picker1  setShowsSelectionIndicator:YES];
   // picker1.tag=3;
    self.text_grade.inputView = picker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.text_grade.inputAccessoryView = mypickerToolbar;
    
}
-(void)loadPicker2{
    
    picker2 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker2  .delegate = self;
    picker2 .dataSource = self;
    
    [ picker2  setShowsSelectionIndicator:YES];
    // picker1.tag=3;
    self.text_activity.inputView = picker2;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.text_activity.inputAccessoryView = mypickerToolbar;
    
}

- (void)dismisspicker
{
    [self.text_activity resignFirstResponder];
    [self.text_grade resignFirstResponder];
    
}

#pragma mark - pickerview delegate datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == picker1) {
        return array_pick1.count;
    }
    else
    {
        return array_pick2.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == picker1) {
        return [NSString stringWithFormat:@"%@",[[array_pick1 objectAtIndex:row]objectForKey:@"TITLE"]];
    }
    else
    {
        return [NSString stringWithFormat:@"%@",[[array_pick2 objectAtIndex:row]objectForKey:@"TITLE"]];
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == picker1) {
        self.text_grade.text = [NSString stringWithFormat:@"%@",[[array_pick1 objectAtIndex:row]objectForKey:@"TITLE"]];
        grade_id = [NSString stringWithFormat:@"%@",[[array_pick1 objectAtIndex:row]objectForKey:@"ID"]];
        
    }
    else
    {
        self.text_activity.text = [NSString stringWithFormat:@"%@",[[array_pick2 objectAtIndex:row]objectForKey:@"TITLE"]];
        activity_id = [NSString stringWithFormat:@"%@",[[array_pick2 objectAtIndex:row]objectForKey:@"ID"]];
    }

}
@end
