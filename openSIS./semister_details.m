//
//  semister_details.m
//  full_json
//
//  Created by os4ed on 2/25/16.
//  Copyright © 2016 os4ed. All rights reserved.
//

#import "semister_details.h"
#import "AFNetworking.h"
#import "ViewController.h"
#import "mp.h"
#import "AppDelegate.h"
@interface semister_details ()<UITableViewDataSource>
{

    IBOutlet UILabel *HEADER_LBL;
    NSString *  str_mp_type;

    IBOutlet UILabel *course_header;
    
    NSMutableArray *ary_parent;
}

@end

@implementation semister_details
@synthesize quater_label,begins,ends ,arry_sem,str_mp_type;
@synthesize grade,comments,exam;
//@synthesize dic1;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    ary_parent=[[NSMutableArray alloc]init];
    str_mp_type=[self.dictionary1 objectForKey:@"mp_type"];
     mp_id_inside_touch=[NSString stringWithFormat:@"%@",[self.dictionary1 objectForKey:@"MARKING_PERIOD_ID"]];
       NSLog(@"eta semester 1 dekhabe--------------%@",self.dictionary1);
    [self progdata];
    // Do any additional setup after loading the view.
}
-(void)fetchdata
{
    
    ip_url *obj=[[ip_url alloc]init];
    NSString*  ip=[obj ipurl];
    // NSLog(@"%@",ip);
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    
    NSString *usernamr=[df objectForKey:@"u"];
    NSString *paa=[df objectForKey:@"p"];
    NSString *pro=[df objectForKey:@"pro"];
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/teacher_info.php?username=%@&password=%@&profile=%@",usernamr,paa,pro];
    //  NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",ip,str_checklogin];
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSMutableDictionary* dic_techinfo = (NSMutableDictionary *)responseObject;
        // NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"success"]];
        //  NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            //   NSLog(@"uuuuuu====%@",dic_techinfo);
            lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
            
            //missing attendence count ////
            NSString *str_missing_attendence=[NSString stringWithFormat:@"%@",lbl_hidden.text];
            if ([str_missing_attendence isEqualToString:@"0"]) {
                
            }
            
            else
            {
                
                //  [self droptable];
            }
            
            
            notofi.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"notification_count"]];
            NSString *str_count=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            if ([str_count isEqualToString:@"0"]) {
                msg_count_tab.hidden=YES;
                msg_count.hidden=YES;
            }
            else
            {
                msg_count_tab.hidden=NO;
                msg_count.hidden=NO;
                
                msg_count_tab.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
                msg_count.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            }
        }
        
        
        else
        {
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
            //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            //  [alert show];
            
            //  transparentView.hidden=NO;
            // NSLog(@"ok----");
            //[self.view addSubview:transparentView];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
    
    
    
    
    
    
    
    
    
    
    
}


-(void)progdata
{

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loadata) withObject:nil afterDelay:3.0];
        });
    });

}
- (IBAction)course_action:(id)sender {
    
    
//    NSLog(@"arysem--------%@",ary_parent);
//     NSString *str_name=[NSString stringWithFormat:@"%@",[[ary_parent objectAtIndex:0]objectForKey:@"TITLE"]];
//    str_mp_type=@"";
//    if ([str_name isEqualToString:@"Full Year"]) {
//        str_mp_type=@"school_years";
//    }
//    
// else   if ([str_name isEqualToString:@"Semester 1"]) {
//        str_mp_type=@"school_semesters";
//    }
//    
//    else if ([str_name isEqualToString:@"Quarter 1"])
//    {
//         str_mp_type=@"school_quarters";
//        
//    
//    }
//    
//    else
//    {
//    str_mp_type=@"school_progress_periods";
//    
//    }
//    
//    mp_id_inside_touch=@"";
//   // str_mp_type=[[ary_parent objectAtIndex:0]objectForKey:@"MARKING_PERIOD_ID"];
//    mp_id_inside_touch=[NSString stringWithFormat:@"%@",[[ary_parent objectAtIndex:0]objectForKey:@"MARKING_PERIOD_ID"]];
    [self progdata];
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //[MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self performSelector:@selector(loadata) withObject:nil afterDelay:3.0];
//        });
//    });

    
    
    
}
-(void)loadata
{
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
  
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];

       NSString *str_checklogin=[NSString stringWithFormat:@"/marking_periods.php?staff_id=%@&school_id=%@&syear=%@&view_type=details&mp_id=%@&mp_type=%@",STAFF_ID_K,school_id1,year_id,mp_id_inside_touch,str_mp_type];
  
  NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"final---------url12---%@",url12);
   
     NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
 
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];   operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
     dic_value=[[NSMutableDictionary alloc]init];
        dic_value = (NSMutableDictionary *)responseObject;
        NSLog(@"--final value---%@",dic_value);
        
        //arry_sem =[[NSMutableArray alloc]init];
      //  parent_success : 0
        NSString *succ=[NSString stringWithFormat:@"%@",[dic_value objectForKey:@"success"]];
          NSString *p_succ=[NSString stringWithFormat:@"%@",[dic_value objectForKey:@"parent_success"]];
        if ([p_succ isEqualToString:@"1"]) {
            
            img_s.hidden=NO;
            course_header.hidden=NO;
            ary_parent=[dic_value objectForKey:@"parent_info"];
            
            NSLog(@"arysem--------%@",ary_parent);
            str_mp_type=@"";
           str_mp_type=[NSString stringWithFormat:@"%@",[[ary_parent objectAtIndex:0]objectForKey:@"mp_type"]];
            
            mp_id_inside_touch=@"";
            // str_mp_type=[[ary_parent objectAtIndex:0]objectForKey:@"MARKING_PERIOD_ID"];
            mp_id_inside_touch=[NSString stringWithFormat:@"%@",[[ary_parent objectAtIndex:0]objectForKey:@"MARKING_PERIOD_ID"]];
            course_header.text=[NSString stringWithFormat:@"Back to %@",[[ary_parent objectAtIndex:0]objectForKey:@"TITLE"]];
            
        }
        
        else
        {
            img_s.hidden=YES;
            course_header.hidden=YES;
        
        }
        
        if ([succ isEqualToString:@"1"])
            
       
        {
            
            ary_parent=[[NSMutableArray alloc]init];
          //  parent_info
            
           
            
            
       arry_sem=[[NSMutableArray alloc]init];
        
            NSMutableArray *temp_value=[[NSMutableArray alloc]init];

        temp_value=[dic_value objectForKey:@"marking_period_data"];
      //  child_success
            
            NSString *child_succ=[NSString stringWithFormat:@"%@",[[temp_value objectAtIndex:0]objectForKey:@"child_success"]];
                                   
            if ([child_succ isEqualToString:@"1"]) {
                
                
                 arry_sem=[[[temp_value objectAtIndex:0]objectForKey:@"child"]mutableCopy ];
                
            }
            
            else
            {
            
                NSLog(@"ok");
            }
                
            
                
              NSString *str_grd=[NSString stringWithFormat:@"%@",[self.dictionary1 objectForKey:@"DOES_GRADES"]];
               NSString *str_EXAM=[NSString stringWithFormat:@"%@",[self.dictionary1 objectForKey:@"DOES_EXAM"]];
            
              NSString *str_CMT=[NSString stringWithFormat:@"%@",[self.dictionary1 objectForKey:@"DOES_COMMENTS"]];
            if ([str_grd isEqualToString:@"Y"]) {
                [grade setOn:YES animated:YES];
            }
            else
            {
                 [grade setOn:NO animated:YES];
            
            }
            if ([str_EXAM isEqualToString:@"Y"]) {
                 [exam setOn:YES animated:YES];            }
            else
            {
                [exam setOn:NO animated:YES];
                
            }
            

            if ([str_CMT isEqualToString:@"Y"]) {
                [comments setOn:YES animated:YES];
            }
            else
            {
               [comments setOn:NO animated:YES];
                
            }
            

            
            
            
            NSLog(@"child data----%@",arry_sem);
        self.semester.text=[[temp_value objectAtIndex:0]objectForKey:@"TITLE"];
        self.sortname_lbl.text=[NSString stringWithFormat:@"%@",[[temp_value objectAtIndex:0]objectForKey:@"SHORT_NAME"]];
    //    self.begind_lbl.text=[NSString stringWithFormat:@"%@",[self.dictionary1 objectForKey:@"START_DATE"]];
       NSString *end_date=[NSString stringWithFormat:@"%@",[[temp_value objectAtIndex:0]objectForKey:@"END_DATE"]];
        NSString *str_begin=[NSString stringWithFormat:@"%@",[[temp_value objectAtIndex:0]objectForKey:@"POST_START_DATE"]];
       NSString *end_ps=[NSString stringWithFormat:@"%@",[[temp_value objectAtIndex:0]objectForKey:@"POST_END_DATE"]];
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"yyyy-MM-dd"];
         NSString *DATE_STR=[NSString stringWithFormat:@"%@",[self.dictionary1 objectForKey:@"START_DATE"]];
            
            
            
            NSString *MP_TYPE_CHECK=[[temp_value objectAtIndex:0]objectForKey:@"mp_type"];
            if ([MP_TYPE_CHECK isEqualToString:@"school_years"]) {
                HEADER_LBL.text=[NSString stringWithFormat:@"Semester (%lu)",(unsigned long)arry_sem.count];
            }
            
            else if ([MP_TYPE_CHECK isEqualToString:@"school_semesters"])
            {
            
              HEADER_LBL.text=[NSString stringWithFormat:@"Quarter (%lu)",(unsigned long)arry_sem.count];
            }
            else
            {
            HEADER_LBL.text=[NSString stringWithFormat:@"Progress Period (%lu)",(unsigned long)arry_sem.count];
            
            }

            
            [self showdateinLabel:DATE_STR];
            [self showdateinLabel1:end_date];
            [self showdateinLabel2:str_begin];
            [self showdateinLabel3:end_ps];
            
            [self.quater_table reloadData];
        }
        else
        {
          NSString *msg=[NSString stringWithFormat:@"%@",[dic_value objectForKey:@"msg"]];
            UIAlertView *aler=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [aler show];
            
        }
//        for (int i=0; i<=[arry_sem count]; i++) {
//            
//            NSMutableDictionary *semester_dic=[[NSMutableDictionary alloc]init];
//            semester_dic=[arry_sem objectAtIndex:i];
//            self.semester.text=[ semester_dic objectForKey:@"TITLE"];
//            
//          
//        }
//        
//        NSLog(@"markingperiod data---------%@",self.arry_sem);
        
        
        
        [self.quater_table reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        
   }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [operation start];
}


-(void)showdateinLabel:(NSString *)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:dateStr];
    [df setDateFormat:@"MMM dd, yyyy"];
    self.begind_lbl.text = [df stringFromDate:date];
   
    
}
-(void)showdateinLabel1:(NSString *)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:dateStr];
    [df setDateFormat:@"MMM dd, yyyy"];
  
    self.end_lbl.text= [df stringFromDate:date];
   
    
}
-(void)showdateinLabel2:(NSString *)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:dateStr];
    [df setDateFormat:@"MMM dd, yyyy"];
  
    self.grd_pos_bgn.text= [df stringFromDate:date];
   
    
}
-(void)showdateinLabel3:(NSString *)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:dateStr];
    [df setDateFormat:@"MMM dd, yyyy"];
  
    self.grd_pos_end.text= [df stringFromDate:date];
    
}

-(IBAction)cross:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60.0f;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arry_sem.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    UITableViewCell *cell;
    
    if (cell==nil) {
        
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"cell" owner:self options:nil];
        
        cell=[nib objectAtIndex:0];
        
        
    }
    
    quater_label.text=[[arry_sem objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
   NSString *b_date=[[arry_sem objectAtIndex:indexPath.row]objectForKey:@"START_DATE"];
     NSString *en_date=[[arry_sem objectAtIndex:indexPath.row]objectForKey:@"END_DATE"];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:b_date];
    [df setDateFormat:@"MMM dd, yyyy"];
    begins.text=[df stringFromDate:date];
    NSDateFormatter *df2 = [[NSDateFormatter alloc]init];
    [df2 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date2 = [df2 dateFromString:en_date];
    [df setDateFormat:@"MMM dd, yyyy"];
   ends.text=[df stringFromDate:date2];
  
 
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"arysem--------%@",arry_sem);
    str_mp_type=@"";
      mp_id_inside_touch=@"";
    str_mp_type=[[arry_sem objectAtIndex:indexPath.row]objectForKey:@"mp_type"];
     mp_id_inside_touch=[NSString stringWithFormat:@"%@",[[arry_sem objectAtIndex:indexPath.row]objectForKey:@"MARKING_PERIOD_ID"]];
    [self progdata];


}
-(IBAction)action:(UIButton*)sender
{
    
  //  NSString *str1=[ary objectAtIndex:sender.tag];
   // NSLog(@"------%@",str1);
    
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
