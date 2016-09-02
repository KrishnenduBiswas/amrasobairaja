//
//  S_SearchmemberViewController.m
//  openSiS
//
//  Created by os4ed on 5/5/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "S_SearchmemberViewController.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "ResultGroupMemberController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "S_resultViewController.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"


@interface S_SearchmemberViewController ()
{
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
}
@property (strong, nonatomic) IBOutlet UIView *view_lastname;
@property (strong, nonatomic) IBOutlet UITextField *text_lastname;
@property (strong, nonatomic) IBOutlet UIView *view_firstname;
@property (strong, nonatomic) IBOutlet UITextField *text_firstname;
@property (strong, nonatomic) IBOutlet UIView *view_username;
@property (strong, nonatomic) IBOutlet UITextField *text_username;
@property (strong, nonatomic) IBOutlet UIView *view_profile;
@property (strong, nonatomic) IBOutlet UITextField *text_profile;
@property (strong, nonatomic) IBOutlet UISwitch *switch_searchallschools;
@property (strong, nonatomic) IBOutlet UISwitch *switch_includedisableduser;
@end

@implementation S_SearchmemberViewController
{
    UIPickerView *selectcustomerpicker;
    NSMutableArray *array_profile;
    NSString *selected_profileID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    array_profile = [[NSMutableArray alloc]init];;
    
    [self design:self.view_firstname];
    [self design:self.view_lastname];
    [self design:self.view_profile];
    [self design:self.view_username];
    [self loaddata];
    [self courseperiod123];

}

-(void)loaddata
{
    //  transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
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
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/search_group_member.php?staff_id=2
    
     AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_search_group_member.php?student_id=%@", student_id];
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
        
        
        array_profile = [dictionary1 objectForKey:@"profile"];
        self.text_profile.text = [[array_profile objectAtIndex:0] objectForKey:@"TITLE"];
        selected_profileID = [[array_profile objectAtIndex:0] objectForKey:@"ID"];
        
        [selectcustomerpicker reloadAllComponents];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //transparentView.hidden=NO;
        NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



- (IBAction)action_Search:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
    S_resultViewController *rgmc = [sb instantiateViewControllerWithIdentifier:@"grpresult"];
    rgmc.group_id = self.group_id;
    rgmc.str_last = self.text_lastname.text;
    rgmc.str_first = self.text_firstname.text;
    rgmc.str_usr = self.text_username.text;
    rgmc.str_profile = selected_profileID;
    
    if (self.switch_includedisableduser.on) {
        rgmc.str_disusr = @"Y";
    }
    if (self.switch_searchallschools.on) {
        rgmc.str_allsch = @"Y";
    }
    
    [self.navigationController pushViewController:rgmc animated:YES];
    
    
    
}


-(IBAction)home:(id)sender
{
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SdashboardViewController *home=[[SdashboardViewController alloc]init];
    home=[sb instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:home animated:NO];
    
    
    
    
    
}




-(void)design:(UIView*)obj
{
    
    obj.layer.borderWidth =  1.0f;
    obj.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [obj.layer setCornerRadius:3.5f];
    obj.clipsToBounds = YES;
}


-(void)alertmsg:(NSString*)msg
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}



- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Tabbar

-(IBAction)report:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    S_ReportViewController * report=[[S_ReportViewController alloc]init];
    report=[sb instantiateViewControllerWithIdentifier:@"rprt"];
    
    //report.sel_mp=period123;
    
    
    [self.navigationController pushViewController:report animated:YES];
    
    
    
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

-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    self.text_profile.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_profile.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}
-(void)pickerDoneClicked1
{
    
    //    if ([term_flag isEqualToString:@"1"]) {
    //        courseperiodName.text=inbox_data;
    //
    //
    //    }
    //
    //    else
    //    {
    //
    //
    //    }
    
    
    [self.text_profile resignFirstResponder];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    return array_profile.count;
    
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return [[array_profile objectAtIndex:row] objectForKey:@"TITLE"];
    
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    self.text_profile.text = [[array_profile objectAtIndex:row] objectForKey:@"TITLE"];
    selected_profileID = [[array_profile objectAtIndex:row] objectForKey:@"ID"];
}


@end
