//
//  Gradeassignment.m
//  openSiS
//
//  Created by os4ed on 4/26/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Gradeassignment.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "CPdetails.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"
@interface Gradeassignment ()
{

 NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;



}

@end

@implementation Gradeassignment

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata45];
    
    NSLog(@"course_id.......%@",_course_id_str);
    // Do any additional setup after loading the view.
}
-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
}
-(IBAction)thirdButton:(id)sender
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










-(IBAction)back1:(id)sender
{


    [self.navigationController popViewControllerAnimated:YES];


}


-(void)loaddata45
{
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_gradebook_grades.php?student_id=1&school_id=1&syear=2015&mp_id=17&action_type=expanded&id=15&modfun=assgn_detail&assignment_id=112
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    //    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    //    student_id=[DF objectForKey:@"iphone"];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_gradebook_grades.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&action_type=expanded&id=%@&modfun=assgn_detail&assignment_id=%@",student_id,s_year_id,s_year,mp_id,_id_cp,_course_id_str];
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
