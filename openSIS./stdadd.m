//
//  MyInformationAddress.m
//  openSiS
//
//  Created by os4ed on 1/11/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "MyInformationAddress.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import <MapKit/MapKit.h>
#import "mapkitViewController.h"
#import "MyInformationGeneral.h"

#import "TeacherDashboardViewController.h"
#import "MyInformationAddress.h"
#import "MyInformationGeneral.h"
#import "MyInformationSchoolInfo.h"
#import "MyInformationCertification.h"
#import "stdadd.h"




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

#import "MyInformationCertification.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "goal.h"
#import "parents.h"
#import "comment.h"
#import "TeacherDashboardViewController.h"
#import "MyInformationAddress.h"
#import "MyInformationGeneral.h"
#import "MyInformationSchoolInfo.h"
#import "MyInformationCertificationCell.h"
#import "enroll.h"
@interface stdadd()
{
    IBOutlet UIView *VIEW_MAP;
}
@property (weak, nonatomic) IBOutlet UILabel *home_add;

@property (weak, nonatomic) IBOutlet UILabel *home_add1;


@property (weak, nonatomic) IBOutlet UILabel *home_city;

@property (weak, nonatomic) IBOutlet UILabel *home_state;


@property (weak, nonatomic) IBOutlet UILabel *home_postal;
@property (weak, nonatomic) IBOutlet UILabel *home_buspickup;

@property (weak, nonatomic) IBOutlet UILabel *home_pickdown;
@property (weak, nonatomic) IBOutlet UILabel *bus_no;

@property (weak, nonatomic) IBOutlet UILabel *lbl_TopTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Homezip;

@property (weak, nonatomic) IBOutlet UISwitch *mail_switch;





@property (strong, nonatomic) IBOutlet UIScrollView *scroll_content;



@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_menu;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_viewforSegment;


@property (weak, nonatomic) IBOutlet UIView *view_home_map;
@property (weak, nonatomic) IBOutlet UILabel *mail_add1;
@property (weak, nonatomic) IBOutlet UILabel *mail_add2;
@property (weak, nonatomic) IBOutlet UILabel *mail_city;
@property (weak, nonatomic) IBOutlet UILabel *mail_state;
@property (weak, nonatomic) IBOutlet UILabel *mail_postal;
@property (weak, nonatomic) IBOutlet UIView *view_mail_view;
@property (weak, nonatomic) IBOutlet UILabel *p_fname;
@property (weak, nonatomic) IBOutlet UILabel *p_lname;
@property (weak, nonatomic) IBOutlet UILabel *p_home_phone;
@property (weak, nonatomic) IBOutlet UILabel *p_w_phone;
@property (weak, nonatomic) IBOutlet UILabel *p_cell;
@property (weak, nonatomic) IBOutlet UILabel *p_email;
@property (weak, nonatomic) IBOutlet UILabel *p_custody_student;
@property (weak, nonatomic) IBOutlet UILabel *p_prtal;
@property (weak, nonatomic) IBOutlet UILabel *p_add1;
@property (weak, nonatomic) IBOutlet UILabel *p_add2;
@property (weak, nonatomic) IBOutlet UILabel *p_city;
@property (weak, nonatomic) IBOutlet UILabel *p_state;
@property (weak, nonatomic) IBOutlet UILabel *p_postal;
@property (weak, nonatomic) IBOutlet UISwitch *PRIMARY_SWITCH;


@property (weak, nonatomic) IBOutlet UILabel *s_fname;
@property (weak, nonatomic) IBOutlet UILabel *s_lname;

@property (weak, nonatomic) IBOutlet UILabel *s_w_phone;
@property (weak, nonatomic) IBOutlet UILabel *s_cell;
@property (weak, nonatomic) IBOutlet UILabel *s_email;
@property (weak, nonatomic) IBOutlet UILabel *s_custody;
@property (weak, nonatomic) IBOutlet UILabel *s_portal;
@property (weak, nonatomic) IBOutlet UISwitch *s_switch;
@property (weak, nonatomic) IBOutlet UILabel *s_add1;
@property (weak, nonatomic) IBOutlet UILabel *s_add2;
@property (weak, nonatomic) IBOutlet UILabel *s_city;
@property (weak, nonatomic) IBOutlet UILabel *s_state;
@property (weak, nonatomic) IBOutlet UILabel *s_home_phone;

@end

@implementation stdadd

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
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
//        stdadd*mia = [storyBoard instantiateViewControllerWithIdentifier:@"stdadd"];
//        mia.studentID=self.studentID;
//        mia.studentName=self.studentName;
//        [self.navigationController pushViewController:mia animated:NO];
    
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
        MystdInformationGeneral *slc = [[MystdInformationGeneral alloc]init];
        slc = [sb instantiateViewControllerWithIdentifier:@"MystdInformationGeneral"];
      
        
        [self.navigationController pushViewController:slc animated:YES];

        
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
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Student" bundle:[NSBundle mainBundle]];
        goal *mia = [storyBoard instantiateViewControllerWithIdentifier:@"goal"];
        mia.studentID=self.studentID;
        mia.studentName=self.studentName;
        [self.navigationController pushViewController:mia animated:YES];
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


-(IBAction)back:(id)sender
{
    
//    NSArray *ary = [self.navigationController viewControllers];
//    
//    [self.navigationController popToViewController:[ary objectAtIndex:3] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)OPENMAP:(id)sender
{
    
    
    NSString *str_address=[NSString stringWithFormat:@"%@ %@ %@",self.home_add.text,self.home_state.text,self.home_city.text];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
    mapkitViewController *obj = [sb instantiateViewControllerWithIdentifier:@"map"];
    obj.str_address=str_address;
    obj.str_name=sname.text;
    [self.navigationController pushViewController:obj animated:YES];
    
    NSLog(@"HELLOW");
    
}


-(IBAction)OPENMAP1:(id)sender
{
    
    
    NSString *str_address=[NSString stringWithFormat:@"%@ %@ %@",self.mail_add1.text,self.mail_state.text,self.mail_city];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
    mapkitViewController *obj = [sb instantiateViewControllerWithIdentifier:@"map"];
    obj.str_address=str_address;
    obj.str_name=sname.text;
    [self.navigationController pushViewController:obj animated:YES];
    
    NSLog(@"HELLOW");
    
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
    
    [self loaddata];
    self.segment_menu.selectedSegmentIndex=0       ;
    [self.scroll_viewforSegment setContentSize:CGSizeMake(self.segment_menu.frame.size.width, self.scroll_viewforSegment.frame.size.height)];
    
    [self.scroll_content setContentSize:CGSizeMake(self.scroll_content.frame.size.width, self.lbl_Homezip.frame.origin.y + 70)];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    
    UITapGestureRecognizer *mising= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OPENMAP:)];
    mising.numberOfTapsRequired = 1;
    
    //[self.view addGestureRecognizer:tapmainview];
    [self.view_home_map addGestureRecognizer:mising];
    
    
    
    
    UITapGestureRecognizer *mising1= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OPENMAP1:)];
    mising1.numberOfTapsRequired = 1;
    
    //[self.view addGestureRecognizer:tapmainview];
    [self.view_mail_view addGestureRecognizer:mising1];
    view_schoolname.layer.borderWidth = 1.0f;
    view_schoolname.layer.backgroundColor=[[UIColor lightGrayColor]CGColor ];
    view_schoolname.clipsToBounds = YES;
    [self courseperiod123];
    ary_data=[[NSMutableArray alloc]init ];
    ary_data_title=[[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ary_data=[appDelegate.dic objectForKey:@"School_list"];
    NSLog(@"ary data---%@",ary_data);
    
    
    NSMutableDictionary *dic16q=[[NSMutableDictionary alloc]init];
    NSString *strtq=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    
    
    for (int i=0; i<[ary_data count]; i++) {
        
        
        if ([strtq isEqual:[[ary_data objectAtIndex:i]objectForKey:@"id"]]) {
            dic16q=[ary_data objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16q);
            
            
            s=true;
            break;
        }
        
        else
        {
            //            txt_schoolname.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"title" ]];
            //             school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"id"]];
        }
        
    }
    
    if (s==true) {
        txt_schoolname.text=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"title"]];
        
        school_id=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"id"]];
        
    }
    else
    {
        
        txt_schoolname.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"title" ]];
        school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"id"]];
        
        
    }
    
    
    
    // school_year=[[dic objectForKey:@"Schoolyear_list"]mutableCopy];
    
    if ([ary_data count]>0) {
        ary_data_title = [[NSMutableArray alloc] init];
        ary_data_id= [[NSMutableArray alloc] init];
        for (int i = 0; i<[ary_data count]; i++) {
            NSDictionary *dic15 = [ary_data objectAtIndex:i];
            [ary_data_title  addObject:[dic15 objectForKey:@"title"]];
            [ary_data_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    
    // Do any additional setup after loading the view.
}

-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    txt_schoolname.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    txt_schoolname.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{    
    return ary_data_title.count;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return [ary_data_title objectAtIndex:row];
    
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    
    
    if (pickerView.tag==6) {
        
        
        
        
        
        inbox_data =(NSString *)[ary_data_title objectAtIndex:row];
        NSString *strC =(NSString *)[ary_data_title objectAtIndex:row];
        school_id= [ary_data_id objectAtIndex:[ary_data_title indexOfObjectIdenticalTo:strC]];
        flag=@"1";
        
        
    }
    
    
}

-(void)loaddata1
{
    // NSString *inbox=@"inbox";
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/teacher_info_tabs.php?staff_id=2&school_id=1&syear=2015
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"address_contact_success"]];
        NSLog(@"str_123-----%@",str_123);
        self.lbl_TopTitle.text = [NSString stringWithFormat:@"%@",self.studentName];
        if([str_123 isEqualToString:@"1"])
        {
            NSArray  *sinfo=[dictionary1 objectForKey:@"address_contact"];
            
            NSLog(@"address contact---%@",sinfo);
            NSArray *ary_home=[[sinfo objectAtIndex:0] objectForKey:@"HOME_ADDRESS"];
            
            NSArray *ary_mail=[[sinfo objectAtIndex:0] objectForKey:@"MAIL_ADDRESS"];
            
            
             NSArray *ary_primary=[[sinfo objectAtIndex:0] objectForKey:@"PRIMARY_EMERGENCY_CONTACT"];
            
            
                        NSLog(@"ary_home---%@",ary_home);
            self.home_add.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"ADDRESS"]]];
              self.home_add1.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"STREET"]]];
            
              self.home_state.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"STATE"]]];
            
             self.home_city.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"CITY"]]];
            
             self.home_postal.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
            
            
            self.home_buspickup.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"BUS_PICKUP"]]];
            self.home_pickdown.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"BUS_DROPOFF"]]];
            
            
              self.bus_no.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_home objectAtIndex:0] objectForKey:@"BUS_NO"]]];
            
            
            self.mail_add1.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_mail objectAtIndex:0] objectForKey:@"ADDRESS"]]];
            self.mail_add2.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_mail objectAtIndex:0] objectForKey:@"STREET"]]];
            
            self.mail_state.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_mail objectAtIndex:0] objectForKey:@"STATE"]]];
            
            self.mail_city.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_mail objectAtIndex:0] objectForKey:@"CITY"]]];
            
            self.mail_postal.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_mail objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
            NSString *STR_SWITCH_MAIL=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_mail objectAtIndex:0] objectForKey:@"SAME_AS_HOME_ADDR"]]];
            
            if ([STR_SWITCH_MAIL isEqualToString:@"Y"]) {
                [self.mail_switch isOn];
            }
            
            else
            {
                
                [self.mail_switch isOpaque];
                
            }


            
            self.p_add1.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"ADDRESS"]]];
            self.p_add2.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"STREET"]]];
            self.p_cell.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"CELL_PHONE"]]];
            self.p_city.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"City"]]];
            self.p_custody_student.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"CUSTODY"]]];
            self.p_email.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"EMAIL"]]];
            self.p_fname.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"FIRST_NAME"]]];
            self.p_home_phone.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"HOME_PHONE"]]];
            self.p_lname.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"LAST_NAME"]]];
            self.p_postal.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
           self.p_state.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"STATE"]]];
            self.p_w_phone.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"WORK_PHONE"]]];
            self.p_prtal.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"USER_NAME"]]];
            
            
            NSString *STR_SWITCH_PRIMARY=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"SAME_AS_HOME_ADDR"]]];
            
            if ([STR_SWITCH_PRIMARY isEqualToString:@"Y"]) {
                [self.PRIMARY_SWITCH isOn];
            }
            
            else
            {
            
                [self.PRIMARY_SWITCH isOpaque];
            
            }
         NSArray *sec=[[sinfo objectAtIndex:0] objectForKey:@"SECONDARY_EMERGENCY_CONTACT"];
        
        
        
        
        self.s_add1.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"ADDRESS"]]];
        self.s_add2.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"STREET"]]];
        self.s_cell.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"CELL_PHONE"]]];
        self.s_city.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"City"]]];
        self.s_custody.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"CUSTODY"]]];
        self.s_email.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"EMAIL"]]];
        self.s_fname.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"FIRST_NAME"]]];
       self.s_home_phone.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_primary objectAtIndex:0] objectForKey:@"HOME_PHONE"]]];
        self.s_lname.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"LAST_NAME"]]];
        self.lbl_Homezip.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
        self.s_state.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"STATE"]]];
        self.s_w_phone.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"WORK_PHONE"]]];
        self.s_portal.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"USER_NAME"]]];
        
        
        NSString *STR_SWITCH_PRIMARY12=[self nullChecker:[NSString stringWithFormat:@"%@",[[sec objectAtIndex:0] objectForKey:@"SAME_AS_HOME_ADDR"]]];
        
        if ([STR_SWITCH_PRIMARY12 isEqualToString:@"Y"]) {
            [self.s_switch isOn];
        }
        
        else
        {
            
            [self.s_switch isOpaque];
            
        }
    }
     
     
     
     
     
     
        else
        {
            
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


-(void)pickerDoneClicked1
{
    
    if ([flag isEqualToString:@"1"]) {
        
        txt_schoolname.text=inbox_data;
        NSLog(@"school id-----%@",school_id);
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
            });
        });
        
        
        
    }
    else
    {
        
    }
    
    [txt_schoolname resignFirstResponder];
}

#pragma mark - Tabbar


@end
