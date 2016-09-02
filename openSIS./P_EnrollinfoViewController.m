//
//  EnrollinfoViewController.m
//  openSiS
//
//  Created by os4ed on 4/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_EnrollinfoViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "MyinfoViewController.h"
#import "P_AddressViewController.h"
#import "P_SettingViewController.h"

#import "enrollcell.h"
#import "S_ReportViewController.h"
#import "P_SettingViewController.h"
#import "pdashboardViewController.h"
#import "P_MyinfoViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"
#import "P_GoalsViewController.h"
#import "P_CommentViewController.h"

@interface P_EnrollinfoViewController ()
{
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    NSArray *enrol;
}




@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_menu;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_viewforSegment;
@end

@implementation P_EnrollinfoViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loaddata];
    
    //[tabl_enrol reloadData];
    
    
    
    
    
    
    [self.scroll_viewforSegment setContentSize:CGSizeMake(self.segment_menu.frame.size.width, self.scroll_viewforSegment.frame.size.height)];

    
    tabl_enrol.tableFooterView=[[UIView alloc]init];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    _segment_menu.selectedSegmentIndex=1;
    
    
    
    
    
    
    
}

- (IBAction)action_segment:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_MyinfoViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_myinfo1"];
        
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        [self.navigationController pushViewController:mia animated:NO];
        
        
        
        
    }
    else if (sender.selectedSegmentIndex == 1)
    {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
//        P_EnrollinfoViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_enroll1"];
//        
//        
//        mia.st_id=self.st_id;
//        
//        
//        
//        mia.schoolid=self.schoolid;
//        
//        
//        
//        mia.ssssyr=self.ssssyr;
//        
//        
//        
//        
//        
//        [self.navigationController pushViewController:mia animated:NO];
    }
        else if (sender.selectedSegmentIndex == 2)
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
            P_AddressViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_address1"];
            
            
            mia.st_id=self.st_id;
            
            
            
            mia.schoolid=self.schoolid;
            
            
            
            mia.ssssyr=self.ssssyr;
            
            
            
            
            
            [self.navigationController pushViewController:mia animated:NO];        }
    
    
    
    
    
    
    
    
    
    
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









-(IBAction)genrl:(id)sender
{
    
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//    
//    MyinfoViewController *myinfo=[[MyinfoViewController alloc]init];
//    
//    myinfo=[sb instantiateViewControllerWithIdentifier:@"myinfo"];
//    [self.navigationController pushViewController:myinfo animated:YES];

}
-(IBAction)addrs:(id)sender
{
    
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//    
//    AddressViewController *addrs=[[AddressViewController alloc]init];
//    
//    addrs=[sb instantiateViewControllerWithIdentifier:@"address"];
//    [self.navigationController pushViewController:addrs animated:YES];
    
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
            NSArray  *sinfo=[dictionary1 objectForKey:@"enrollment_info"];
            NSLog(@"sinfo----%@",sinfo);
            
            clndrname.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"CALENDAR"]]];
            
            rolling.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:0] objectForKey:@"NEXT_SCHOOL"]]];
            
            for (int i=0; i<sinfo.count; i++) {
                
                enrol=[[sinfo objectAtIndex:i]objectForKey:@"SCHOOL_INFO"];
                
                
                
                
                
            }
            
            
            NSLog(@"////// %@",enrol);
             [tabl_enrol reloadData];
            

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return enrol.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  enrollcell *cell=[tableView dequeueReusableCellWithIdentifier:@"enroll"];
    
    cell = (enrollcell*)[[[NSBundle mainBundle] loadNibNamed:@"enrollcell" owner:self options:nil ]objectAtIndex:0];
    cell.clipsToBounds = YES;
    //cell.cell_lbl.text = [NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]];
    
    cell.title.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[enrol objectAtIndex:indexPath.row] objectForKey:@"SCHOOL_NAME"]]];
    
    cell.enroll.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[enrol objectAtIndex:indexPath.row] objectForKey:@"ENROLLMENT_CODE_NAME"]]];
    
    cell.drop.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[enrol objectAtIndex:indexPath.row] objectForKey:@"DROP_CODE_NAME"]]];
    
    cell.startdate.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[enrol objectAtIndex:indexPath.row] objectForKey:@"START_DATE"]]];
    
     cell.dropdate.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[enrol objectAtIndex:indexPath.row] objectForKey:@"END_DATE"]]];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
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
