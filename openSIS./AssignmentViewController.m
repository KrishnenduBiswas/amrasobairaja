//
//  AssignmentViewController.m
//  openSiS
//
//  Created by os4ed on 9/25/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "AssignmentViewController.h"
#import "AssignmentTableViewCell.h"
#import "SlideViewController.h"
#import "ClassWorkViewController.h"
#import "EditAssignmentViewController.h"
#import "AppDelegate.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface AssignmentViewController () <UIGestureRecognizerDelegate>

{

    
    
   // NSArray *arr;
   NSMutableArray *arr_asstypes;
    
#pragma mark - for that yellow view
    
    int multiheight;
    
    SlideViewController *slide;
    
    NSString *weight_value;

}
@property (strong, nonatomic) IBOutlet UILabel *msg_count_tab;



- (IBAction)dhongsho:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *view_onlongpress;

@property (strong, nonatomic) IBOutlet UIView *view_sublongpress;

@property (strong, nonatomic) IBOutlet UIView *view_info;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dialogTitle;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *baseView;



@end

@implementation AssignmentViewController
{
    NSIndexPath *currentIndex;
    NSMutableDictionary *dict_main;
}
@synthesize baseView;
- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.msg_count_tab.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    arr_asstypes = [[NSMutableArray alloc]init];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    [self getdataonloadwithStaffid:STAFF_ID_K andCPV_ID:cpv_id1 school_id:school_id];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"assignment"];
    
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //[self loaddata];
    //[self getdataonloadwithStaffid];
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressed:)];
    longpress.minimumPressDuration = 1.5;
    longpress.delegate = self;
        [self.tablev addGestureRecognizer:longpress];
    [self.view_onlongpress setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6f] ];
    //[self.view_onlongpress setAlpha:0.75f];
    self.view_onlongpress.opaque = NO;
    NSLog(@"array on view did load: %@", arr_asstypes);
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



-(void)appearonlongwithIndex:(NSIndexPath*)indexPath
{
    
    currentIndex = indexPath;
    self.lbl_dialogTitle.text = [[arr_asstypes objectAtIndex:currentIndex.row] objectForKey:@"TITLE"];
    
    //self.view_onlongpress = [[UIView alloc]initWithFrame:self.view];
    //[self.view_onlongpress setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
    [self.view_sublongpress setAlpha:1.0f];
    [self.view addSubview:self.view_onlongpress];
}

-(IBAction)close:(id)sender
{
    [self.view_onlongpress removeFromSuperview];
}








-(IBAction)click:(id)sender
{
    [self open];
}

- (IBAction)back:(id)sender {
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
    [self designDialog];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tablev reloadData];
    self.tablev.tableFooterView = [[UIView alloc]init];
    //[self.tablev reloadData];

}

-(void)open
{
    [slide open:self.view];
}

-(void)close
{
    [slide close:nil];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    [self getdataonloadwithStaffid:STAFF_ID_K andCPV_ID:cpv_id1 school_id:school_id];
}


#pragma mark - Data Handlers


-(void)deletefromAssignmenttypeswithStaffID:(NSString *)staffID cpvID:(NSString *)cpvID assignmentID:(NSString *)assgnmentID school_id:(NSString*)school_id
{
    
    static NSString *success;
    success = [NSString stringWithFormat:@"0"];
    
    ip_url *ipurl = [[ip_url alloc]init];
    NSString *baseurl = [ipurl ipurl];
    
    NSString *thisurl = [NSString stringWithFormat:@"%@/assignment_types.php?type=delete&staff_id=%@&cpv_id=%@&assignment_type_id=%@&school_id=%@",baseurl,staffID,cpvID,assgnmentID,school_id];
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"Model Assignment failed with error: %@----",error);
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
}

//-(void)loaddata
//{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //[MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self performSelector:@selector(callgetdata) withObject:nil afterDelay:0];
//        });
//    });
//    [self.tablev reloadData];
//}
-(void)callgetdata
{
    NSLog(@"calllllllllllllll hoccheeeeee");
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    [self getdataonloadwithStaffid:STAFF_ID_K  andCPV_ID:cpv_id1 school_id:school_id];
    [self.tablev reloadData];
}

-(void)getdataonloadwithStaffid:(NSString*)staffID andCPV_ID:(NSString *)cpvID school_id:(NSString*)school_id
//-(void)getdataonloadwithStaffid
{
    //static NSDictionary *dict ;
    
//    NSString *saff_id=@"2";
//    NSString *cpv_id=@"1";
   // static NSMutableArray *temparr ;
    //temparr = [[NSMutableArray alloc]init];
    ip_url *ipurl = [[ip_url alloc]init];
    NSString *baseurl = [ipurl ipurl];
    
    NSString *thisurl = [NSString stringWithFormat:@"%@/assignment_types.php?type=view&staff_id=%@&cpv_id=%@&school_id=%@",baseurl,staffID,cpvID,school_id];
    NSLog(@"value in THISURL in Model Assignment-------%@",thisurl);
    
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
      //  NSString *errstring = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
        if ([successStr isEqualToString:@"1"]) {
            [self.tablev setHidden:NO];
            dict_main = [[NSMutableDictionary alloc]init];
            dict_main = dictionary1;
            arr_asstypes = [dictionary1 objectForKey:@"assignment_types"];
            weight_value=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"weight"]];
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:weight_value forKey:@"weight1"];
            [self.tablev reloadData];
            NSLog(@"Array Data on Assignment ----- %@ ", arr_asstypes);
            
            
        }
        else
        {
             [self.tablev setHidden:YES];
              //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error Retriving Data" message: errstring delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
             //   [alert show];
            arr_asstypes = nil;

        }
        
        NSLog(@"value is dictionary1 in Model Assignment-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        arr_asstypes = nil;
        [self.tablev reloadData];
        //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error Retriving Data" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
       // [alert show];
        NSLog(@"Model Assignment failed with error: %@----",error);
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
   [self.tablev reloadData];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //return dict;
}





#pragma mark - designs

-(void)tablereload
{
    [self.tablev reloadData];
}

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


#pragma mark - UITableView Delegate Datasource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ClassWorkViewController *obj = [[ClassWorkViewController alloc]init];
        obj = [sb instantiateViewControllerWithIdentifier:@"classwork"];
    obj.dict_main = [arr_asstypes objectAtIndex:indexPath.row];
    
    
    NSString *asign_type_id=[[arr_asstypes objectAtIndex:indexPath.row]objectForKey:@"ASSIGNMENT_TYPE_ID"];
      NSString *title=[[arr_asstypes objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    NSUserDefaults*df=[NSUserDefaults standardUserDefaults];
    [df setObject:asign_type_id forKey:@"iphone_id"];
    [df setObject:title forKey:@"title123"];
    [self.navigationController pushViewController:obj animated:YES];
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_asstypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ascell";
    AssignmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = (AssignmentTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"AssignmentTableViewCell" owner:nil options:nil]objectAtIndex:0];
    }
    cell.clipsToBounds =YES;
    cell.view_noview.backgroundColor = cell.backgroundColor;
    cell.lbl_title.text = [[arr_asstypes objectAtIndex:indexPath.row] objectForKey:@"TITLE" ];
    
    if ([weight_value isEqualToString:@"N"]) {
        
        cell.lbl_marks.hidden=YES;
        
    }
    
    else
    {
     cell.lbl_marks.hidden=NO;
    NSString *str_percent = [NSString stringWithFormat:@"%@",[[arr_asstypes objectAtIndex:indexPath.row]objectForKey:@"FINAL_GRADE_PERCENT"]];
    float p = [str_percent floatValue];
    NSString *totalp = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"total_percentage"]];
    float int_totalp = (float)[totalp floatValue];
    NSString *marks = [NSString stringWithFormat:@"%.2f%% / %.2f%%",p,int_totalp];
    cell.lbl_marks.text = marks ;
    }

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
    return 54.0f;
    
}



- (IBAction)dhongsho:(id)sender {
    
  
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
#pragma mark - EDIT and DELETE

- (IBAction)action_delete:(id)sender
{
    NSString *assignmentid = [[arr_asstypes objectAtIndex:currentIndex.row] objectForKey:@"ASSIGNMENT_TYPE_ID"];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    [self deletefromAssignmenttypeswithStaffID:STAFF_ID_K cpvID:cpv_id1 assignmentID:assignmentid school_id:school_id];
    
    //if ([success isEqualToString:@"1"]) {
    
    [self performSelector:@selector(callgetdata)];
    //[self getdataonloadwithStaffid:@"2" andCPV_ID:@"1"];
    [self.tablev reloadData];
    // }
    [self close:nil];
}

- (IBAction)action_edit:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EditAssignmentViewController *obj = [[EditAssignmentViewController alloc]init];
    obj = [sb instantiateViewControllerWithIdentifier:@"editassignmenttype"];
    obj.dataDIC = [arr_asstypes objectAtIndex:currentIndex.row];
    [self.navigationController pushViewController:obj animated:YES];
    [self close:nil];
    
}



@end
