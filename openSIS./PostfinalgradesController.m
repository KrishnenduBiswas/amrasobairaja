//
//  PostfinalgradesController.m
//  openSiS
//
//  Created by os4ed on 11/23/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "PostfinalgradesController.h"
#import "SlideViewController.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "Postfinalgradecell.h"

#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "MBProgressHUD.h"
#import "ip_url.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface PostfinalgradesController ()
<UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIView *baseView;
    IBOutlet UIView *view1236;
    IBOutlet UIPickerView *pick12;
    NSMutableArray *arr;
    NSInteger flag_main;
}

@property (strong, nonatomic) IBOutlet UIView *view_topline;
@property (strong, nonatomic) IBOutlet UIView *view_topBar;
@property (strong, nonatomic) IBOutlet UIButton *btn_ass_letters;
@property (strong, nonatomic) IBOutlet UIButton *btn_ass_percent;
@property (strong, nonatomic) IBOutlet UILabel *label_nodataFound;

@property (strong, nonatomic) IBOutlet UILabel *label_previousquater2;

@property (strong, nonatomic) IBOutlet UIView *view_total;
@property (strong, nonatomic) IBOutlet UIView *view_greyunderbluetop;
@property (strong, nonatomic) IBOutlet UIView *view_gery_sub1;
@property (strong, nonatomic) IBOutlet UIView *view_grey_sub2;
@property (strong, nonatomic) IBOutlet UIView *view_new_mpid;

- (IBAction)action_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *text_totals;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *view_inactiveswitch;
@property (strong, nonatomic) IBOutlet UISwitch *switch_inactive_students, *switch_fetch_gradebook, *switch_fetch_grade, *switch_fetch_comment;
@property (strong, nonatomic) IBOutlet UITextField *text_new_mpid;
- (IBAction)action_switch_inactive:(id)sender;
- (IBAction)action_assignletters:(id)sender;
- (IBAction)action_assignpercents:(id)sender;
- (IBAction)action_fetchgradebookgrades:(id)sender;
- (IBAction)action_reset:(id)sender;
- (IBAction)action_save:(id)sender;
- (IBAction)comment_saved:(id)sender;

- (IBAction)action_fetch_switch:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *label_previousQuater;

@property (strong, nonatomic) IBOutlet UIView *view_fetchForeground;

@property (strong, nonatomic) IBOutlet UIView *view_fetchBackground;

@property (strong, nonatomic) IBOutlet UITextView *textview_comment;
@property (strong, nonatomic) IBOutlet UILabel *label_comentname;


@property (strong, nonatomic) IBOutlet UIView *view_commentBackground;

@property (strong, nonatomic) IBOutlet UIView *view_commentForeground;



@end

@implementation PostfinalgradesController
{
    SlideViewController *slide;
    int  flag,k,change,incdecheight,scroller;
    float z;
    NSMutableArray *array_reportcardgrades, *array_studentgrades,*course_period_ary,*course_period_title,*course_period_id, *array_newcourseperiod;
    NSString *str_reportcardgrades_id, *courseperiodnamestr, *str_previously_selected_mpid, *str_currently_Selected_new_mpid;
    UIPickerView *selectcustomerpicker, *picker_newmp;
    NSInteger selectedindexpath;
    NSMutableDictionary *dicto,*dic_techinfo;
    NSInteger fetchtag;
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
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=3&syear=2015&staff_id=18&cpv_id=40&mp=36&include_inactive=Y
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/post_final_grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp=%@&include_inactive=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s];
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
        array_reportcardgrades = [[[NSMutableArray alloc]init]mutableCopy];
        array_studentgrades = [[[NSMutableArray alloc]init]mutableCopy];
        array_newcourseperiod = [[[NSMutableArray alloc]init]mutableCopy];
         NSString *successStr = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        
         if ([successStr isEqualToString:@"1"]) {
              [self.label_nodataFound setHidden:YES];
             [self.tablev setHidden:NO];
        array_studentgrades = [dictionary1 objectForKey:@"student_grades"];
        array_reportcardgrades = [dictionary1 objectForKey:@"report_card_grades"];
        dicto = [[NSMutableDictionary alloc]init];
        dicto = [dictionary1 objectForKey:@"previous_mp_data"];
        array_newcourseperiod = [dictionary1 objectForKey:@"mps_dd_data"];
             str_previously_selected_mpid = [dictionary1 objectForKey:@"dd_selected_mp"];

        [self.tablev reloadData];
        [pick12 reloadAllComponents];
             [picker_newmp reloadAllComponents];
         }
        else
        {
            [self.tablev setHidden:YES];
            [self.label_nodataFound setHidden:NO];
        }
        
        // student_grades
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
    
}
-(void)loadata2
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
    
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=3&syear=2015&staff_id=18&cpv_id=40&mp=36&include_inactive=Y&mp_id=31
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/post_final_grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp=%@&include_inactive=%@&mp_id=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s,str_currently_Selected_new_mpid];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    NSString *urlEncoded = [url12 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"----%@",url12);
   // NSURL *url = [NSURL URLWithString:url12];
   // NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest  *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlEncoded]];
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1);
        array_reportcardgrades = [[[NSMutableArray alloc]init]mutableCopy];
        array_studentgrades = [[[NSMutableArray alloc]init]mutableCopy];
        array_newcourseperiod = [[[NSMutableArray alloc]init]mutableCopy];
        NSString *successStr = [NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        
        if ([successStr isEqualToString:@"1"]) {
            [self.label_nodataFound setHidden:YES];
            [self.tablev setHidden:NO];
            array_studentgrades = [dictionary1 objectForKey:@"student_grades"];
            array_reportcardgrades = [dictionary1 objectForKey:@"report_card_grades"];
            dicto = [[NSMutableDictionary alloc]init];
            dicto = [dictionary1 objectForKey:@"previous_mp_data"];
            array_newcourseperiod = [dictionary1 objectForKey:@"mps_dd_data"];
            str_previously_selected_mpid = [dictionary1 objectForKey:@"dd_selected_mp"];
            
            [self.tablev reloadData];
            [pick12 reloadAllComponents];
            [picker_newmp reloadAllComponents];
        }
        else
        {
            [self.tablev setHidden:YES];
            [self.label_nodataFound setHidden:NO];
        }
        
        // student_grades
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
    
}

#pragma mark-------Getdata
-(NSString *)getCourseperiodtextfielddata
{
    courseperiodnamestr = [NSString stringWithFormat:@"%@",self.text_totals.text];
    return courseperiodnamestr;
}
#pragma mark-------setdata
-(void)setCourseperiodtextfielddata:(NSString*)str
{
    courseperiodnamestr=str;
    self.text_totals.text = courseperiodnamestr;
}


#pragma mark-----Active



-(void)loaddata
{
    
    
    str_s=@"N";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loadata1) withObject:nil afterDelay:1];
        });
    });
    
    
    
}
-(void)loaddata2
{
    
    
    str_s=@"N";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loadata2) withObject:nil afterDelay:1];
        });
    });
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn_ass_percent.titleLabel setTextColor:[UIColor blackColor]];
    [self loaddata];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"postfinalgrades"];
    [slide setcourseperiod];
    
    array_studentgrades = [[[NSMutableArray alloc]init]mutableCopy];
    array_reportcardgrades = [[[NSMutableArray alloc]init]mutableCopy];
    
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
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(fetchdata) userInfo:nil repeats:YES];
    
    
    
    

    
    
    
    [self dodesign];
    [self pickerfortop];
    [self pickerfornewmp];
    flag_main = 0;
    self.view_commentBackground.hidden = YES;
    [self.view_fetchBackground setHidden:YES];
    [self dataforcpn];
    
    [self.label_nodataFound setHidden:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.btn_ass_letters setBackgroundColor:[UIColor colorWithRed:0.302f green:0.580f blue:0.306f alpha:1.00f]];
    [self.btn_ass_percent.titleLabel setTextColor:[UIColor blackColor]];
    self.text_new_mpid.text = @"Not Provided";
    for (int i = 0; i < array_newcourseperiod.count; ++i) {
        NSString *str_i = (NSString *)[[array_newcourseperiod objectAtIndex:i] objectForKey:@"id"];
        if ([str_i isEqualToString:str_previously_selected_mpid]) {
            self.text_new_mpid.text = (NSString *)[[array_newcourseperiod objectAtIndex:i] objectForKey:@"value"];
            break;
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.btn_ass_percent.titleLabel setTextColor:[UIColor blackColor]];
}

- (void) dataforcpn
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
   // dic_techinfo=appDelegate.dic_techinfo;
    dic_techinfo = [[[NSMutableDictionary alloc]init] mutableCopy];
    course_period_ary = [[[NSMutableArray alloc]init] mutableCopy];
    
    dic_techinfo=appDelegate.dic;
    
    
    NSLog(@"dic===========%@",dic_techinfo);
    
    
    course_period_ary=[[dic_techinfo objectForKey:@"course_period_list"]mutableCopy];
    
    NSLog(@"arrrrrrrrrrrrrr %@",course_period_ary);
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
       // course_period_title = [course_period_ary valueForKey:[NSString stringWithFormat:@"title"]];
       // course_period_id = [course_period_ary valueForKey:@"cpv_id"];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
        }
//            //[ca_cp_id addObject:[dic15 objectForKey:@"cp_id"]];
//            
//
        NSLog(@"222222222222222 %@",course_period_title);
        [selectcustomerpicker reloadAllComponents];
        
    }
    else {
        NSLog(@"No  list");
    }
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSInteger indexofcpv = [course_period_id indexOfObject:cpv_id1];
    [self setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@",[course_period_title objectAtIndex:indexofcpv]]];

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
    
    [_view_new_mpid.layer setCornerRadius:1.0f];
    _view_new_mpid.clipsToBounds = YES;
    [_view_new_mpid.layer setBorderWidth:1.0f];
    _view_new_mpid.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
    [_view_gery_sub1.layer setCornerRadius:2.0f];
    _view_gery_sub1.clipsToBounds = YES;
    [_view_gery_sub1.layer setBorderWidth:1.0f];
    _view_gery_sub1.layer.borderColor = [[UIColor darkTextColor]CGColor];
    
    [_view_grey_sub2.layer setCornerRadius:2.0f];
    _view_grey_sub2.clipsToBounds = YES;
    [_view_grey_sub2.layer setBorderWidth:1.0f];
    _view_grey_sub2.layer.borderColor = [[UIColor darkTextColor]CGColor];
    
    [_view_commentForeground.layer setCornerRadius:3.0f];
    _view_commentForeground.clipsToBounds = YES;
    [_view_commentForeground.layer setBorderWidth:1.0f];
    _view_commentForeground.layer.borderColor = [[UIColor darkTextColor]CGColor];

    [self.view_commentBackground setAlpha:0.75f];
    [self.view_commentForeground setAlpha:1.0f];
    self.textview_comment.layer.borderWidth=1.0;
    self.textview_comment.layer.borderColor=[[UIColor lightGrayColor]CGColor ];
    

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
            
            _view_greyunderbluetop.frame =
            CGRectMake(_view_greyunderbluetop.frame.origin.x,
                       _view_greyunderbluetop.frame.origin.y - incdecheight,
                       _view_greyunderbluetop.frame.size.width,
                       _view_greyunderbluetop.frame.size.height);

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
            _view_greyunderbluetop.frame =
            CGRectMake(_view_greyunderbluetop.frame.origin.x,
                       _view_greyunderbluetop.frame.origin.y + incdecheight,
                       _view_greyunderbluetop.frame.size.width,
                       _view_greyunderbluetop.frame.size.height);
            
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
    Postfinalgradecell *cell;
    if (flag_main == 0) {
         cell = (Postfinalgradecell *)[tableView dequeueReusableCellWithIdentifier:@"postfinalgradecell"];
    }
    else
    {
            cell = (Postfinalgradecell *)[tableView dequeueReusableCellWithIdentifier:@"postfinalgradecellpercent"];
    }
    
   
    cell.lbl_name.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"FULL_NAME"];
    cell.lbl_id.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"STUDENT_ID"];
    cell.lbl_grades.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"REPORT_CARD_GRADE_TITLE"];
    
    NSString *str = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"REPORT_CARD_GRADE_TITLE"];
    if (flag_main == 1) {
        if ([str isEqualToString:@"(null)"] || [ str isEqualToString:@""]) {
            cell.lbl_grades.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            cell.lbl_grades.backgroundColor = [UIColor colorWithRed:0.302f green:0.580f blue:0.306f alpha:1.00f];
        }
    }
    
//    NSString *str = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"REPORT_CARD_GRADE"];
//    if (str) {
//        ;
//    }
//    else
//    {
//        str = @"";
//    }
//    
//    NSString *new_strgrades = [NSString stringWithFormat:@"%@",[dicto objectForKey:str]];
//    
//    if (new_strgrades) {
//        if ([new_strgrades isEqualToString:@"(null)"] || [new_strgrades isEqualToString:@""] )
//        {
//            new_strgrades = @"  ";
//        }
//        
//    }
//    else
//    {
//        new_strgrades = @"  ";
//    }
//    
//    cell.lbl_grades.text = [new_strgrades substringToIndex:1];    //[NSString stringWithFormat:@"%@",[dicto objectForKey:str]];
    //NSLog(@"this the array %@ , this is str: %@ , this is next: %@", dicto, str, [NSString stringWithFormat:@"%@",[dicto objectForKey:str]]);
    
    
    cell.btn_grades.tag = indexPath.row;
    [cell.btn_grades addTarget:self action:@selector(atten1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *cmnt = [NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"COMMENT"] ];
    if (cmnt) {
        if ([cmnt isEqualToString:@""] || [cmnt isEqualToString:@"(null)"] || [cmnt isEqualToString:@" "]) {
            cell.btn_comment.image = [UIImage imageNamed:@"grey-Comment"];
        }
        else{
            cell.btn_comment.image = [UIImage imageNamed:@"comment"];
        }
    }
    else
    {
        cell.btn_comment.image = [UIImage imageNamed:@"grey-Comment"];
    }
    
    
    NSString *str_per = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"GRADE_PERCENT"];
    if (str_per) {
        if ([str_per isEqualToString:@""] || [str_per isEqualToString:@"(null)"] || [str_per isEqualToString:@" "]) {
            cell.lbl_percent.text = @"";
        }
        else
        {
            cell.lbl_percent.text = [[str_per componentsSeparatedByString:@"%"] objectAtIndex:0];
        }
    }
    else
    {
        cell.lbl_percent.text = @"";
    }
    
    cell.btn_comment_toclick.tag = indexPath.row;
    [cell.btn_comment_toclick addTarget:self action:@selector(commentonit:) forControlEvents:UIControlEventTouchUpInside];

    
    
    return cell;
}

-(IBAction)commentonit:(UIButton*)sender
{
//    NSLog(@"jkdjkskdjksjd");
    selectedindexpath = sender.tag;
    [self.view_commentBackground setHidden:NO];
    self.label_comentname.text  = [[array_studentgrades objectAtIndex:selectedindexpath] objectForKey:@"FULL_NAME"];
    self.textview_comment.text = [[array_studentgrades objectAtIndex:selectedindexpath] objectForKey:@"COMMENT"];
    
}

-(IBAction)atten1:(UIButton*)sender
{
    
    if (flag_main == 0) {
        UIButton *button = sender;
        
        selectedindexpath = button.tag;
        //    UIView *view123=[[UIView alloc]init];
        //    view123.frame=CGRectMake(0, 0, 200, 100);
        //    view123.backgroundColor=[UIColor redColor];
        CGPoint midpoint;
        midpoint.x = super.view.frame.size.width / 2;
        midpoint.y = super.view.frame.size.height / 2;
        view1236.center = CGPointMake(midpoint.x, midpoint.y);
        
        view1236.hidden=NO;
        //pick12.hidden = NO;
        //[view1236 addSubview:pick12];
        // [view1236 bringSubviewToFront:pick12];
        //[self.view addSubview:view1236];
        [self.view bringSubviewToFront:view1236];
    }
    else
    {
        UIButton *button = sender;
        
        selectedindexpath = button.tag;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter the points" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 5;
        [alert show];
        
    }
    
    
    NSLog(@"---------");
    
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




#pragma mark - Alert Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    
    
    
    if(alertView.tag == 5){
        if([[alertView textFieldAtIndex:0].text isEqualToString:@""]){
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        else
        {
            
            NSString *str_toreplc =[NSString stringWithFormat:@"%@%%",[alertView textFieldAtIndex:0].text] ;
            
            NSMutableArray *arraytemp = [[NSMutableArray alloc]init];
            arraytemp = [array_studentgrades mutableCopy];
            
            NSMutableDictionary *diction_mu = [[[NSMutableDictionary alloc]init]mutableCopy];
            NSDictionary *dico = [array_studentgrades objectAtIndex:selectedindexpath];
            diction_mu = [dico mutableCopy];
            
            //diction_mu = [[array_studentgrades objectAtIndex:(unsigned long)selectedindexpath]mutableCopy];
            [diction_mu setObject:str_toreplc forKey:@"GRADE_PERCENT"];
            //[diction_mu setObject:str_title forKey:@"REPORT_CARD_GRADE_TITLE"];
            //        [array_studentgrades replaceObjectAtIndex:selectedindexpath withObject:diction_mu];
            
            [arraytemp replaceObjectAtIndex:selectedindexpath withObject:diction_mu];
            
            array_studentgrades = [arraytemp mutableCopy];
            
            [self.tablev reloadData];
        }
        
    }
    
    
    
}



#pragma mark - Actions

- (IBAction)action_fetchNow:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(getdataOnFetch) withObject:nil afterDelay:2];
        });
    });
    
    [self.view_fetchBackground setHidden:YES];

}

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
                [self performSelector:@selector(loadata1) withObject:nil afterDelay:2];
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


- (IBAction)action_assignletters:(id)sender {
    flag_main = 0;
    [self.tablev reloadData];
    [self.btn_ass_letters setBackgroundColor:[UIColor colorWithRed:0.302f green:0.580f blue:0.306f alpha:1.00f]];
    [self.btn_ass_letters.titleLabel setTextColor:[UIColor whiteColor]];
    
    [self.btn_ass_percent setBackgroundColor:[UIColor whiteColor]];
    [self.btn_ass_percent.titleLabel setTextColor:[UIColor darkTextColor]];
    
}
- (IBAction)action_save:(id)sender {
    if (flag_main == 0) {
        //[self savedataonGrades];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(savedataonGrades) withObject:nil afterDelay:1];
            });
        });

    }
    else
    {
       // [self savedataonAssignments];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(savedataonAssignments) withObject:nil afterDelay:1];
            });
        });

    }
}

- (IBAction)comment_saved:(id)sender {
    
   NSMutableArray *arraytemp = [[NSMutableArray alloc]init];
    arraytemp = [array_studentgrades mutableCopy];
    
    NSMutableDictionary *diction_mu = [[[NSMutableDictionary alloc]init]mutableCopy];
    NSDictionary *dico = [array_studentgrades objectAtIndex:selectedindexpath];
    diction_mu = [dico mutableCopy];
    
    
    [diction_mu setObject:self.textview_comment.text forKey:@"COMMENT"];
   
    //        [array_studentgrades replaceObjectAtIndex:selectedindexpath withObject:diction_mu];
    
    [arraytemp replaceObjectAtIndex:selectedindexpath withObject:diction_mu];
    
    array_studentgrades = [arraytemp mutableCopy];
    self.view_commentBackground.hidden = YES;
    //[view1236 removeFromSuperview];
    [self.tablev reloadData];

    
}

- (IBAction)action_fetch_switch:(UISwitch *)sender {
    
    
        if (sender.tag == 10) {
            if ([sender isOn]) {
                fetchtag = 10;
                [self.switch_fetch_grade setOn:NO animated:YES];
                [self.switch_fetch_comment setOn:NO animated:YES];
            }
            else
            {
                fetchtag = 0;
            }
            
            
            
        }
        else if (sender.tag == 20) {
            if ([sender isOn]) {
                fetchtag = 20;
                [self.switch_fetch_gradebook setOn:NO animated:YES];
                [self.switch_fetch_comment setOn:NO animated:YES];
            }
            else
            {
                fetchtag = 0;
            }

            
            
            
        }
        else if (sender.tag == 30) {
            if ([sender isOn]) {
                fetchtag = 30;
                [self.switch_fetch_gradebook setOn:NO animated:YES];
                [self.switch_fetch_grade setOn:NO animated:YES];
            }
            else
            {
                fetchtag = 0;
            }

            
            
        }
}

- (IBAction)action_assignpercents:(id)sender {
    flag_main = 1;
    [self.tablev reloadData];
    
    [self.btn_ass_percent setBackgroundColor:[UIColor colorWithRed:0.302f green:0.580f blue:0.306f alpha:1.00f]];
    [self.btn_ass_percent.titleLabel setTextColor:[UIColor whiteColor]];
    
    [self.btn_ass_letters setBackgroundColor:[UIColor whiteColor]];
    [self.btn_ass_letters.titleLabel setTextColor:[UIColor darkTextColor]];
    
    
}

- (IBAction)action_fetchgradebookgrades:(id)sender {
    
    [self.view_fetchBackground setHidden:NO];
    [self.label_previousQuater setHidden:NO];
    [self.label_previousquater2 setHidden:NO];
    
    [self.switch_fetch_comment setEnabled:YES];
    [self.switch_fetch_grade setEnabled:YES];
    NSLog(@"oi bhai %@",dicto);
    NSString *nullornot = [NSString stringWithFormat:@"%@",dicto];
    //NSNull *null;
    if ( ![nullornot isEqualToString:@"<null>"] ) {
        NSLog(@"tao dhuklo");
        self.label_previousQuater.text = [NSString stringWithFormat:@"Get %@ Grades",[dicto objectForKey:@"TITLE"]] ;
        self.label_previousquater2.text = [NSString stringWithFormat:@"Get %@ Comments",[dicto objectForKey:@"TITLE"]];
        self.label_previousQuater.textColor = [UIColor darkTextColor];
        self.label_previousquater2.textColor = [UIColor darkTextColor];
        [self.label_previousQuater sizeToFit];
        self.label_previousquater2.textColor = [UIColor darkTextColor];
        [self.label_previousquater2 sizeToFit];
    }
    else
    {
        self.label_previousQuater.text = [NSString stringWithFormat:@"No Previous Quater"] ;
        self.label_previousquater2.text = [NSString stringWithFormat:@"No Previous Quater"];
        self.label_previousQuater.textColor = [UIColor lightGrayColor];
        self.label_previousquater2.textColor = [UIColor lightGrayColor];
        [self.label_previousQuater sizeToFit];
        [self.label_previousquater2 sizeToFit];
        //[self.label_previousQuater setHidden:YES];
        //[self.label_previousquater2 setHidden:YES];
        [self.switch_fetch_comment setEnabled:NO];
        [self.switch_fetch_grade setEnabled:NO];
    }
    
    
    
    
}

- (IBAction)action_reset:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(getDataOnReset) withObject:nil afterDelay:2];
        });
    });

    
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
    
    selectcustomerpicker .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    selectcustomerpicker.tag = 1;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    //selectcustomerpicker.tag=60;
    self.text_totals.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1:)];
    doneBtn.tag = 11;
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_totals.inputAccessoryView = mypickerToolbar;
    
    
    
}

-(void)pickerfornewmp
{
    
    picker_newmp = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    picker_newmp .delegate = self;
    
    picker_newmp .dataSource = self;
    picker_newmp.tag = 2;
    
    [ picker_newmp  setShowsSelectionIndicator:YES];
    //selectcustomerpicker.tag=60;
    self.text_new_mpid.inputView = picker_newmp;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1:)];
    doneBtn.tag = 22;
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_new_mpid.inputAccessoryView = mypickerToolbar;
    
    
    
}


-(IBAction)pickerDoneClicked1:(UIBarButtonItem *)sender

{
    NSLog(@"Done Clicked");
    [self.text_totals resignFirstResponder];
    [self.text_new_mpid resignFirstResponder];
    
    view1236.hidden = YES;
    //[view1236 removeFromSuperview];
    if (sender.tag == 11) {
        [self loaddata];
    }
    
    if (sender.tag == 22) {
       [self loaddata2] ;
    }
    
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    if (pickerView.tag == 500) {
        return 1;
    }
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView.tag ==500) {
        
        return array_reportcardgrades.count;
    }
    
    if (pickerView.tag == 1) {
        return course_period_title.count;
    }
    if (pickerView.tag == 2) {
        return array_newcourseperiod.count;
    }
    return 0;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView.tag == 500) {
        return [[array_reportcardgrades objectAtIndex:row] objectForKey:@"TITLE"];
    }
    if (pickerView.tag == 1) {
        return [course_period_title objectAtIndex:row];
    }
    if (pickerView.tag == 2) {
        return [[array_newcourseperiod objectAtIndex:row] objectForKey:@"value"];
    }
    
    return nil;
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (pickerView == pick12) {
        
        str_reportcardgrades_id = [NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:row] objectForKey:@"ID"]];
        NSString *str_title = [NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:row] objectForKey:@"TITLE"]];
        
        NSMutableArray *arraytemp = [[NSMutableArray alloc]init];
        arraytemp = [array_studentgrades mutableCopy];
        
        NSMutableDictionary *diction_mu = [[[NSMutableDictionary alloc]init]mutableCopy];
        NSDictionary *dico = [array_studentgrades objectAtIndex:selectedindexpath];
        diction_mu = [dico mutableCopy];
        
        //diction_mu = [[array_studentgrades objectAtIndex:(unsigned long)selectedindexpath]mutableCopy];
        [diction_mu setObject:str_reportcardgrades_id forKey:@"REPORT_CARD_GRADE"];
        [diction_mu setObject:str_title forKey:@"REPORT_CARD_GRADE_TITLE"];
//        [array_studentgrades replaceObjectAtIndex:selectedindexpath withObject:diction_mu];
        
        [arraytemp replaceObjectAtIndex:selectedindexpath withObject:diction_mu];
        
        array_studentgrades = [arraytemp mutableCopy];
        view1236.hidden = YES;
        //[view1236 removeFromSuperview];
        [self.tablev reloadData];

    }
    if (pickerView.tag == 1) {
        self.text_totals.text=(NSString *)[course_period_title objectAtIndex:row];
        // coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_period_id objectAtIndex:row];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic = [[[NSMutableDictionary alloc]init]mutableCopy];
        dic = [appDelegate.dic mutableCopy];
        [dic setObject:strC1 forKey:@"UserCoursePeriodVar"];
        appDelegate.dic = [dic mutableCopy];
        
    }
    if (pickerView.tag == 2) {
        self.text_new_mpid.text = (NSString*)[[array_newcourseperiod objectAtIndex:row] objectForKey:@"value"];
        str_currently_Selected_new_mpid = (NSString *)[[array_newcourseperiod objectAtIndex:row] objectForKey:@"id"];
    }
    
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - senders

- (void)savedataonGrades
{
    NSString *cmt,*point;
    NSMutableArray *arrData=[[NSMutableArray alloc]init];
    
    for(int i=0;i<[array_studentgrades count];i++)
    {
        //NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
        
        NSString *str_id=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i] objectForKey:@"STUDENT_ID"]];
        cmt=[[array_studentgrades objectAtIndex:i] objectForKey:@"COMMENT"];
        point=[[array_studentgrades  objectAtIndex:i] objectForKey:@"REPORT_CARD_GRADE"];
        //   NSString *str_id1=[NSString stringWithFormat:@"%@",[array_studentgrades objectAtIndex:i]];
        
        [dic3 setObject:point  forKey:@"grade"];
        [dic3 setObject:cmt  forKey:@"comment"];
        
        [dic2 setObject:dic3 forKey:str_id];
        //
        //[dic1 setObject:dic2 forKey:str_id];
        [arrData addObject:dic2];
    }
    
    //   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    NSString * str111;// = [Base64 encode:data];
    str111=[arrData JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
    
    
    
    
 //   NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
//     http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=[{"13":{"grade":"5","comment":"test"},"2":{"grade":"6","comment":"test 1"},"3":{"grade":"6","comment":"test 2"},"15":{"grade":"6","comment":"test 3"},"7":{"grade":"6","comment":"test 4"}}]
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/post_final_grades.php"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    //
    //    NSLog(@"----%@",url12);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
   // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cpv_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[cpv_id1 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[mp_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"values\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str111 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"======%@",returnData);
    //   NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary  *datadic=[[NSMutableDictionary alloc]init];
    datadic = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:NULL];
    NSLog(@"datadic-------%@",datadic);
    
    NSString *succ=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"success"]];
    if ([succ isEqualToString:@"1"]) {
        
        [self loaddata];
        
    }
    
    else
    {
        
        //NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        // [self alertmsg:msg];
        
        //UIAlertView
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (void)savedataonAssignments
{
     NSString *cmt,*point;
    NSMutableArray *arrData=[[NSMutableArray alloc]init];
    
    for(int i=0;i<[array_studentgrades count];i++)
    {
       // NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
        
        NSString *str_id=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i] objectForKey:@"STUDENT_ID"]];
        cmt=[[array_studentgrades objectAtIndex:i] objectForKey:@"COMMENT"];
        point=[[array_studentgrades  objectAtIndex:i] objectForKey:@"GRADE_PERCENT"];
        //   NSString *str_id1=[NSString stringWithFormat:@"%@",[array_studentgrades objectAtIndex:i]];
        
        [dic3 setObject:point  forKey:@"percent"];
        [dic3 setObject:cmt  forKey:@"comment"];
        
        [dic2 setObject:dic3 forKey:str_id];
        //
        //[dic1 setObject:dic2 forKey:str_id];
        [arrData addObject:dic2];
    }
    
    //   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    NSString * str111;// = [Base64 encode:data];
    str111=[arrData JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
  //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=[{"13":{"percent":"65%","comment":"test"},"2":{"percent":"35%","comment":"test%201"},"3":{"percent":"45%","comment":"test%202"},"15":{"percent":"15%","comment":"test%203"},"7":{"percent":"55%","comment":"test%204"}}]
    
    
    
    // NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/post_final_grades.php"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    //
    //    NSLog(@"----%@",url12);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
    // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cpv_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[cpv_id1 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[mp_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
   
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"values\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str111 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"======%@",returnData);
    //   NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary  *datadic=[[NSMutableDictionary alloc]init];
    datadic = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:NULL];
    NSLog(@"datadic-------%@",datadic);
    
    NSString *succ=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"success"]];
    if ([succ isEqualToString:@"1"]) {
        
        [self loaddata];
        
    }
    
    else
    {
        
     //   NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        // [self alertmsg:msg];
        
        //UIAlertView
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

#pragma mark -data getters

- (void)getDataOnReset
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    
    NSString *str111 = @"clearall";
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/post_final_grades.php"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    //
    //    NSLog(@"----%@",url12);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
    // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cpv_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[cpv_id1 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[mp_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"action_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str111 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"======%@",returnData);
    //   NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary  *dictionary1=[[NSMutableDictionary alloc]init];
    dictionary1 = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:NULL];
    NSLog(@"datadic-------%@",dictionary1);
    
    NSString *succ=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
    if ([succ isEqualToString:@"1"]) {
        
       // [self loaddata];
        array_reportcardgrades = [[[NSMutableArray alloc]init]mutableCopy];
        array_studentgrades = [[[NSMutableArray alloc]init]mutableCopy];
        
        array_studentgrades = [dictionary1 objectForKey:@"student_grades"];
        array_reportcardgrades = [dictionary1 objectForKey:@"report_card_grades"];
        
        //        arr = [[NSMutableArray alloc]init];
        ////        arr = [array_reportcardgrades valueForKey:@"ID"];
        //        for (int i = 0; i < array_reportcardgrades.count; ++i) {
        //            NSString *str = [NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:i] objectForKey:@"TITLE"]];
        //            if ([str isEqualToString:@""]) {
        //                ;
        //            }
        //            else
        //            {
        //                [arr addObject:[array_reportcardgrades objectAtIndex:i]];
        //            }
        //
        //        }
        //  NSLog(@"printing arrrr : %@",arr);
//        dicto = [[NSMutableDictionary alloc]init];
//        
//        for (int i = 0 ; i < array_reportcardgrades.count; ++i) {
//            
//            [dicto setObject:[NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:i] objectForKey:@"TITLE"]] forKey:[NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:i] objectForKey:@"ID"]]];
//            
//        }
//        //[arr addObject:dicto];
        
        
        
        [self.tablev reloadData];
        [pick12 reloadAllComponents];

        
    }
    
    else
    {
        
        //   NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        // [self alertmsg:msg];
        
        //UIAlertView
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}


- (void)getdataOnFetch
{
    
    
     //http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&fetch_type=gradebook&use_percents=true
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&fetch_type=grades&prev_mp=15
    
     //http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&fetch_type=comments&prev_mp=15
    
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *prev_mpid;
    NSString *nullornot = [NSString stringWithFormat:@"%@",dicto];
    //NSNull *null;
    if ( ![nullornot isEqualToString:@"<null>"] )   {
        prev_mpid = [NSString stringWithFormat:@"%@",[dicto objectForKey:@"MARKING_PERIOD_ID"]];
    }
    else
    {
        prev_mpid = @"null";
    }
    
    
    NSString *str_checklogin;
    
    if (fetchtag == 10) {
        str_checklogin =[NSString stringWithFormat:@"/post_final_grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&fetch_type=gradebook&use_percents=true",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id];
    }
    else if (fetchtag == 20) {
        
        str_checklogin =[NSString stringWithFormat:@"/post_final_grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&fetch_type=grades&prev_mp=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,prev_mpid];
    }
    else if (fetchtag == 30) {
        
        str_checklogin =[NSString stringWithFormat:@"/post_final_grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&fetch_type=comments&prev_mp=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,prev_mpid];
    }
    else
    {
        str_checklogin=[NSString stringWithFormat:@"/post_final_grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&include_inactive=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s];
    }
    
    
    
    
    
    
    
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
        array_reportcardgrades = [[[NSMutableArray alloc]init]mutableCopy];
        array_studentgrades = [[[NSMutableArray alloc]init]mutableCopy];
        
        array_studentgrades = [dictionary1 objectForKey:@"student_grades"];
        array_reportcardgrades = [dictionary1 objectForKey:@"report_card_grades"];
//        dicto = [[NSMutableDictionary alloc]init];
//        dicto = [dictionary1 objectForKey:@"previous_mp_data"];
        //        arr = [[NSMutableArray alloc]init];
        ////        arr = [array_reportcardgrades valueForKey:@"ID"];
        //        for (int i = 0; i < array_reportcardgrades.count; ++i) {
        //            NSString *str = [NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:i] objectForKey:@"TITLE"]];
        //            if ([str isEqualToString:@""]) {
        //                ;
        //            }
        //            else
        //            {
        //                [arr addObject:[array_reportcardgrades objectAtIndex:i]];
        //            }
        //
        //        }
        //  NSLog(@"printing arrrr : %@",arr);
        //       dicto = [[NSMutableDictionary alloc]init];
        //
        //        for (int i = 0 ; i < array_reportcardgrades.count; ++i) {
        //
        //            [dicto setObject:[NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:i] objectForKey:@"TITLE"]] forKey:[NSString stringWithFormat:@"%@",[[array_reportcardgrades objectAtIndex:i] objectForKey:@"ID"]]];
        //
        //        }
        //        //[arr addObject:dicto];
        
        
        
        [self.tablev reloadData];
        [pick12 reloadAllComponents];
        // student_grades
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - textview delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
@end
