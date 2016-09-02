//
//  GradesTotalViewController.m
//  openSiS
//
//  Created by subhajit halder on 16/11/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "GradesTotalViewController.h"
#import "SlideViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "ip_url.h"
#import "GradesTotalCell.h"
#import "UIImageView+WebCache.h"
#import "GradesAssignmentType.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface GradesTotalViewController ()
<UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIView *baseView;
    IBOutlet UILabel *lbl_nodatafound;
}

@property (strong, nonatomic) IBOutlet UIView *view_topline;
@property (strong, nonatomic) IBOutlet UIView *view_topBar;

@property (strong, nonatomic) IBOutlet UIView *view_total;

- (IBAction)action_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *text_totals;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *view_inactiveswitch;
@property (strong, nonatomic) IBOutlet UISwitch *switch_inactive_students;
- (IBAction)action_switch_inactive:(id)sender;

@end

@implementation GradesTotalViewController
{
    SlideViewController *slide;
    int  flag,k,change,incdecheight,scroller;
    float z;
    NSMutableArray *array_assignment, *array_studentgrades;
    NSString *str_assignmentType_id;
    UIPickerView *selectcustomerpicker;
}
#pragma mark--loaddata
-(void)loadata1
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
   
    NSString*str_checklogin=[NSString stringWithFormat:@"/grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&&include_inactive=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s];
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
        
        self.tablev.hidden = NO;
        lbl_nodatafound.hidden = YES;
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1);
        array_assignment = [[NSMutableArray alloc]init];
        array_studentgrades = [[NSMutableArray alloc]init];
        
        array_studentgrades = [dictionary1 objectForKey:@"student_grades"];
        array_assignment = [dictionary1 objectForKey:@"assignment_types"];
        
        switch_flag=@"0";
        [self.tablev reloadData];
       // student_grades
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        lbl_nodatafound.hidden = NO;
        self.tablev.hidden = YES;
      
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    

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



















#pragma mark-----Active

-(void)activeloadata1
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&&include_inactive=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s];
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
        NSLog(@"value is-------%@",dictionary1);
        array_assignment = [[NSMutableArray alloc]init];
        array_studentgrades = [[NSMutableArray alloc]init];
        
        array_studentgrades = [dictionary1 objectForKey:@"student_grades"];
        array_assignment = [dictionary1 objectForKey:@"assignment_types"];
        
        switch_flag=@"1";
        [self.tablev reloadData];
        // student_grades
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
    
}

-(void)loaddata
{
    
    
    str_s=@"N";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loadata1) withObject:nil afterDelay:0];
        });
    });
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tablev.tableFooterView = [[UIView alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"gradestotal"];
    
    
    
    
    
    
    
    
    
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];

    
    flag =0;k=0;z=0;change =0;
    
    
    if (self.view.frame.size.height == 568) {
        incdecheight = 30;
    }
    else if (self.view.frame.size.height == 667)
    {
        incdecheight = 35;
    }
    else if (self.view.frame.size.height == 736)
    {
        incdecheight = 39;
    }

    lbl_nodatafound.hidden = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

    
    
    
    
    
    
    
    
    
    
    [self dodesign];
    [self pickerfortop];
}



-(void)open
{
    [slide open:self.view];
}
-(void)close
{
    [slide close:nil];
}

#pragma mark - Designs


-(void)dodesign
{
    [_view_total.layer setCornerRadius:1.0f];
    _view_total.clipsToBounds = YES;
    [_view_total.layer setBorderWidth:1.0f];
    _view_total.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
}

#pragma mark - TopViewAnimation

-(IBAction)goup:(id)sender
{
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5f animations:^{
            _view_topBar.frame =
            CGRectMake(_view_topBar.frame.origin.x,
                       _view_topBar.frame.origin.y - incdecheight,
                       _view_topBar.frame.size.width,
                       _view_topBar.frame.size.height);
            _view_topline.frame =
            CGRectMake(_view_topline.frame.origin.x,
                       _view_topline.frame.origin.y - incdecheight,
                       _view_topline.frame.size.width,
                       _view_topline.frame.size.height);
            _tablev.frame =
            CGRectMake(_tablev.frame.origin.x,
                       _tablev.frame.origin.y - incdecheight ,
                       _tablev.frame.size.width,
                       _tablev.frame.size.height + incdecheight);
            _view_inactiveswitch.frame =
            CGRectMake(_view_inactiveswitch.frame.origin.x,
                       _view_inactiveswitch.frame.origin.y - incdecheight,
                       _view_inactiveswitch.frame.size.width,
                       _view_inactiveswitch.frame.size.height);
        }];
        flag = 1;
        
    }
}

-(IBAction)godown:(id)sender
{
    if (flag == 1) {
        [UIView animateWithDuration:0.5f animations:^{
            _view_topBar.frame =
            CGRectMake(_view_topBar.frame.origin.x,
                       _view_topBar.frame.origin.y + incdecheight,
                       _view_topBar.frame.size.width,
                       _view_topBar.frame.size.height);
            _view_topline.frame =
            CGRectMake(_view_topline.frame.origin.x,
                       _view_topline.frame.origin.y + incdecheight,
                       _view_topline.frame.size.width,
                       _view_topline.frame.size.height);
            _tablev.frame =
            CGRectMake(_tablev.frame.origin.x,
                       _tablev.frame.origin.y + incdecheight,
                       _tablev.frame.size.width,
                       _tablev.frame.size.height- incdecheight);
            _view_inactiveswitch.frame =
            CGRectMake(_view_inactiveswitch.frame.origin.x,
                       _view_inactiveswitch.frame.origin.y + incdecheight,
                       _view_inactiveswitch.frame.size.width,
                       _view_inactiveswitch.frame.size.height);
            
        }];
        flag = 0;
        
    }
    
}
-(void)setoffforscroll:(float)y
{
    if (y > z && z == 0) {
        k = 1;
        z = y;
    }
    else if ( y > z && change == 0 )
    {
        k=0;
        z = y;
    }
    else if ( y > z && change == 1 )
    {
        k=1;
        z = y;
    }
    else if (y < z )
    {
        change = 1;
        k = -1;
        z = y;
    }
    else if ( y < z)
    {
        k = 0;
        z = y;
    }
    
    //    else if (y == 0) {
    //        k = -1;
    //        z = y;
    //    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    
    [self setoffforscroll:scrollView.contentOffset.y];
    
    
    
    
    if (k == 1) {
        [self goup:nil];
        
    }
    else if ( k == -1 ){
        [self godown:nil];
        
    }
    
    //NSLog(@"x offset:  %f", scrollView.contentOffset.x);
    //NSLog(@"y offset:  %f", scrollView.contentOffset.y);
}


#pragma mark - TableView Delegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array_studentgrades.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GradesTotalCell *cell = (GradesTotalCell*)[tableView dequeueReusableCellWithIdentifier:@"gradestotalcell" ];
    cell.lbl_name.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"FULL_NAME"];
    cell.lbl_points.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"POINTS"];
   
    cell.lbl_id.text =  [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"STUDENT_ID"];
    NSString *str_grades_all = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"LETTER_GRADE"];
    
 
    if ([switch_flag isEqualToString:@"1"]) {
           NSString *school_status_active=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"ACTIVE"]];
          NSString *course_status_active=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"ACTIVE_SCHEDULE"]];
        cell.lbl_st.hidden=NO;
        cell.lbl_ca.hidden=NO;
        cell.lbl_sa.hidden=NO;
        cell.lbl_cs.hidden=NO;
        cell.lbl_st.text=school_status_active;
        cell.lbl_ca.text=course_status_active;
        
        
    }
    
    else
    {
        cell.lbl_sa.hidden=YES;
        cell.lbl_cs.hidden=YES;
        cell.lbl_st.hidden=YES;
        cell.lbl_ca.hidden=YES;
        
    
    }
    
    NSRange rr = [str_grades_all rangeOfString:@"%"];
 
    if (rr.length == 0) {
        
     
        cell.lbl_grades.hidden=NO;
        [cell.lbl_grades setNumberOfLines:3];
        cell.lbl_grades.text =[NSString stringWithFormat:@"%@", str_grades_all];
        [cell.lbl_grades setLineBreakMode:NSLineBreakByWordWrapping];
        cell.lbl_char_grade.hidden=YES;
    }
  
    
//    else if ([str_grades_all isEqualToString:@""])
//    {
//    
//    
//        cell.lbl_grades.hidden=YES;
//        cell.lbl_char_grade.hidden=YES;
//    
//    }
    
    else
    {
  cell.lbl_char_grade.hidden=NO;
         cell.lbl_grades.hidden=NO;
    NSArray *array_str = [[NSArray alloc]initWithArray:[str_grades_all componentsSeparatedByString:@"%"]];
    NSString *str_gradepoints = [array_str objectAtIndex:0];
//    NSLog(@"hhhhhhhh------ %@", array_str);
    cell.lbl_grades.text =[NSString stringWithFormat:@"%@%%", [[str_gradepoints componentsSeparatedByString:@"%"] objectAtIndex:0]];
    NSString *str_gradestr = [[str_grades_all componentsSeparatedByString:@"%"] objectAtIndex:1];
//    NSLog(@"iiiiiii------ %@", str_gradestr);
   // NSString *str_gradechar = [str_gradestr substringToIndex:1];
        NSString *str_gradechar;
        if (str_gradestr.length > 0) {
            str_gradechar = [str_gradestr substringToIndex:1];
        }

    cell.lbl_char_grade.text = str_gradechar;
    }
    [cell.imageview_profile sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row]objectForKey:@"PHOTO"]]]];
    
    
    return cell;
    
}

#pragma mark - Actions


- (IBAction)action_click:(id)sender {
    [self open];
}
- (IBAction)action_switch_inactive:(id)sender {
    
    if ([self.switch_inactive_students isOn]) {
        str_s=@"Y";
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(activeloadata1) withObject:nil afterDelay:2];
            });
        });
    }
    
    else
    {
    
        str_s=@"N";
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(loadata1) withObject:nil afterDelay:2];
            });
        });
    
    }
    
    
    
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

#pragma mark - picker

-(void)pickerfortop
{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    self.text_totals.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_totals.inputAccessoryView = mypickerToolbar;
    
    
    
}
-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    [self.text_totals resignFirstResponder];
   // gradesassignment
    
    NSString *str_assign=[NSString stringWithFormat:@"%@",self.text_totals.text];
    if ([assign_change isEqualToString:@"1"]) {
        if ([str_assign isEqualToString:@"Totals"]) {
            
            NSLog(@"ok");
            
        }
        
        
        else
        {
        
            UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            GradesAssignmentType *obj=[s instantiateViewControllerWithIdentifier:@"gradesassignment"];
            obj.assign_type_name=self.text_totals.text;
            obj.assign_type_id=str_assignmentType_id;
            [self.navigationController pushViewController:obj animated:YES];
        }
        
    }
    
    else
    {
    
        
    }
    
    
   
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    return [array_assignment count];
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    return [[array_assignment objectAtIndex:row] objectForKey:@"TITLE"];
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
        self.text_totals.text=(NSString *)[[array_assignment objectAtIndex:row] objectForKey:@"TITLE"];
    str_assignmentType_id = [[array_assignment objectAtIndex:row] objectForKey:@"ASSIGNMENT_TYPE_ID"];
    
    NSLog(@"assign_id-----%@",str_assignmentType_id);
    assign_change=@"1";
    
}


@end
