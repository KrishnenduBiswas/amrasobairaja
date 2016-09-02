//
//  AddressViewController.m
//  openSiS
//
//  Created by os4ed on 4/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "AddressViewController.h"
#import "MyinfoViewController.h"
#import "EnrollinfoViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "SettingViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"


@interface AddressViewController ()
{

    NSString    * student_id,*view_select,*s_year,*s_year_id, *str_switch;
    NSArray *home_ad,*mail_ad ,*primary_ad ,*secnd_ad;


}
@property(strong ,nonatomic)IBOutlet UIScrollView *scroll_content;
@property(strong ,nonatomic)IBOutlet UILabel *zip_postal;
@property (strong, nonatomic) IBOutlet UILabel *address1_home;

@property (strong, nonatomic) IBOutlet UILabel *address2_home;
@property (strong, nonatomic) IBOutlet UILabel *city_home;
@property (strong, nonatomic) IBOutlet UILabel *state_home;
@property (strong, nonatomic) IBOutlet UILabel *zip_home;
@property (strong, nonatomic) IBOutlet UILabel *buspick_home;
@property (strong, nonatomic) IBOutlet UILabel *busdrop_home;
@property (strong, nonatomic) IBOutlet UILabel *busno_home;
@property (strong, nonatomic) IBOutlet UILabel *address1_mail;
@property (strong, nonatomic) IBOutlet UILabel *address2_mail;
@property (strong, nonatomic) IBOutlet UILabel *city_mail;
@property (strong, nonatomic) IBOutlet UILabel *state_mail;
@property (strong, nonatomic) IBOutlet UILabel *zip_mail;
@property (strong, nonatomic) IBOutlet UISwitch *switch_mail;
@property (strong, nonatomic) IBOutlet UISwitch *switch_buspick;
@property (strong, nonatomic) IBOutlet UISwitch *switch_busdrop;
@property (strong, nonatomic) IBOutlet UILabel *relation_primary;
@property (strong, nonatomic) IBOutlet UILabel *fname_primary;
@property (strong, nonatomic) IBOutlet UILabel *lname_primary;
@property (strong, nonatomic) IBOutlet UILabel *hph_primary;
@property (strong, nonatomic) IBOutlet UILabel *wph_primary;
@property (strong, nonatomic) IBOutlet UILabel *cmobile_primary;
@property (strong, nonatomic) IBOutlet UILabel *email_primary;
@property (strong, nonatomic) IBOutlet UILabel *add_primay;
@property (strong, nonatomic) IBOutlet UILabel *add2_primary;
@property (strong, nonatomic) IBOutlet UILabel *city_pri;
@property (strong, nonatomic) IBOutlet UILabel *state_pri;
@property (strong, nonatomic) IBOutlet UILabel *relation_second;
@property (strong, nonatomic) IBOutlet UILabel *fname_second;
@property (strong, nonatomic) IBOutlet UILabel *lname_second;
@property (strong, nonatomic) IBOutlet UILabel *hph_second;
@property (strong, nonatomic) IBOutlet UILabel *wph_second;
@property (strong, nonatomic) IBOutlet UILabel *cell_second;
@property (strong, nonatomic) IBOutlet UISwitch *switch_primary;
@property (strong, nonatomic) IBOutlet UILabel *email_second;
@property (strong, nonatomic) IBOutlet UILabel *ad1_second;
@property (strong, nonatomic) IBOutlet UISwitch *custody_primary;
@property (strong, nonatomic) IBOutlet UILabel *ad2_second;
@property (strong, nonatomic) IBOutlet UILabel *cityy_second;
@property (strong, nonatomic) IBOutlet UILabel *state_second;
@property (strong, nonatomic) IBOutlet UISwitch *portal_primary;
@property (strong, nonatomic) IBOutlet UILabel *zip_second;
@property (strong, nonatomic) IBOutlet UISwitch *switch_second;
@property (strong, nonatomic) IBOutlet UISwitch *custody_second;
@property (strong, nonatomic) IBOutlet UISwitch *portal_second;
- (IBAction)action_switch_mail:(id)sender;
- (IBAction)action_pickup:(id)sender;
- (IBAction)action_dropoff:(id)sender;
- (IBAction)action_primary:(id)sender;
- (IBAction)action_second:(id)sender;
- (IBAction)action_custody_p:(id)sender;
- (IBAction)action_ptrl_primary:(id)sender;
- (IBAction)action_custody_secnd:(id)sender;
- (IBAction)action_ptrl_secnd:(id)sender;


@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loaddata1];
    
    [self.scroll_content setContentSize:CGSizeMake(self.scroll_content.frame.size.width, self.zip_postal.frame.origin.y + 600)];

    
}
-(void)loaddata1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    //    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    //    student_id=[DF objectForKey:@"iphone"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_info.php?school_id=%@&syear=%@&student_id=%@",s_year_id,s_year,student_id];
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
        
        
        if([str_123 isEqualToString:@"1"])
        {
            NSArray  *sinfo=[dictionary1 objectForKey:@"address_contact"];
            NSLog(@"sinfo----%@",sinfo);
            
            for (int i=0; i<sinfo.count; i++) {
                
                home_ad=[[sinfo objectAtIndex:i]objectForKey:@"HOME_ADDRESS"];
                NSLog(@"eta home address array..........%@",home_ad);
                
                 mail_ad=[[sinfo objectAtIndex:i]objectForKey:@"MAIL_ADDRESS"];
                NSLog(@"eta mail address array..........%@",mail_ad);
                
                
               primary_ad=[[sinfo objectAtIndex:i]objectForKey:@"PRIMARY_EMERGENCY_CONTACT"];
                NSLog(@"eta primary address array..........%@",primary_ad);
                
                secnd_ad=[[sinfo objectAtIndex:i]objectForKey:@"SECONDARY_EMERGENCY_CONTACT"];
                NSLog(@"eta secondary address array..........%@",secnd_ad);

            }
            
            self.address1_home.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"ADDRESS"]]];
            
             self.zip_home.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
            
             self.state_home.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"STATE"]]];
            
             self.city_home.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"CITY"]]];
            
            
            
            self.busno_home.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"BUS_NO"]]];
            
            NSString *str_pick = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"BUS_PICKUP"]]];
            
            if ([str_pick isEqualToString:@"Y"]) {
                
                [self.switch_buspick setOn:YES animated:YES];
            }
            else
            {
                
                [self.switch_buspick setOn:NO animated:YES];
                
            }
            
            
            NSString *str_drop = [self nullChecker:[NSString stringWithFormat:@"%@",[[home_ad objectAtIndex:0] objectForKey:@"BUS_DROPOFF"]]];
            
            if ([str_drop isEqualToString:@"Y"]) {
                
                [self.switch_busdrop setOn:YES animated:YES];
            }
            else
            {
                
                [self.switch_busdrop setOn:NO animated:YES];
                
            }

            

            
            //////////////////////  mail address data///////////////
            
            
         str_switch = [self nullChecker:[NSString stringWithFormat:@"%@",[[mail_ad objectAtIndex:0] objectForKey:@"SAME_AS_HOME_ADDR"]]];
            
            if ([str_switch isEqualToString:@"Y"]) {
                
                [self.switch_mail setOn:YES animated:YES];
            }
            else
            {
            
            [self.switch_mail setOn:NO animated:YES];
            
            }
            
            
            
            self.address1_mail.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[mail_ad objectAtIndex:0] objectForKey:@"ADDRESS"]]];
            
            self.zip_mail.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[mail_ad objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
            
            self.state_mail.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[mail_ad objectAtIndex:0] objectForKey:@"STATE"]]];
            
            self.city_mail.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[mail_ad objectAtIndex:0] objectForKey:@"CITY"]]];
            
            
            
           
            ////////// primary mailing ///////////
            
            
            self.relation_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"RELATIONSHIP"]]];
            
            self.fname_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"FIRST_NAME"]]];
            
            self.lname_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"LAST_NAME"]]];
            
             self.hph_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"HOME_PHONE"]]];
            
            self.wph_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"WORK_PHONE"]]];
            
             self.cmobile_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"CELL_PHONE"]]];
            
            self.email_primary.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"EMAIL"]]];
            
            NSString *str = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"SAME_AS_HOME_ADDR"]]];
            
            if ([str isEqualToString:@"Y"]) {
                
                [self.switch_primary setOn:YES animated:YES];
            }
            else
            {
                
                [self.switch_primary setOn:NO animated:YES];
                
            }

            
            NSString *str11 = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"CUSTODY"]]];
            
            if ([str11 isEqualToString:@"Y"]) {
                
                [self.custody_primary setOn:YES animated:YES];
            }
            else
            {
                
                [self.custody_primary setOn:NO animated:YES];
                
            }
            
            NSString *str12 = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"PORTAL_USER"]]];
            
            if ([str12 isEqualToString:@"Y"]) {
                
                [self.portal_primary setOn:YES animated:YES];
            }
            else
            {
                
                [self.portal_primary setOn:NO animated:YES];
                
            }
            
            self.add_primay.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"ADDRESS"]]];
            
            
            self.city_pri.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"CITY"]]];
            
            self.state_pri.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"STATE"]]];
            
            self.zip_postal.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[primary_ad objectAtIndex:0] objectForKey:@"ZIPCODE"]]];
            
            ///////////// secondary mailing ///////////
            
            self.relation_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"RELATIONSHIP"]]];
            
            self.fname_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"FIRST_NAME"]]];
            
            self.lname_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"LAST_NAME"]]];
            
            self.hph_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"HOME_PHONE"]]];
            
            self.wph_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"WORK_PHONE"]]];
            
            self.cell_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"CELL_PHONE"]]];
            
            self.email_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"EMAIL"]]];
            
            
            NSString *str123 = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"SAME_AS_HOME_ADDR"]]];
            
            if ([str123 isEqualToString:@"Y"]) {
                
                [self.switch_second setOn:YES animated:YES];
            }
            else
            {
                
                [self.switch_second setOn:NO animated:YES];
                
            }
            
            
            NSString *str113 = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"CUSTODY"]]];
            
            if ([str113 isEqualToString:@"Y"]) {
                
                [self.custody_second setOn:YES animated:YES];
            }
            else
            {
                
                [self.custody_second setOn:NO animated:YES];
                
            }
            
            NSString *str124 = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"PORTAL_USER"]]];
            
            if ([str124 isEqualToString:@"Y"]) {
                
                [self.portal_second setOn:YES animated:YES];
            }
            else
            {
                
                [self.portal_second setOn:NO animated:YES];
                
            }
            
            self.ad1_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"ADDRESS"]]];
            
            
            self.cityy_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"CITY"]]];
            
            self.state_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"STATE"]]];
            
            self.zip_second.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[secnd_ad objectAtIndex:0] objectForKey:@"ZIPCODE"]]];

            
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

-(IBAction)back:(id)sender
{
    
    NSArray *ary = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[ary objectAtIndex:3] animated:YES];
    
}

-(IBAction)settting:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SettingViewController * mvc=[[SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
}



-(IBAction)genrl:(id)sender
{
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    
    MyinfoViewController *myinfo=[[MyinfoViewController alloc]init];
    
    myinfo=[sb instantiateViewControllerWithIdentifier:@"myinfo"];
    [self.navigationController pushViewController:myinfo animated:NO];
    
}
- (IBAction)action_enroll:(id)sender {
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    
    EnrollinfoViewController *enrol=[[EnrollinfoViewController alloc]init];
    
    enrol=[sb instantiateViewControllerWithIdentifier:@"enroll"];
    [self.navigationController pushViewController:enrol animated:NO];
    
    
    
    
    
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
-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(IBAction)Report:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    S_ReportViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"rprt"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
    MsgViewController *mgc =[[MsgViewController alloc]init];
    mgc=[sb instantiateViewControllerWithIdentifier:@"msg"];
    [self.navigationController pushViewController:mgc animated:NO];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SettingViewController * mvc=[[SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
}


- (IBAction)action_switch_mail:(id)sender {
}

- (IBAction)action_pickup:(id)sender {
}

- (IBAction)action_dropoff:(id)sender {
}

- (IBAction)action_primary:(id)sender {
}

- (IBAction)action_second:(id)sender {
}

- (IBAction)action_custody_p:(id)sender {
}

- (IBAction)action_ptrl_primary:(id)sender {
}

- (IBAction)action_custody_secnd:(id)sender {
}

- (IBAction)action_ptrl_secnd:(id)sender {
}

- (IBAction)portal_primary:(id)sender {
}
@end
