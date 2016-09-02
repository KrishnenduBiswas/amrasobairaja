//
//  ClassWorkViewController.m
//  openSiS
//
//  Created by os4ed on 10/28/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "ClassWorkViewController.h"
#import "TeacherDashboardViewController.h"
#import "ClassWorkCell.h"
#import "EditNewAssignmentViewController.h"
#import "AppDelegate.h"
#import "SeenewAssignmentViewController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface ClassWorkViewController () <UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *msg_count_tab;

@property (strong, nonatomic) IBOutlet UIView *view_info;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *view_onlongpress;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UIView *view_sublongpress;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dialogTitle;
@end

@implementation ClassWorkViewController
{
    int multiheight;
    NSMutableArray *arr_assignment;
    NSIndexPath *currentIndex;
}

- (id)init
{
    self = [super init];
    if (self) {
        _dict_main = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

    
    self.msg_count_tab.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
    // Do any additional setup after loading the view.
    arr_assignment = [[NSMutableArray alloc]init];
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressed:)];
    longpress.minimumPressDuration = 1.5;
    longpress.delegate = self;
    [self.tablev addGestureRecognizer:longpress];
    [self.view_onlongpress setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    self.view_onlongpress.opaque = NO;
    [self callgetdata];
    
}
- (void)pressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tablev];
    
    NSIndexPath *indexPath = [self.tablev indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"long press on table view at row %ld", (long)indexPath.row);
        [self appearonlongwithIndex:indexPath];
        
    } else {
        NSLog(@"gestureRecognizer.state = %ld", (long)gestureRecognizer.state);
    }
}
-(void)appearonlongwithIndex:(NSIndexPath*)indexPath
{
    
    currentIndex = indexPath;
    self.lbl_dialogTitle.text = [[arr_assignment objectAtIndex:currentIndex.row] objectForKey:@"TITLE"];
    
    
    [self.view_sublongpress setAlpha:1.0f];
    [self.view addSubview:self.view_onlongpress];
}
-(IBAction)close:(id)sender
{
    [self.view_onlongpress removeFromSuperview];
}


-(void)viewWillAppear:(BOOL)animated
{
    if (self.view.frame.size.height == 568) {
        multiheight = 32;
    }
    else if (self.view.frame.size.height == 667)
    {
        multiheight = 37;
    }
    else if (self.view.frame.size.height == 736)
    {
        multiheight = 41;
    }
   

    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
   // [df setObject:str_t forKey:@"title123"];
    self.lbl_Title.text = [df objectForKey:@"title123"];
    [self designDialog];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.tablev.tableFooterView = [[UIView alloc]init];
    
}
- (IBAction)action_back:(id)sender {
    
   // [self.navigationController popViewControllerAnimated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"assignment"];
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (IBAction)dhongsho:(id)sender {
    
    NSLog(@"Button ta kintu click hocche");
    [self uptable];
}

#pragma mark - Tabbar

-(IBAction)home:(id)sender
{
    
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    // NSLog(@"dic===========%@",dic);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    // vc.dic=dic;
    //vc.dic_techinfo=dic_techinfo;
    // appDelegate.dic=dic;
    //   appDelegate.dic_techinfo=dic_techinfo;
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
    
}
-(IBAction)thirdButton:(id)sender
{
    NSLog(@"Third Button");
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"msg" bundle:nil];
    msg1*obj = [sb instantiateViewControllerWithIdentifier:@"msg1"];
    [self.navigationController pushViewController:obj animated:YES];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings"bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}


#pragma mark - TableView Delegate and DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SeenewAssignmentViewController *obj = [[SeenewAssignmentViewController alloc]init];
    obj = [sb instantiateViewControllerWithIdentifier:@"seeassignment"];
    obj.dict_main = [arr_assignment objectAtIndex:indexPath.row];
    
    
//    NSString *asign_id=[[arr_assignment objectAtIndex:indexPath.row]objectForKey:@"ASSIGNMENT_TYPE_ID"];
//    NSUserDefaults*df=[NSUserDefaults standardUserDefaults];
//    [df setObject:asign_type_id forKey:@"iphone_id"];
    [self.navigationController pushViewController:obj animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_assignment.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cwcell";
    ClassWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (ClassWorkCell *)[[[NSBundle mainBundle] loadNibNamed:@"ClassWorkCell" owner:nil options:nil]objectAtIndex:0];
    }
    cell.clipsToBounds =YES;
    cell.view_noview.backgroundColor = cell.backgroundColor;
    cell.lbl_title.text = [[arr_assignment objectAtIndex:indexPath.row] objectForKey:@"TITLE" ];
    cell.lbl_points.text = [[arr_assignment objectAtIndex:indexPath.row] objectForKey:@"POINTS"];
    NSString *start = [self changeDate:[[arr_assignment objectAtIndex:indexPath.row]objectForKey:@"ASSIGNED_DATE"]];
    NSString *end = [self changeDate:[[arr_assignment objectAtIndex:indexPath.row]objectForKey:@"DUE_DATE"]];
    NSString *totalDatelbltxt = [NSString stringWithFormat:@"Starts : %@ - Ends : %@",start,end];
    cell.lbl_time.text = totalDatelbltxt;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
    
}

#pragma mark - Date Format Changer

-(NSString *)changeDate:(NSString *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *d = [[NSDate alloc]init];
    d = [df dateFromString:date];
    [df setDateFormat:@"MMM/dd/yyy"];
    NSString *datestr = [df stringFromDate:d];
    NSLog(@"DATE STRING ON CHANGE CLASSWORK: %@",datestr);
    
    return datestr;
    
}




#pragma mark - Design

-(void)uptable
{
    
    [UIView animateWithDuration:0.5f animations:^{
        _view_info.frame =
        CGRectMake(_view_info.frame.origin.x,
                   _view_info.frame.origin.y,
                   _view_info.frame.size.width,
                   _view_info.frame.size.height - multiheight);
        
    }];
    
    [UIView animateWithDuration:0.5f animations:^{
        _tablev.frame =
        CGRectMake(_tablev.frame.origin.x,
                   _tablev.frame.origin.y - multiheight,
                   _tablev.frame.size.width,
                   _tablev.frame.size.height+multiheight);
        
    }];
    
}
-(void)designDialog
{
    [_view_sublongpress.layer setCornerRadius:3.0f];
    _view_sublongpress.clipsToBounds = YES;
}






#pragma mark - EDIT and DELETE

- (IBAction)action_delete:(id)sender
{
    NSString *assignmentid = [[arr_assignment objectAtIndex:currentIndex.row] objectForKey:@"ASSIGNMENT_ID"];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
  
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    

    [self deletefromClassWorkwithStaffID:STAFF_ID_K schoolID:school_id year:year_id mpID:mp_id cpvID:cpv_id1 assignmentID:assignmentid school_id:school_id];
    
//    
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    
//    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
//    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
//    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
//    
//    [self deletefromAssignmenttypeswithStaffID:STAFF_ID_K cpvID:cpv_id1 assignmentID:assignmentid];
//    
//    //if ([success isEqualToString:@"1"]) {
//    
//    [self performSelector:@selector(callgetdata)];
    //[self getdataonloadwithStaffid:@"2" andCPV_ID:@"1"];
    [self.tablev reloadData];
    // }
    [self close:nil];
}

- (IBAction)action_edit:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditNewAssignmentViewController *obj = [[EditNewAssignmentViewController alloc]init];
    obj = [sb instantiateViewControllerWithIdentifier:@"editassignment"];
    obj.dict_main = [arr_assignment objectAtIndex:currentIndex.row];
    //obj.dataDIC = [arr_asstypes objectAtIndex:currentIndex.row];
    [self.navigationController pushViewController:obj animated:YES];
    [self close:nil];
    
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






#pragma mark - Data Handlers
-(void)deletefromClassWorkwithStaffID:(NSString *)staffID schoolID:(NSString*)schoolID year:(NSString*)year mpID:(NSString*)mpID cpvID:(NSString *)cpvID assignmentID:(NSString *)assgnmentID school_id:(NSString*)school_id
{
    
    static NSString *success;
    success = [NSString stringWithFormat:@"0"];
    
    ip_url *ipurl = [[ip_url alloc]init];
    NSString *baseurl = [ipurl ipurl];
    
    NSString *thisurl = [NSString stringWithFormat:@"%@/assignments.php?type=delete&staff_id=%@&school_id=%@&syear=%@&mp_id=%@&cpv_id=%@&assignment_id=%@&school_id=%@",baseurl,staffID,schoolID,year,mpID,cpvID,assgnmentID,school_id];
    NSLog(@"value in DELETE THISURL in Model Assignment-------%@",thisurl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:thisurl]];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    // operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"yeayayayaay");
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        // dict = [[NSDictionary alloc]init];
        // dict = dictionary1;
        NSString *successStr = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSString *errstring = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
        if ([successStr isEqualToString:@"1"]) {
            
            [self performSelector:@selector(callgetdata) withObject:self afterDelay:.3f];
            
            
        }
        else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message: errstring delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            
            
        }
        
        NSLog(@"value is dictionary1 in Model Assignment-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
      //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error Retriving Data" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
      //  [alert show];
        NSLog(@"Model Assignment failed with error: %@----",error);
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
}

-(void)callgetdata
{
    NSLog(@"calllllllllllllll hoccheeeeee");
  
//    NSString *str_AssignmentTypeID = [NSString stringWithFormat:@"%@",[_dict_main objectForKey:@"ASSIGNMENT_TYPE_ID"]]
    
    ;
    NSUserDefaults*df=[NSUserDefaults standardUserDefaults];
    NSString *str_assign_id=[df objectForKey:@"iphone_id"];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
 
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    

   
 
  [self getdataonloadwithStaffid:STAFF_ID_K mp_ID:mp_id CPV_ID:cpv_id1 AssignmentType_id:str_assign_id school_id:school_id];
    [self.tablev reloadData];
}

-(void)getdataonloadwithStaffid:(NSString*)staffID  mp_ID:(NSString*)mp_ID CPV_ID:(NSString *)cpvID AssignmentType_id:(NSString *)asstypeID school_id:(NSString*)school_id

{
    
    ip_url *ipurl = [[ip_url alloc]init];
    NSString *baseurl = [ipurl ipurl];
    
    NSString *thisurl = [NSString stringWithFormat:@"%@/assignments.php?type=view&staff_id=%@&mp_id=%@&cpv_id=%@&assignment_type_id=%@school_id=%@",baseurl,staffID,mp_ID,cpvID,asstypeID,school_id];
    NSLog(@"value in THISURL in Model CLASSWork-------%@",thisurl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:thisurl]];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    // operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];// Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"yeayayayaay");
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        // dict = [[NSDictionary alloc]init];
        // dict = dictionary1;
        NSString *successStr = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        //NSString *errstring = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
        if ([successStr isEqualToString:@"1"]) {
            [self.tablev setHidden:NO];
            arr_assignment = [dictionary1 objectForKey:@"assignments"];
           // weight_value=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"weight"]];
            //NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            //[df setObject:weight_value forKey:@"weight1"];
            [self.tablev reloadData];
            NSLog(@"Array Data on CLASSWORK ----- %@ ", arr_assignment);
            
            
        }
        else
        {
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error Retriving Data" message: errstring delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            [alert show];
            [self.tablev setHidden:YES];
            
        }
        
        NSLog(@"value is dictionary1 in Model CLASSWORK-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"Model CLASSWORK failed with error: %@----",error);
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    [self.tablev reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //return dict;
}


@end
