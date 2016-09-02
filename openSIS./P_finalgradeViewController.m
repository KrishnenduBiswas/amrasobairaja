//
//  P_finalgradeViewController.m
//  openSiS
//
//  Created by os4ed on 7/7/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_finalgradeViewController.h"
#import "AFNetworking.h"
#import "PtdgrdbookTableViewCell.h"
#import "Grade_p_ViewController.h"
#import "P_Grade_detail_ViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "CPdetails.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"
#import "P_FinalTableViewCell.h"
#import "P_LastfinalViewController.h"


@interface P_finalgradeViewController ()
{
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;
    
    
    NSString    *parentid;

}

@end

@implementation P_finalgradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tbl.tableFooterView=[[UIView alloc]init];
    
    [self loaddata];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_gradebook_grades.php?student_id=1&school_id=1&syear=2015&mp_id=17&action_type=totals
    
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
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_final_grades.php?parent_id=%@&student_id=%@&syear=%@&mp_id=%@",parentid,student_id,s_year,mp_id];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    
    
    
    
    
    
    
    
    cp_ary =[[NSMutableArray alloc]init];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"............%@",dictionary1);
        
  
        
        NSString *str_succ1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        
        if ([str_succ1 isEqualToString:@"1"]) {
            
            
            
            
            
            
            cp_ary=[dictionary1 objectForKey:@"mp_data"];
            
            

            [tbl reloadData];
            
            
            
            
            
            
            
            
            
        }
       
        else
        {
            NSLog(@"not success");
            
        }
        
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cp_ary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    P_FinalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"p_final_cell"];
    
    
    cell.title_lbl.text=[NSString stringWithFormat:@"%@",[[cp_ary objectAtIndex:indexPath.row]objectForKey:@"TITLE"]];
    
    
    return cell;
}





-(IBAction)generate:(id)sender
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Grades" bundle:nil];
    P_LastfinalViewController *fgvc =[[P_LastfinalViewController alloc]init];
    fgvc=[sb instantiateViewControllerWithIdentifier:@"lastfinal"];
    
    
    [self.navigationController pushViewController:fgvc animated:YES];
    
    
    
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
