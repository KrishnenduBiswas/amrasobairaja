//
//  MyinfoViewController.m
//  openSiS
//
//  Created by os4ed on 4/7/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_MyinfoViewController.h"
#import "EnrollinfoViewController.h"
#import "AddressViewController.h"
#import "SettingViewController.h"

#import "AFNetworking.h"
#import "ip_url.h"
#import "AppDelegate.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"
#import "P_EnrollinfoViewController.h"
#import "P_AddressViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"
#import "P_GoalsViewController.h"
#import "P_CommentViewController.h"

@interface P_MyinfoViewController ()

@property (strong, nonatomic) IBOutlet UIView *contain_general;
@property (strong, nonatomic) IBOutlet UIView *contain_address;

@property (strong, nonatomic) IBOutlet UIView *contain_enroll;
@property (strong, nonatomic) IBOutlet UIView *view_buttonunderline;

@property (strong, nonatomic) IBOutlet UIButton *geninfo;
@property (strong, nonatomic) IBOutlet UIButton *enrollinfo;
@property (strong, nonatomic) IBOutlet UIButton *address;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_menu;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_viewforSegment;
@end

@implementation P_MyinfoViewController
{


    int currentwidth, currentheight;
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;

    
    
    

}


- (IBAction)action_segment:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]];
//        MyInformationGeneral *mia = [storyBoard instantiateViewControllerWithIdentifier:@"MyInformationGeneral"];
//        [self.navigationController pushViewController:mia animated:YES];
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_EnrollinfoViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_enroll1"];
        
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        
        
        
        [self.navigationController pushViewController:mia animated:NO];
    }
    else if (sender.selectedSegmentIndex == 2)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_AddressViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_address1"];
        
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        
        
        
        [self.navigationController pushViewController:mia animated:NO];
    }
    
    
    
    else if (sender.selectedSegmentIndex == 4)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_GoalsViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_goal"];
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        [self.navigationController pushViewController:mia animated:NO];
    }

    
    
    else if (sender.selectedSegmentIndex == 3)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_CommentViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_comments"];
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        [self.navigationController pushViewController:mia animated:NO];
    }

    
    
    
    
    
    
    
    
    
//    else if (sender.selectedSegmentIndex == 3)
//    {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]];
//        MyInformationSchoolInfo *mia = [storyBoard instantiateViewControllerWithIdentifier:@"MyInformationSchoolInfo"];
//        [self.navigationController pushViewController:mia animated:YES];
//    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    _segment_menu.selectedSegmentIndex=0;
    
    
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loaddata];
    
    
//    CGRect containfinal_rect = self.contain_address.frame;
//    containfinal_rect.origin.x = self.view.frame.size.width;
//    [self.contain_address setFrame:containfinal_rect];
//    currentwidth = self.view.frame.size.width;
//    currentheight = 5;
//    
//    
//    
//    CGRect containfinal_rect1 = self.contain_enroll.frame;
//    containfinal_rect1.origin.x = self.view.frame.size.width;
//    [self.contain_enroll setFrame:containfinal_rect1];
//    currentwidth = self.view.frame.size.width;
//    currentheight = 5;
    
    
//    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_general:)];
//    left.direction = UISwipeGestureRecognizerDirectionLeft;
//    left.numberOfTouchesRequired = 1;
//    [self.contain_general addGestureRecognizer:left];
//    
//    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_enroll:)];
//    right.direction = UISwipeGestureRecognizerDirectionRight;
//    right.numberOfTouchesRequired = 1;
//    [self.contain_enroll addGestureRecognizer:right];
//    
// 
//    
//    UISwipeGestureRecognizer *right1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_address:)];
//    left.direction = UISwipeGestureRecognizerDirectionRight;
//    left.numberOfTouchesRequired = 1;
//    [self.contain_address addGestureRecognizer:right1];
    
    
    [self.scroll_viewforSegment setContentSize:CGSizeMake(self.segment_menu.frame.size.width, self.scroll_viewforSegment.frame.size.height)];
    
    
    
}


-(void)loaddata
{

[MBProgressHUD showHUDAddedTo:self.view animated:YES];
dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        [self performSelector:@selector(loaddata1) withObject:nil afterDelay:2];
    });
});



}








-(void)loaddata1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    // student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];

    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_student_info.php?parent_id=%@&student_id=%@&school_id=%@&syear=%@",parentid,_st_id,_schoolid,_ssssyr];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"general_info_success"]];
        NSLog(@"str_123-----%@",str_123);
        
        
        if([str_123 isEqualToString:@"1"])
        {
            NSArray  *sinfo=[dictionary1 objectForKey:@"general_info"];
            NSLog(@"sinfo----%@",sinfo);
            stdname.text= [self nullChecker:[NSString stringWithFormat:@"%@,%@",[[sinfo objectAtIndex:0] objectForKey:@"FIRST_NAME"],[[sinfo objectAtIndex:0] objectForKey:@"LAST_NAME"]]];
            
            stdid.text=[self nullChecker:[NSString stringWithFormat:@"#%@",[[sinfo objectAtIndex:0] objectForKey:@"STUDENT_ID"]]];
            
            cname.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"COMMON_NAME"]]];
            dob.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"BIRTHDATE"]]];
            email.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"EMAIL"]]];
            gender.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"GENDER"]]];
            eth.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"ETHNICITY"]]];
            lang.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"PRIMARY_LANGUAGE"]]];
            ph.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"PHONE"]]];
            
            stdid2.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"STUDENT_ID"]]];
            
            altid.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"ALT_ID"]]];
            
            grd.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"GRADE_NAME"]]];
            
            
            NSURL*imgurl=[NSURL URLWithString:[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"PHOTO"]]]];
            
            NSData*data=[NSData dataWithContentsOfURL:imgurl];
            
            UIImage*img=[UIImage imageWithData:data];
            
            imgvw.image=img;
            
            
            
            
            
            
            
            
        }
        
        
        else
        {
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //   lbl_show.hidden=NO;
            //    mtable.hidden=YES;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
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

- (IBAction)action_enroll:(id)sender {
    
    
//       if (self.contain_enroll.frame.origin.x == currentwidth) {
//        [UIView animateWithDuration:0.3f animations:^{
//            
//            self.contain_general.frame = CGRectMake(-currentwidth, self.contain_general.frame.origin.y,
//                                                    self.contain_general.frame.size.width, self.contain_general.frame.size.height);
//            
//            self.contain_enroll.frame = CGRectMake(0, self.contain_enroll.frame.origin.y,
//                                                 self.contain_enroll.frame.size.width, self.contain_enroll.frame.size.height);
//            
//            
//            self.contain_address.frame = CGRectMake(currentwidth, self.contain_address.frame.origin.y,
//                                                  self.contain_address.frame.size.width, self.contain_address.frame.size.height);
//            
//            
//            
//            self.view_buttonunderline.frame = CGRectMake(self.enrollinfo.frame.origin.x, self.view_buttonunderline.frame.origin.y, self.enrollinfo.frame.size.width, self.view_buttonunderline.frame.size.height);
//        }completion:^(BOOL finished){
//            [self.view bringSubviewToFront:self.contain_enroll];
//        }];
//        
//        
//        
//        
//        
//        
//    }
   
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    
    EnrollinfoViewController *enrol=[[EnrollinfoViewController alloc]init];
    
    enrol=[sb instantiateViewControllerWithIdentifier:@"enroll"];
    [self.navigationController pushViewController:enrol animated:YES];
    
    
    
    
    
}

- (IBAction)action_address:(id)sender {
    
//        if (self.contain_address.frame.origin.x == currentwidth) {
//        [UIView animateWithDuration:0.3f animations:^{
//            
//            self.contain_general.frame = CGRectMake(-currentwidth, self.contain_general.frame.origin.y,
//                                                    self.contain_general.frame.size.width, self.contain_general.frame.size.height);
//            
//            self.contain_enroll.frame = CGRectMake(currentwidth, self.contain_enroll.frame.origin.y,
//                                                 self.contain_enroll.frame.size.width, self.contain_enroll.frame.size.height);
//            
//            
//            self.contain_address.frame = CGRectMake(0, self.contain_address.frame.origin.y,
//                                                  self.contain_address.frame.size.width, self.contain_address.frame.size.height);
//            self.view_buttonunderline.frame = CGRectMake(self.address.frame.origin.x, self.view_buttonunderline.frame.origin.y, self.address.frame.size.width, self.view_buttonunderline.frame.size.height);
//        }completion:^(BOOL finished){
//            [self.view bringSubviewToFront:self.contain_address];
//        }];
//        
//        
//        
//        
//        
//        
//    }
//
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    
    AddressViewController *address=[[AddressViewController alloc]init];
    
    address=[sb instantiateViewControllerWithIdentifier:@"address"];
    [self.navigationController pushViewController:address animated:YES];
    

    
    
    
}



- (IBAction)action_general:(id)sender {
    
    if (self.contain_general.frame.origin.x == -currentwidth) {
        [UIView animateWithDuration:0.3f animations:^{
            
            self.contain_general.frame = CGRectMake(0, self.contain_general.frame.origin.y,
                                                    self.contain_general.frame.size.width, self.contain_general.frame.size.height);
            
            self.contain_enroll.frame = CGRectMake(currentwidth, self.contain_enroll.frame.origin.y,
                                                 self.contain_enroll.frame.size.width, self.contain_enroll.frame.size.height);
            
            self.contain_address.frame = CGRectMake(currentwidth, self.contain_address.frame.origin.y,
                                                  self.contain_address.frame.size.width, self.contain_address.frame.size.height);
            self.view_buttonunderline.frame = CGRectMake(self.geninfo.frame.origin.x, self.view_buttonunderline.frame.origin.y, self.geninfo.frame.size.width, self.view_buttonunderline.frame.size.height);
            
        }completion:^(BOOL finished){
            [self.view bringSubviewToFront:self.contain_general];
        }];
        
    }
    
    
    
    
}




-(IBAction)back:(id)sender
{
    
    NSArray *ary = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[ary objectAtIndex:3] animated:YES];
    
}



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
