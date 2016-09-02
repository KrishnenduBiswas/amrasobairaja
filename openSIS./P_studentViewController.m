//
//  P_studentViewController.m
//  openSiS
//
//  Created by os4ed on 6/28/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_studentViewController.h"
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
#import "P_stu_TableViewCell.h"
#import "P_MyinfoViewController.h"
@interface P_studentViewController ()
{
    
    
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    NSArray  *sinfo;

    
    
    
    
    
}

@end

@implementation P_studentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loaddata1];
    
    
    tblll.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
    
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
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_student_list.php?parent_id=%@&syear=%@",parentid,s_year];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        
        
        if([str_123 isEqualToString:@"1"])
        {
            sinfo=[dictionary1 objectForKey:@"student_data"];
            NSLog(@"sinfo----%@",sinfo);
            
            
            
            [tblll reloadData];
            
            
            
        }
        
        
        
        
        else
        {

            
            
            
            tblll.hidden=YES;
            
            
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
       
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
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






-(IBAction)settting:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sinfo.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    P_stu_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"p_st"];
    
    cell.name.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"NAME"]]];
    
    cell.grade.text = [self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"GRADE_LEVEL"]]];
    
    cell.sid.text = [self nullChecker:[NSString stringWithFormat:@"#%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"STUDENT_ID"]]];
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
   }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Student" bundle:nil];
    
    P_MyinfoViewController *enrol=[[P_MyinfoViewController alloc]init];
    
    enrol=[sb instantiateViewControllerWithIdentifier:@"p_myinfo1"];
    
    enrol.st_id=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"STUDENT_ID"]]];
    
    
    enrol.ssssyr=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"SYEAR"]]];
    
    
    enrol.schoolid=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:indexPath.row] objectForKey:@"SCHOOL_ID"]]];
    
    
    [self.navigationController pushViewController:enrol animated:YES];

    
    
    
    
    
    
    
    
    
    
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
