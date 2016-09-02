//
//  Gradeassignment.m
//  openSiS
//
//  Created by os4ed on 4/26/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_Gradeassignment.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "CPdetails.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"
@interface P_Gradeassignment ()
{

 NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;

    NSString    *parentid;


}

@end

@implementation P_Gradeassignment

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata45];
    
    NSLog(@"course_id.......%@",_course_id_str);
    // Do any additional setup after loading the view.
}

-(IBAction)back1:(id)sender
{


    [self.navigationController popViewControllerAnimated:YES];


}


-(void)loaddata45
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
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_gradebook_grades.php?parent_id=%@&student_id=%@&syear=%@&mp_id=%@&action_type=expanded&id=%@&modfun=assgn_detail&assignment_id=%@",parentid,student_id,s_year,mp_id,_id_cp,_course_id_str];
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
        
        NSLog(@"............%@",dictionary1);
        
//        NSMutableArray *userarray=[[NSMutableArray alloc]init];
//        userarray=[dictionary1 objectForKey:@"gradebook_grade_data"];
//        
//        for (int i=0; i<[userarray count]; i++) {
//            
//            
//            grade_arry =userarray;
//            
//            // [self.rqstarry addObject:[userarray objectAtIndex:i]];
//            
//            
//        }
//        
//        [grade_table reloadData];
        
        NSString *str_succ1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        
        if ([str_succ1 isEqualToString:@"1"]) {
            
            //NSLog(@"----------%@",str_succ1);
            
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"user details" message:str_succ1 delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKK", nil];
            //            [alert show];
            
            
            
            
        }
        //[self performSegueWithIdentifier:@"log_detail" sender:self];
        else
        {
            NSLog(@"not success");
            
        }
        
        // NSLog(@"%@",[dictionary1 objectForKey:@"Message"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
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
