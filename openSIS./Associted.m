//
//  AddressViewController.m
//  openSiS
//
//  Created by os4ed on 4/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Associted.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "P_SettingViewController.h"
#import "S_ReportViewController.h"
#import "P_SettingViewController.h"
#import "pdashboardViewController.h"
#import "Asso_TableViewCell.h"
#import "geninfo.h"
#import "addressinfo.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"


@interface Associted ()
{

    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    NSArray *home_ad,*mail_ad ,*primary_ad ,*secnd_ad;
    NSArray  *sinfo;


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

@implementation Associted

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblll.tableFooterView=[[UIView alloc]init ];
    // Do any additional setup after loading the view.
    [self loaddata1];
    
    [self.scroll_content setContentSize:CGSizeMake(self.scroll_content.frame.size.width, self.zip_postal.frame.origin.y + 600)];

    
}
-(void)loaddata1
{
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
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_info.php?parent_id=%@&student_id=%@&syear=%@",parentid,student_id,s_year];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"address_success"]];
        NSLog(@"str_123-----%@",str_123);
        
        
        if([str_123 isEqualToString:@"1"])
        {
            sinfo=[dictionary1 objectForKey:@"stu_data"];
            NSLog(@"sinfo----%@",sinfo);
            
            
            
            [_tblll reloadData];
            
            
            
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
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    

    
    
}



-(IBAction)genrl:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    geninfo *obj = [sb instantiateViewControllerWithIdentifier:@"p_myinfo"];
    
    
    [self.navigationController pushViewController:obj animated:NO];
    
    
}
- (IBAction)action_enroll:(id)sender {
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    
    addressinfo *enrol=[[addressinfo alloc]init];
    
    enrol=[sb instantiateViewControllerWithIdentifier:@"p_enroll"];
    [self.navigationController pushViewController:enrol animated:NO];

    
    
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sinfo.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Asso_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"asso"];
    
    cell.name.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"FULL_NAME"]]];
    
    cell.grade.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"GRADE"]]];
    
    cell.school.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"SCHOOL"]]];
    
    cell.relation.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"RELATIONSHIP"]]];
    
    
    return cell;
    
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
