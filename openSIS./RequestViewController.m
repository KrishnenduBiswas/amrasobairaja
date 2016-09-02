//
//  RequestViewController.m
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "RequestViewController.h"
#import "RequestTableViewCell.h"
#import "AFNetworking.h"
#import "SdashboardViewController.h"
#import "Add_requestViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "EditReqstViewController.h"
#import "SettingViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"

@interface RequestViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *view_onlongpress;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UIView *view_sublongpress;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dialogTitle;
@end

@implementation RequestViewController
{

    NSIndexPath *currentIndex;
     NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type ,*success_c;
    NSDictionary * dic;
    NSString * rqst_id;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // long press er code ta
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressed:)];
    longpress.minimumPressDuration = 1.5;
    longpress.delegate = self;
    [table_reqt addGestureRecognizer:longpress];
    [self.view_onlongpress setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    self.view_onlongpress.opaque = NO;
 
    // Do any additional setup after loading the view.
    [self loaddata];
    
    
    table_reqt.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
}

- (void)pressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:table_reqt];
    
    NSIndexPath *indexPath = [table_reqt indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long press on table view at row %ld", (long)indexPath.row);
        [self appearonlongwithIndex:indexPath];
        
        dic = [_rqstarry objectAtIndex:indexPath.row];
        
        
        NSLog(@"%@",dic);
        
    } else {
        NSLog(@"gestureRecognizer.state = %ld", (long)gestureRecognizer.state);
    }
}

-(void)appearonlongwithIndex:(NSIndexPath*)indexPath
{
    
    currentIndex = indexPath;
    self.lbl_dialogTitle.text = [[self.rqstarry objectAtIndex:currentIndex.row] objectForKey:@"COURSE"];
    
    
    [self.view_sublongpress setAlpha:1.0f];
    [self.view addSubview:self.view_onlongpress];
   
}
-(IBAction)close:(id)sender
{
    [self.view_onlongpress removeFromSuperview];
}
- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}

//-(void)loadedit
//{
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
//    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
//    
//    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
//    
//    ip_url *obj123=[[ip_url alloc]init];
//    NSString *str123=[obj123 ipurl];
//    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_schedule_request.php?action=edit_view&student_id=%@&school_id=%@&syear=%@&req_id=%@",student_id,s_year_id,s_year,rqst_id];
//    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
//    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
//    
//    NSLog(@"----%@",url12);
//    NSURL *url = [NSURL URLWithString:url12];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    
//    
//    
//    // 2
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSMutableDictionary *  dictionary2=[[NSMutableDictionary alloc]init];
//        dictionary2 = (NSMutableDictionary *)responseObject;
//        NSLog(@"value is-------%@",dictionary2);
//        
//        
//        
//        
//        // ei khanei nslog korle dekhache, blocker baire dekhache na
//        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
//        
//        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
//        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary2 objectForKey:@"success"]];
//        NSLog(@"str_123-----%@",str_123);
//        if([str_123 isEqualToString:@"1"])
//            
//            
//            
//        {
//            
//            
//       
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//        //  transparentView.hidden=NO;
//        //  NSLog(@"ok----");
//        //[self.view addSubview:transparentView];
//    }];
//    
//    
//    [operation start];
//    
//    
//    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// tableview er delegate and datasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rqstarry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RequestTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellrqst"];
    
//    cell = (RequestTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"RequestTableViewCell" owner:self options:nil ]objectAtIndex:0];
//   // cell.clipsToBounds = YES;
    cell.wthtchr.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[_rqstarry objectAtIndex:indexPath.row]objectForKey:@"WITH_TEACHER_NAME"]]];
    
     cell.wthouttchr.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[_rqstarry objectAtIndex:indexPath.row]objectForKey:@"WITHOUT_TEACHER_NAME "]]];
    
    cell.title_lbl.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[_rqstarry objectAtIndex:indexPath.row]objectForKey:@"COURSE"]]];
    
    cell.prd_on.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[_rqstarry objectAtIndex:indexPath.row]objectForKey:@"WITH_PERIOD_NAME "]]];
    
    cell.prd_noton.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[_rqstarry objectAtIndex:indexPath.row]objectForKey:@"WITHOUT_PERIOD_NAME"]]];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 125.0f;


}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
    }
    
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

-(IBAction)addbtn:(id)sender
{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
        Add_requestViewController* sd = [storyboard instantiateViewControllerWithIdentifier:@"newreqst"];
        [self.navigationController pushViewController:sd animated:NO];
    
        
    }

-(void)loaddata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    NSLog(@"%@",mp_id);
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_schedule_request.php?action=view&student_id=%@&school_id=%@&syear=%@",student_id,s_year_id,s_year];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.rqstarry =[[NSMutableArray alloc]init];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"............%@",dictionary1);
        
        
        NSString*str_succ=(NSString*)[dictionary1 objectForKey:@"success"];
        
        int suc=[str_succ intValue];
        
        if (suc==1) {
            NSMutableArray *userarray=[[NSMutableArray alloc]init];
            userarray=[dictionary1 objectForKey:@"request_data"];
            
            for (int i=0; i<[userarray count]; i++) {
                
                
                self.rqstarry =userarray;
                
                // [self.rqstarry addObject:[userarray objectAtIndex:i]];
                
                
            }
            
            [table_reqt reloadData];
            

        }
        
        
        else
        {
            
            
            table_reqt.hidden=YES;
            
            
            
        }
        
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    



}

-(IBAction)settting:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SettingViewController * mvc=[[SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
}

-(void)loaddelete
{
    
    
    
        
        
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
        s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
        s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
        
        mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
        
        ip_url *obj123=[[ip_url alloc]init];
        NSString *str123=[obj123 ipurl];
        NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_schedule_request.php?action=delete&student_id=%@&school_id=%@&syear=%@&req_id=%@",student_id,s_year_id,s_year,rqst_id];
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
            
            NSMutableDictionary *  dictionary2=[[NSMutableDictionary alloc]init];
            dictionary2 = (NSMutableDictionary *)responseObject;
            NSLog(@"Edit value is-------%@",dictionary2);
            
            
            
            
            // ei khanei nslog korle dekhache, blocker baire dekhache na
            //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
            
            //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
            NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary2 objectForKey:@"success"]];
            NSLog(@"str_123-----%@",str_123);
            if([str_123 isEqualToString:@"1"])
                
                
                
            {
                
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            //  transparentView.hidden=NO;
            //  NSLog(@"ok----");
            //[self.view addSubview:transparentView];
        }];
        
        
        [operation start];
        
        

    

    
    
    
    
    
}


-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_edit:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    

    EditReqstViewController* editvc =[[EditReqstViewController alloc]init];
    editvc=[storyboard instantiateViewControllerWithIdentifier:@"editrqst"];
    
    
    editvc.dicttt=dic;
    NSLog(@",,,,,,,,,,,,,,,,,%@",editvc.dicttt);
    
    rqst_id=[dic objectForKey:@"REQUEST_ID"];
    
    NSLog(@"rqst_id%@",rqst_id);
    
    
    editvc.strrrrrrr=rqst_id;
    
    
    [editvc loadedit];
    
    [self close:nil];
    
   
    
    
    
      [self.navigationController pushViewController:editvc animated:NO];
    
}


-(IBAction)action_delete:(id)sender
{
    
    
    rqst_id=[dic objectForKey:@"REQUEST_ID"];
    
    NSLog(@"rqst_id%@",rqst_id);
    
    
    
    [self loaddelete];
    
    
    [self viewDidLoad];
    
    
    [self close:nil];

    
    
    
    
    
}


@end
