//
//  AddGroupController.m
//  openSiS
//
//  Created by os4ed on 1/4/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "P_AddGroupController.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"

@interface P_AddGroupController ()
{
     NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
}
@property (strong, nonatomic) IBOutlet UITextField *text_title;
@property (strong, nonatomic) IBOutlet UITextField *text_final_grade;
@property (strong, nonatomic) IBOutlet UIView *view_title;
@property (strong, nonatomic) IBOutlet UIView *view_finalgrade;
@property(strong,nonatomic)IBOutlet UILabel *percent_grade;
@property(strong,nonatomic)IBOutlet UILabel *percent_total,*percent_lbl;

@property(strong,nonatomic)IBOutlet UIView *view_line,*view_line1;


@property (strong, nonatomic)NSString *weight_value;
- (IBAction)action_save:(id)sender;
- (IBAction)action_back:(id)sender;

@end

@implementation P_AddGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self design:self.view_title];
    [self design:self.view_finalgrade];
    
    
    
    
}


-(void)design:(UIView*)obj
{
    
    obj.layer.borderWidth =  1.0f;
    obj.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [obj.layer setCornerRadius:3.5f];
    obj.clipsToBounds = YES;
    
}
- (IBAction)action_save:(id)sender {
    
    
    if ([self.text_title.text length]<1) {
        [self alertmsg:@"Enter Group Name"];
    }
    
    else if ([self.text_final_grade.text length]<1)
    {
        [self alertmsg:@"Enter Group Description"];
    }
    
    else
        
    {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(savedata) withObject:nil afterDelay:2];
            });
        });
        
    }
}


-(void)savedata
{
   //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=add_grp_submit&txtGrpName=test group&txtGrpDesc=
    
    // [AFJSONResponseSerializer serializer];
    NSString *title_text1=[NSString stringWithFormat:@"%@",self.text_title.text];
    NSString *desc=[NSString stringWithFormat:@"%@",self.text_final_grade.text];
   // NSString *group_id = [NSString stringWithFormat:@"%@",[self.mainDict objectForKey:@"GROUP_ID"]];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];

    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_message_group.php?parent_id=%@&student_id=%@&syear=%@&action_type=add_grp_submit&txtGrpName=%@&txtGrpDesc=%@",parentid,student_id,s_year,title_text1,desc];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    NSString *mainurlstr = [url12 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:mainurlstr];
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
            
            [self action_back:nil];
            
        }
        
        
        else
        {
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        // transparentView.hidden=NO;
        NSLog(@"ok----");
        //        [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
    [self.navigationController pushViewController:mvc animated:NO];
}
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


@end