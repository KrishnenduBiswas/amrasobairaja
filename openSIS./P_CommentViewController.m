//
//  P_CommentViewController.m
//  openSiS
//
//  Created by os4ed on 6/30/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_CommentViewController.h"
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
#import "P_stu_commentsTableViewCell.h"
#import "P_GoalsViewController.h"
#import "P_MyinfoViewController.h"

@interface P_CommentViewController ()
{
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    NSArray  *sinfo;

}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_menu;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_viewforSegment;

@end

@implementation P_CommentViewController
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
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    _segment_menu.selectedSegmentIndex=3;
    
    
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self loaddata];
    
    
    tbl.tableFooterView=[[UIView alloc]init];
    
    
    
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"comments_success"]];
        NSLog(@"str_123-----%@",str_123);
        
        
        if([str_123 isEqualToString:@"1"])
        {
            sinfo=[dictionary1 objectForKey:@"comments"];
            NSLog(@"sinfo----%@",sinfo);
            
            [tbl reloadData];
            
        }
        
        
        else
        {
            tbl.hidden=YES;
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







- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sinfo.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    P_stu_commentsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"p_commentscell"];
    
    
    cell.date.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@""]]];
    cell.comment.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@""]]];
    cell.by.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@""]]];
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
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
