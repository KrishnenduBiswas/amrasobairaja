
//
//  GradebookConfigController.m
//  openSiS
//
//  Created by os4ed on 11/5/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "GradebookConfigController.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "finalgradecell.h"
#import "TeacherDashboardViewController.h"
#import "AppDelegate.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

#define X_ORIGIN_4 11
#define X_ORIGIN_4_7 13
#define X_ORIGIN_5_5 14
#define Y_ORIGIN_MAIN 5


@interface GradebookConfigController ()<UITextFieldDelegate>
{
    
    
    NSDictionary *dic_custom;
    NSString *savestr;
    NSMutableArray *cus_title,*cus_value;
    
    IBOutlet UIButton *btn_cus;
    int flag;
}

@property (strong, nonatomic) IBOutlet UIView *contain_general;
@property (strong, nonatomic) IBOutlet UIView *contain_final;
@property (strong, nonatomic) IBOutlet UIView *view_buttonunderline;
@property (strong, nonatomic) IBOutlet UIButton *btn_general;


@property (strong, nonatomic) IBOutlet UIView *contain_custom;


- (IBAction)action_Final:(id)sender;
- (IBAction)action_General:(id)sender;
- (IBAction)action_Save:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_final;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll_final;

@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UILabel *label_header;

@property (strong, nonatomic) IBOutlet UIView *view_bluehead;

////////////general


@property (strong, nonatomic) IBOutlet UIView *view_assignmentSorting;
@property (strong, nonatomic) IBOutlet UIView *view_maxpercent;
@property (strong, nonatomic) IBOutlet UIView *view_daysunit;
@property (strong, nonatomic) IBOutlet UIView *view_commentcode;
@property (strong, nonatomic) IBOutlet UITextField *text_assignmentSorting;
@property (strong, nonatomic) IBOutlet UITextField *text_maxpercent;
@property (strong, nonatomic) IBOutlet UITextField *text_daysunit;
@property (strong, nonatomic) IBOutlet UITextField *text_commentcode;
- (IBAction)action_switch:(id)sender;
- (IBAction)action_custmsave:(id)sender;
- (IBAction)action_saveNnext:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *switch_weight;
@property (strong, nonatomic) IBOutlet UISwitch *switch_assigndate;
@property (strong, nonatomic) IBOutlet UISwitch *switch_duedate;
@property (strong, nonatomic) IBOutlet UISwitch *switch_eligiblecumulative;
@property (strong, nonatomic) IBOutlet UIScrollView *view_scroll;



@end

@implementation GradebookConfigController
{
    NSMutableArray *array_finalgradepercent, *array_gradesRounding, *array_assignmentSorting, *ary_sectiontitle ,*cus_ary , *cus_ary1 ;
    NSMutableDictionary *dict_general,*dict_new_general,*dic_new_generalcustom;
    int currentwidth, currentheight;
    NSArray *arraytable, *array_picker_comment;
    
    NSMutableArray *array_sender,*array_key  , *array_send ,*array_vsend,*ary_send2;
    
    int yOrigin_all, xorigin_label, xorigin_text;
    
    UITextField *cell_text;
    UIPickerView *commentpicker;
    
    NSString * strfinal;
    NSString *str_name;
    NSString * sttttr;
    NSMutableDictionary* cusdic;
    NSMutableArray * key_ary;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        array_assignmentSorting = [[NSMutableArray alloc]init];
        array_gradesRounding = [[NSMutableArray alloc]init];
        array_finalgradepercent = [[NSMutableArray alloc]init];
        dict_general = [[NSMutableDictionary alloc]init];
        
        cus_ary= [[NSMutableArray alloc]init];
        cus_ary1 = [[NSMutableArray alloc]init];
        //        array_sender = [[NSMutableArray alloc]init];
        //        array_key = [[NSMutableArray alloc]init];
        
        
        //        [self callgetdata];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // cell_text.keyboardType=UIKeyboardTypeNumberPad;
    ary_sem_value=[[NSMutableArray alloc]init];
    [self callgetdata];
    [self picker_assignmentsorting];
    [self picker_comment];
    array_sender = [[NSMutableArray alloc]init];
    array_key = [[NSMutableArray alloc]init];
    
    array_send = [[NSMutableArray alloc]init];
    ary_send2 = [[NSMutableArray alloc]init];
    array_vsend = [[NSMutableArray alloc]init];
    key_ary = [[NSMutableArray alloc]init];
    
    dict_new_general = [[NSMutableDictionary alloc]init];
    array_picker_comment = [[NSArray alloc]initWithObjects:@"N/A",@"+",@".",@"-", nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

    
    CGRect containfinal_rect = self.contain_final.frame;
    containfinal_rect.origin.x = self.view.frame.size.width;
    [self.contain_final setFrame:containfinal_rect];
    currentwidth = self.view.frame.size.width;
    currentheight = 5;
    NSLog(@"-------------VIEW DID LOAD experiment : %@",array_assignmentSorting);
    
    CGRect containfinal_rect1 = self.contain_custom.frame;
    containfinal_rect1.origin.x = self.view.frame.size.width;
    [self.contain_custom setFrame:containfinal_rect1];
    currentwidth = self.view.frame.size.width;
    currentheight = 5;
    
    
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_Final:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    left.numberOfTouchesRequired = 1;
    [self.contain_general addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(custom:)];
    right1.direction = UISwipeGestureRecognizerDirectionLeft;
    right1.numberOfTouchesRequired = 1;
    [self.contain_custom addGestureRecognizer:right1];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(action_General:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    right.numberOfTouchesRequired = 1;
    [self.contain_final addGestureRecognizer:right];
    //[self numpadtool];
    
    
    
    flag=0;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self design:self.view_assignmentSorting];
    [self design:self.view_maxpercent];
    [self design:self.view_daysunit];
    [self design:self.view_commentcode];
    
    yOrigin_all = Y_ORIGIN_MAIN;
    
    if (self.view.frame.size.height == 568) {
        xorigin_label = X_ORIGIN_4;
        xorigin_text = 250;
    }
    else if (self.view.frame.size.height == 667)
    {
        xorigin_label = X_ORIGIN_4_7;
        xorigin_text = 293;
    }
    else if (self.view.frame.size.height == 736)
    {
        xorigin_label = X_ORIGIN_5_5;
        xorigin_text = 323;
    }
    
    NSLog(@"...%@",array_send);
    
}

#pragma mark - designs

-(void)design:(UIView*)obj
{
    
    obj.layer.borderWidth =  1.0f;
    obj.backgroundColor = [UIColor whiteColor];
    obj.layer.borderColor = [[UIColor lightGrayColor]CGColor];//[[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [obj.layer setCornerRadius:3.5f];
    obj.clipsToBounds = YES;
    
    
}





- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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



#pragma mark - Data Handlers

-(void)callgetdata
{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    // NSString *year=[NSString stringWithFormat:@"%@",[
    
    [self getdataonloadwithStaffid:STAFF_ID_K schoolID:school_id year:year_id];
}


-(void)getdataonloadwithStaffid:(NSString*)staffID  schoolID:(NSString*)schoolID year:(NSString *)year
{
    
    ip_url *ipurl = [[ip_url alloc]init];
    NSString *baseurl = [ipurl ipurl];
    
    NSString *thisurl = [NSString stringWithFormat:@"%@/grade_configuration.php?type=view&staff_id=%@&school_id=%@&syear=%@",baseurl,staffID,schoolID,year];
    NSLog(@"value in THISURL in Model GRadeBook General-------%@",thisurl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:thisurl]];
    
    
    //NSURLRequest *request = nil;
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (!data) {
        NSLog(@"%s: sendSynchronousRequest error: %@", __FUNCTION__, error);
        return;
    } else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode != 200) {
            NSLog(@"%s: sendSynchronousRequest status code != 200: response = %@", __FUNCTION__, response);
            return;
        }
    }
    
    NSError *parseError = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    if (!dictionary) {
        NSLog(@"%s: JSONObjectWithData error: %@; data = %@", __FUNCTION__, parseError, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        return;
    }
    [self setdata:dictionary];
    
    NSString *str_custom_grade_succ=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"custom_grade_success"]];
    if ([str_custom_grade_succ isEqualToString:@"1"]) {
        
        [self setdata:dictionary];
        
        //cus_ary=[dictionary objectForKey:@"custom_grade_data"];
        
        
        //  ary_sectiontitle = [[NSMutableArray alloc]init];
        //        for (int i = 0; i < cus_ary.count; ++i) {
        //            [cus_ary1 addObject:[[cus_ary objectAtIndex:i] objectForKey:@"CUSTOM_VALUE"]];
        //
        //
        //        }
        
        NSLog(@"-------------set data experiment : %@",array_assignmentSorting);
        
        cus_title=[[NSMutableArray alloc]init];
        cus_value=[[NSMutableArray alloc]init];
        //        NSMutableDictionary *dic15=[[NSMutableDictionary alloc]init];
        //        for (int i = 0; i<[cus_ary count]; i++) {
        //            dic15 = [cus_ary objectAtIndex:i];
        //            [cus_title  addObject:[dic15 objectForKey:@"title"]];
        //            [cus_value addObject:[dic15 objectForKey:@"value"]];
        
        
        // }
        
        //        btn_cus.hidden=NO;
        //        //self.btn_final.hidden=YES;
        //        btn_cus= [UIButton buttonWithType:UIButtonTypeCustom];
        //        [ btn_cus addTarget:self
        //                     action:@selector(custom:)
        //           forControlEvents:UIControlEventTouchUpInside];
        //        //[ btn_cus setTitle:@"Show View" forState:UIControlStateNormal];
        //        //btn_cus.frame = CGRectMake(75, 43, 100, 20.0);
        //        [self.view_bluehead addSubview:btn_cus];
        
    }
    
    else
    {
        btn_cus.hidden=YES;
        
        self.btn_final.hidden=YES;
        self.btn_final= [UIButton buttonWithType:UIButtonTypeCustom];
        [  self.btn_final addTarget:self
                             action:@selector(action_Final:)
                   forControlEvents:UIControlEventTouchUpInside];
        [ self.btn_final setTitle:@"FINAL GRADE PERCENTAGES" forState:UIControlStateNormal];
        
        self.btn_final.font = [UIFont fontWithName:@"OpenSans-bold" size:10.0f];
        [self.btn_final setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        self.btn_final.frame = CGRectMake(100, 39, 152, 25.0);
        [self.view_bluehead addSubview:self.btn_final];
        
    }
    
}

-(void)setdata:(NSDictionary*)dictionary1
{
    dict_general = [dictionary1 objectForKey:@"general"];
    array_assignmentSorting = [dictionary1 objectForKey:@"assignment_sorting"];
    array_gradesRounding = [dictionary1 objectForKey:@"grades_rounding"];
    array_finalgradepercent = [dictionary1 objectForKey:@"final_grade_percentage"];
    cus_ary=[dictionary1 objectForKey:@"custom_grade_data"];
    
    [self setGeneral:dict_general];
    ary_sectiontitle = [[NSMutableArray alloc]init];
    for (int i = 0; i < array_finalgradepercent.count; ++i) {
        [ary_sectiontitle addObject:[[array_finalgradepercent objectAtIndex:i] objectForKey:@"HEADER"]];
        
        
    }
    
    
    cus_ary=[dictionary1 objectForKey:@"custom_grade_data"];
    NSLog(@"cus_ary data...............%@",cus_ary);
    
    //NSMutableDictionary * dic_sem=[[NSMutableDictionary alloc]init];
    
    //            for (int i = 0; i <cus_ary.count; ++i) {
    //                [cus_ary1 addObject:[[cus_ary objectAtIndex:i] objectForKey:@"CUSTOM_VALUE"]];
    //                NSLog(@"cus_ary 1...............%@",cus_ary1);
    //
    //
    //            }
    
    NSLog(@"-------------set data experiment : %@",array_assignmentSorting);
    
    ary_assign_title=[[NSMutableArray alloc]init];
    ary_assign_value=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic15=[[NSMutableDictionary alloc]init];
    for (int i = 0; i<[array_assignmentSorting count]; i++) {
        dic15 = [array_assignmentSorting objectAtIndex:i];
        [ary_assign_title  addObject:[dic15 objectForKey:@"title"]];
        [ary_assign_value addObject:[dic15 objectForKey:@"value"]];
        
        
    }
    
    
    
    
}


-(void)savecustomdata:(NSArray *)customArray

{
    
    
    
    
    
    
    
}



-(void)saveGeneralwithGeneralData:(NSArray *)genArray
{
    
    
    /*
     
     http://107.170.94.176/openSIS_CE6_Mobile/webservice/grade_configuration.php?type=submit&staff_id=2&school_id=1&syear=2015&final_grade_percentage=[{"SEM-15":"50"},{"SEM-16":"30"},{"SEM-E18":"0"},{"SEM-17":"40"},{"SEM-18":"30"},{"SEM-E18":"0"},{"SEM-E18":"0"},{"FY-15":"10"},{"FY-16":"10"},{"FY-12":"10"},{"FY-E12":"10"},{"FY-17":"10"},{"FY-18":"10"},{"FY-13":"10"},{"FY-E13":"10"},{"FY-14":"10"},{"FY-E14":"10"}]&general=[{"COMMENT_A":"N\/A","DEFAULT_ASSIGNED":"","ANOMALOUS_MAX":"200","WEIGHT":"","LATENCY":"0","ELIGIBILITY_CUMULITIVE":"","ASSIGNMENT_SORTING":"ASSIGNMENT_ID","DEFAULT_DUE":""}]
     
     */
    
    
    //    NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    //
    //
    
    
    //    NSString *str_assgnID = [self.dict_main objectForKey:@"ASSIGNMENT_ID"];
    //    //assignment_id=2
    //    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    
    //
    //    NSMutableArray *arrData=[[NSMutableArray alloc]init];
    
    //    // [AFJSONResponseSerializer serializer];
    
    //    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    //
    
    [self setter];
    //[self setter1];
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array_sender];
    //    NSString *str_finalgradedata = [Base64 encode:data];
    
    
    //    [dict setValue:pick_id forKey:@"ASSIGNMENT_TYPE_ID"];
    //    [dict setValue:self.text_title.text forKey:@"TITLE"];
    //    [dict setValue:self.text_points.text forKey:@"POINTS"];
    //    [dict setValue:self.textview_description.text forKey:@"DESCRIPTION"];
    //    [dict setValue:assign_date forKey:@"ASSIGNED_DATE"];
    //    [dict setValue:due_date forKey:@"DUE_DATE"];
    //    [dict setValue:flag forKey:@"APPLY_TO_ALL"];
    
    
    //    NSLog(@"%@",dict);
    //    [arrData addObject:dict];
    //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    //    NSString * str111 = [Base64 encode:data];
    //    str111=[arrData JSONRepresentation];
    
    //    NSLog(@"----String To Post To Server ---%@",str111);
    
    NSLog(@"data sender e j data jachhe: gen_array : %@,custom_array :%@, fin_array : %@",genArray,array_send,array_sender);
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *str_finalgradedata = [array_sender JSONRepresentation];
    NSString *str_generaldata = [genArray JSONRepresentation];
    
    NSString *str_customdata = [array_send JSONRepresentation];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/grade_configuration.php?type=submit"];
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
    //  &staff_id=%@&school_id=%@&syear=%@&mp_id=%@&cpv_id=%@",STAFF_ID_K,school_id,year_id,mp_id,cpv_id1
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"final_grade_percentage\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_finalgradedata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"custom_grade_data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_customdata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    //-------------------------------------//
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"general\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_generaldata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // delivery_type=%@&delivery_date=%@&delivery_time=%@&description=%@&gofor_cut=%@&distance_amout=%@",uid,pa_amt,SCH_TYPE,date,time,DES,go_cut,d_amount];
    
    
    
    
    
    
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
        
        [self action_Final:nil];
        
    }
    
    //    else
    
    NSString *customsucc=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"custom_grade_success"]];
    if ([customsucc isEqualToString:@"1"])
    {
        [self custom:nil];
        
    }
    
    else
    {
        
        //        NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        //        [self alertmsg:msg];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    ///   UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    ClassWorkViewController *obj = [sb instantiateViewControllerWithIdentifier:@"classwork"];
    //
    //    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
    
    
    
    
    
}




//-(void)alertmsg:(NSString*)msg
//{
//
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//    [alert show];
//
//}


- (void) savefinal
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    NSString *str_finalgradedata = [array_sender JSONRepresentation];
    
    
    //NSString *str_customdata=[array_send JSONRepresentation];
    
    // NSString *str_customdata=savestr;
    
    NSMutableArray *array_yoyo = [NSMutableArray arrayWithObject:dict_new_general];
    NSString *str_generaldata = [array_yoyo JSONRepresentation];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/grade_configuration.php?type=submit"];
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
    //  &staff_id=%@&school_id=%@&syear=%@&mp_id=%@&cpv_id=%@",STAFF_ID_K,school_id,year_id,mp_id,cpv_id1
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"final_grade_percentage\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_finalgradedata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    //
    //    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"custom_grade_data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //    [body appendData:[str_customdata dataUsingEncoding:NSUTF8StringEncoding]];
    //    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //
    
    
    //-------------------------------------//
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"general\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_generaldata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // delivery_type=%@&delivery_date=%@&delivery_time=%@&description=%@&gofor_cut=%@&distance_amout=%@",uid,pa_amt,SCH_TYPE,date,time,DES,go_cut,d_amount];
    
    
    
    
    
    
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
        
        [self reloadManuallTable];
        NSLog(@"%@",array_send);
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"success" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    else
    {
        
        //        NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        //        [self alertmsg:msg];
        //
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    [self reloadManuallTable];
}



#pragma mark-picker



-(void)picker_comment

{
    commentpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    commentpicker  .delegate = self;
    
    commentpicker .dataSource = self;
    
    [ commentpicker  setShowsSelectionIndicator:YES];
    
    self.text_commentcode.inputView = commentpicker ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker1:)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_commentcode.inputAccessoryView = mypickerToolbar;
    
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







-(void)picker_assignmentsorting

{
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    
    self.text_assignmentSorting.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker1:)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_assignmentSorting.inputAccessoryView = mypickerToolbar;
    
}

-(IBAction)dismissPicker1:(id)sender
{
    
    [self.text_assignmentSorting resignFirstResponder];
    [self.text_commentcode resignFirstResponder];
    
}


#pragma mark - Picker View Delegate datasource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == selectcustomerpicker) {
        return [ary_assign_title objectAtIndex:row];
    }
    if (pickerView == commentpicker) {
        return [array_picker_comment objectAtIndex:row];
    }
    
    
    return nil;
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (pickerView == selectcustomerpicker) {
        return  ary_assign_title.count;
    }
    if (pickerView == commentpicker) {
        return array_picker_comment.count;
    }
    
    
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (pickerView == selectcustomerpicker) {
        self.text_assignmentSorting.text = [NSString stringWithFormat:@"%@",[ ary_assign_title objectAtIndex:row]];
        
        NSString *strC1 =(NSString *)[ary_assign_title objectAtIndex:row];
        assign_id = [ary_assign_value objectAtIndex:[ary_assign_title indexOfObjectIdenticalTo:strC1]];
    }
    
    if (pickerView == commentpicker) {
        self.text_commentcode.text = [NSString stringWithFormat:@"%@", [ array_picker_comment objectAtIndex:row]];
        NSLog(@"----gggg-----%@",self.text_commentcode.text);
    }
    
    
}

#pragma mark - Setters for General


-(void)setGeneral:(NSDictionary*)dict_main
{
    
    // NSLog( @"calling set general with dict: %@",dict_main);
    NSString *str_weight = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"WEIGHT"]];
    NSString *str_assignmentsorting = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"ASSIGNMENT_SORTING"]];
    NSString *str_anomalousmax = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"ANOMALOUS_MAX"]];
    NSString *str_comment = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"COMMENT_A"]];
    NSString *str_eligibilityCummulative = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"ELIGIBILITY_CUMULITIVE"]];
    NSString *str_defaultdue = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"DEFAULT_DUE"]];
    NSString *str_defaultassigned = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"DEFAULT_ASSIGNED"]];
    NSString *str_latency = [NSString stringWithFormat:@"%@",[dict_main objectForKey:@"LATENCY"]];
    
    
    
    if ([str_weight isEqualToString:@""]) {
        [_switch_weight setOn:NO animated:NO];
    }
    else
    {
        [_switch_weight setOn:YES animated:NO];
    }
    
    
    if ([str_defaultassigned isEqualToString:@""]) {
        [_switch_assigndate setOn:NO animated:NO];
    }
    else
    {
        [_switch_assigndate setOn:YES animated:NO];
    }
    
    if ([str_defaultdue isEqualToString:@""]) {
        [_switch_duedate setOn:NO animated:NO];
    }
    else
    {
        [_switch_duedate setOn:YES animated:NO];
    }
    
    
    if ([str_eligibilityCummulative isEqualToString:@""]) {
        [_switch_eligiblecumulative setOn:NO animated:NO];
    }
    else
    {
        [_switch_eligiblecumulative setOn:YES animated:NO];
    }
    ary_assign_title=[[NSMutableArray alloc]init];
    ary_assign_value=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic15=[[NSMutableDictionary alloc]init];
    for (int i = 0; i<[array_assignmentSorting count]; i++) {
        dic15 = [array_assignmentSorting objectAtIndex:i];
        [ary_assign_title  addObject:[dic15 objectForKey:@"title"]];
        [ary_assign_value addObject:[dic15 objectForKey:@"value"]];
        
        if ([str_assignmentsorting isEqual:[[array_assignmentSorting objectAtIndex:i]objectForKey:@"value"]]) {
            //  k=YES;
            //  break;
            
            self.text_assignmentSorting.text=[[array_assignmentSorting objectAtIndex:i]objectForKey:@"title"];
            assign_id=[NSString stringWithFormat:@"%@",[[array_assignmentSorting objectAtIndex:i]objectForKey:@"value"]];
            
        }
        
        else
        {
            
            //  k=NO;
            //  break;
        }
        
        
    }
    
    
    if (str_comment == nil) {
        self.text_commentcode.text = [NSString stringWithFormat:@"N/A"];
    }
    else if (str_comment == Nil)
    {
        self.text_commentcode.text = [NSString stringWithFormat:@"N/A"];
    }
    else if (str_comment == NULL)
    {
        self.text_commentcode.text = [NSString stringWithFormat:@"N/A"];
    }
    else if ([str_comment isEqualToString:@""])
    {
        self.text_commentcode.text = [NSString stringWithFormat:@"N/A"];
    }
    
    
    else
    {
        self.text_commentcode.text = str_comment;
    }
    
    //  _text_assignmentSorting.text = str_assignmentsorting;
    //    if (str_comment == NULL) {
    //     //  self.text_commentcode.text = [NSString stringWithFormat:@"N/A"];
    //    }
    //    else
    //    {
    //        self.text_commentcode.text = str_comment;
    //    }
    
    self.text_maxpercent.text = str_anomalousmax;
    self.text_daysunit.text = str_latency;
    
}


#pragma mark - setters


-(void)setter
{
    
    for (int i = 0 ; i < array_finalgradepercent.count; ++i) {
        NSMutableArray * ary_sem2 = [[NSMutableArray alloc]init];
        ary_sem2 = [[array_finalgradepercent objectAtIndex:i] objectForKey:@"SEM"];
        //NSLog(@"onloop i: %@",ary_sem2);
        for (int j = 0; j < ary_sem2.count; ++j) {
            
            NSString *str = [NSString stringWithFormat:@"%@",[[ary_sem2 objectAtIndex:j] objectForKey:@"value"]];
            NSString *str2 = [NSString stringWithFormat:@"%@",[[ary_sem2 objectAtIndex:j] objectForKey:@"name"]];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:str forKey:str2];
            [array_sender addObject:dic];
            [array_key addObject:[NSString stringWithFormat:@"%@",str2]];
            //[dict_temp setObject:str forKey:str2];
            //                NSLog(@" array of keys: %@", array_key);
            //NSLog(@"value of str2: %@",str2);
        }
    }
    // NSLog(@" array of keys: %@", array_key);
    
}

-(void)setter1
{
    
    for (int i = 0 ; i < cus_ary.count; ++i) {
        NSMutableArray * ary_sem2 = [[NSMutableArray alloc]init];
        ary_sem2 = [[cus_ary objectAtIndex:i] objectForKey:@"CUSTOM_VALUE"];
        //NSLog(@"onloop i: %@",ary_sem2);
        for (int j = 0; j < ary_sem2.count; ++j) {
            
            NSString *str = [NSString stringWithFormat:@"%@",[[ary_sem2 objectAtIndex:j] objectForKey:@"VALUE"]];
            NSString *str2 = [NSString stringWithFormat:@"%@",[[ary_sem2 objectAtIndex:j] objectForKey:@"NAME"]];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:str forKey:@"dibya"];  //str2
            [array_send addObject:dic];
            [array_vsend addObject:[NSString stringWithFormat:@"%@",str2]];
            
            savestr = [NSString stringWithFormat:@"%@",[[array_send objectAtIndex:j] objectForKey:@"dibya"]];
            
            //[dict_temp setObject:str forKey:str2];
            //                NSLog(@" array of keys: %@", array_key);
            //NSLog(@"value of str2: %@",str2);
        }
    }
    // NSLog(@" array of keys: %@", array_key);
    
}



#pragma mark - actions
- (IBAction)custom:(id)sender {
    //NSLog(@"ok1");
    
    [self callgetdata];
    [self setter1];
    [self  reloadManuallTablecus];
    // NSLog(@"ok2");
    if (self.contain_custom.frame.origin.x == currentwidth) {
        [UIView animateWithDuration:0.3f animations:^{
            
            self.contain_general.frame = CGRectMake(-currentwidth, self.contain_general.frame.origin.y,
                                                    self.contain_general.frame.size.width, self.contain_general.frame.size.height);
            self.contain_custom.frame = CGRectMake(0, self.contain_custom.frame.origin.y,
                                                   self.contain_custom.frame.size.width, self.contain_custom.frame.size.height);
            
            self.contain_final.frame = CGRectMake(currentwidth, self.contain_final.frame.origin.y,
                                                  self.contain_final.frame.size.width, self.contain_final.frame.size.height);
            self.view_buttonunderline.frame = CGRectMake(btn_cus.frame.origin.x, self.view_buttonunderline.frame.origin.y, btn_cus.frame.size.width, self.view_buttonunderline.frame.size.height);
        }completion:^(BOOL finished){
            [self.view bringSubviewToFront:self.contain_final];
        }];
        
        
        
        
        
        
    }
    [self.tablev reloadData];
    
    
}


- (IBAction)action_Final:(id)sender {
    //NSLog(@"ok1");
    [self setter];
    [self reloadManuallTable];
    // NSLog(@"ok2");
    if (self.contain_final.frame.origin.x == currentwidth) {
        [UIView animateWithDuration:0.3f animations:^{
            
            self.contain_general.frame = CGRectMake(-currentwidth, self.contain_general.frame.origin.y,
                                                    self.contain_general.frame.size.width, self.contain_general.frame.size.height);
            self.contain_custom.frame = CGRectMake(currentwidth, self.contain_custom.frame.origin.y,
                                                   self.contain_custom.frame.size.width, self.contain_custom.frame.size.height);
            self.contain_final.frame = CGRectMake(0, self.contain_final.frame.origin.y,
                                                  self.contain_final.frame.size.width, self.contain_final.frame.size.height);
            self.view_buttonunderline.frame = CGRectMake(self.btn_final.frame.origin.x, self.view_buttonunderline.frame.origin.y, self.btn_final.frame.size.width, self.view_buttonunderline.frame.size.height);
        }completion:^(BOOL finished){
            [self.view bringSubviewToFront:self.contain_final];
        }];
        
        
        
        
        
        
    }
    [self.tablev reloadData];
    
    
}

- (IBAction)action_General:(id)sender {
    [self callgetdata];
    [self setGeneral:dict_general];
    if (self.contain_general.frame.origin.x == -currentwidth) {
        [UIView animateWithDuration:0.3f animations:^{
            
            self.contain_general.frame = CGRectMake(0, self.contain_general.frame.origin.y,
                                                    self.contain_general.frame.size.width, self.contain_general.frame.size.height);
            self.contain_custom.frame = CGRectMake(currentwidth, self.contain_custom.frame.origin.y,
                                                   self.contain_custom.frame.size.width, self.contain_custom.frame.size.height);
            self.contain_final.frame = CGRectMake(-currentwidth, self.contain_final.frame.origin.y,
                                                  self.contain_final.frame.size.width, self.contain_final.frame.size.height);
            self.view_buttonunderline.frame = CGRectMake(self.btn_general.frame.origin.x, self.view_buttonunderline.frame.origin.y, self.btn_general.frame.size.width, self.view_buttonunderline.frame.size.height);
            
        }completion:^(BOOL finished){
            [self.view bringSubviewToFront:self.contain_general];
        }];
        
    }
    
    
    
    
}

- (IBAction)action_Save:(id)sender
{
    NSLog(@"Save clik korlam %@", array_sender);
    [self savefinal];
    [self.view_scroll setContentOffset:CGPointMake(0, 0)];
    
}

-(IBAction)action_switch:(id)sender
{
    
    
}

- (IBAction)action_custmsave:(id)sender
{
    
    NSLog(@"custom button ta click korlam %@",array_send);
    //    cusdic=[[NSMutableDictionary alloc]init];
    //    for (int i=0; i<array_send.count; i++) {
    //          cell_text.tag=i;
    //
    //
    //        [cusdic setObject:cell_text.text forKey:@"value"];
    //        [ary_send2 addObject:cell_text.text];
    //
    //    }
    //    NSLog(@"khepa array %@",ary_send2);
    
    
    [self savecustom];
    
    
    [self.view_scroll setContentOffset:CGPointMake(0, 0)];
    
    [self action_Final:nil];
    
    
    
    
    
    flag=1;
}









- (void) savecustom
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    NSString *str_finalgradedata = [array_sender JSONRepresentation];
    
    NSString *str_customdata=[array_send JSONRepresentation];
    
    NSMutableArray *array_yoyo = [NSMutableArray arrayWithObject:dict_new_general];
    NSString *str_generaldata = [array_yoyo JSONRepresentation];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/grade_configuration.php?type=submit"];
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
    //  &staff_id=%@&school_id=%@&syear=%@&mp_id=%@&cpv_id=%@",STAFF_ID_K,school_id,year_id,mp_id,cpv_id1
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"custom_grade_data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_customdata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"final_grade_percentage\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_finalgradedata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    //-------------------------------------//
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"general\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str_generaldata dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // delivery_type=%@&delivery_date=%@&delivery_time=%@&description=%@&gofor_cut=%@&distance_amout=%@",uid,pa_amt,SCH_TYPE,date,time,DES,go_cut,d_amount];
    
    
    
    
    
    
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
    
    NSString *succ=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"custom_grade_success"]];
    if ([succ isEqualToString:@"1"]) {
        
        [self reloadManuallTablecus];
        [self action_Final:nil];
        
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"success" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //        [alert show];
        //        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    else
    {
        
        //        NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        //        [self alertmsg:msg];
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    [self reloadManuallTablecus];
}





- (IBAction)action_saveNnext:(id)sender
{
    
    
    //NSLog(@"----f---------%@",self.text_commentcode.text);
    NSString *str_cmntcode = [NSString stringWithFormat:@"%@",self.text_commentcode.text];
    //  NSLog(@"str_cmntcode: %@", str_cmntcode);
    NSString *str_maxp = [NSString stringWithFormat:@"%@",_text_maxpercent.text];
    NSString *str_dayu = [NSString stringWithFormat:@"%@",_text_daysunit.text];
    NSString *str_assortid = [NSString stringWithFormat:@"%@",assign_id];
    NSString *str_sw_assD = [[NSString alloc]init];
    NSString *str_sw_dueD = [[NSString alloc]init];
    NSString *str_sw_eli_cu = [[NSString alloc]init];
    NSString *str_sw_wei = [[NSString alloc]init];
    if ([_switch_assigndate isOn]) {
        str_sw_assD = @"Y";
    }
    else
    {
        str_sw_assD = @"";
    }
    
    if ([_switch_duedate isOn]) {
        str_sw_dueD = @"Y";
    }
    else
    {
        str_sw_dueD = @"";
    }
    
    if ([_switch_eligiblecumulative isOn]) {
        str_sw_eli_cu = @"Y";
    }
    else
    {
        str_sw_eli_cu = @"";
    }
    
    if ([_switch_weight isOn]) {
        str_sw_wei = @"Y";
    }
    else
    {
        str_sw_wei = @"";
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:str_cmntcode forKey:@"COMMENT_A"];
    [dict setObject:str_sw_assD forKey:@"DEFAULT_ASSIGNED"];
    [dict setObject:str_maxp forKey:@"ANOMALOUS_MAX"];
    [dict setObject:str_sw_wei forKey:@"WEIGHT"];
    [dict setObject:str_dayu forKey:@"LATENCY"];
    [dict setObject:str_sw_eli_cu forKey:@"ELIGIBILITY_CUMULITIVE"];
    [dict setObject:str_assortid forKey:@"ASSIGNMENT_SORTING"];
    [dict setObject:str_sw_dueD forKey:@"DEFAULT_DUE"];
    
    NSMutableArray *genarray = [NSMutableArray arrayWithObject:dict];
    dict_new_general = dict;
    // NSLog(@"click e data ta: %@", genarray);
    
    [self saveGeneralwithGeneralData:genarray];
    if (btn_cus.hidden==NO) {
        
        [self custom:nil];
    }
    else
    {
        [self action_Final:nil];
    }
    
    
}




#pragma mark - Creating the table manually

-(void)reloadManuallTable
{
    [self callgetdata];
    CGRect rect_scroll = self.view_scroll.frame;
    [self.view_scroll removeFromSuperview];
    self.view_scroll = [[UIScrollView alloc]initWithFrame:rect_scroll];
    [self createTable];
    [self.contain_final addSubview:self.view_scroll];
    [self.view_scroll setContentOffset:CGPointMake(0, 0)];
}
-(void)reloadManuallTablecus
{
    [self callgetdata];
    CGRect rect_scroll = self.view_scroll.frame;
    [self.view_scroll removeFromSuperview];
    self.view_scroll = [[UIScrollView alloc]initWithFrame:rect_scroll];
    [self createTable1];
    [self.contain_custom addSubview:self.view_scroll];
    [self.view_scroll setContentOffset:CGPointMake(0, 0)];
}

- (void) createTable
{
    //NSLog(@"ok create table");
    int table_text_tag = 0;
    
    for (int i = 0 ; i < array_finalgradepercent.count; ++i) {
        
        // NSLog(@"ok on loop 1 with i: %i",i);
        //[ary_sem removeAllObjects];
        ary_sem = [[NSMutableArray alloc]init];
        ary_sem = [[array_finalgradepercent objectAtIndex:i] objectForKey:@"SEM"];
        
        NSLog(@"...........%@",ary_sem);
        
        
        
        
        UILabel* label_header = [[UILabel alloc]initWithFrame:CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
        //label_header.tag = i;
        label_header.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12.0f];
        label_header.text = [[array_finalgradepercent objectAtIndex:i] objectForKey:@"HEADER"];
        //[header_view addSubview:self.label_header];
        [self.view_scroll addSubview:label_header];
        yOrigin_all += label_header.frame.size.height;
        
        
        
        for (int j = 0; j < ary_sem.count; ++j) {
            // NSLog(@"ok on loop 2 with j: %i",j);
            yOrigin_all += 5;
            UILabel *cell_label = [[UILabel alloc]initWithFrame: CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
            cell_label.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
            cell_label.text = [[ary_sem objectAtIndex:j] objectForKey:@"title"];
            [self.view_scroll addSubview:cell_label];
            
            UIView *cell_view_text = [[UIView alloc]initWithFrame: CGRectMake(xorigin_text, yOrigin_all, 60, 27)];
            cell_view_text.backgroundColor = [UIColor whiteColor];
            [cell_view_text.layer setCornerRadius:2.0f];
            [cell_view_text.layer setBorderWidth:1.0f];
            [cell_view_text.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
            
            cell_text = [[UITextField alloc]initWithFrame:CGRectMake(3, 0, cell_view_text.frame.size.width - 3, cell_view_text.frame.size.height)];
            [cell_text setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            cell_text.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
            cell_text.tag = table_text_tag;
            cell_text.delegate = self;
            cell_text.tintColor = [UIColor blueColor];
            
            
            
            // cell_text.text = [[ary_sem objectAtIndex:j] objectForKey:@"value"];
            
            cell_text.text =  [self nullChecker:[NSString stringWithFormat:@"%@",[[ary_sem objectAtIndex:j] objectForKey:@"value"]]];
            
            
            [cell_text addTarget:self action:@selector(click1:) forControlEvents:UIControlEventEditingDidEnd];
            [cell_text addTarget:self action:@selector(click1:) forControlEvents:UIControlEventEditingChanged];
            [cell_text addTarget:self action:@selector(goup:) forControlEvents:UIControlEventEditingDidBegin];
            [cell_text addTarget:self action:@selector(godown:) forControlEvents:UIControlEventEditingDidEnd];
            [cell_view_text addSubview:cell_text];
            [self.view_scroll addSubview:cell_view_text];
            
            
            table_text_tag++;
            yOrigin_all += cell_label.frame.size.height;
            
        }
        
        
        int sum = 0;
        
        for (int k = 0; k < ary_sem.count; ++k) {
            NSString *sumstr = [NSString stringWithFormat:@"%@",[[ary_sem objectAtIndex:k] objectForKey:@"value"]];
            int temp = (int)[sumstr integerValue];
            sum += temp;
            
        }
        
        if (sum != 100) {
            yOrigin_all +=5;
            UILabel *lbl_notify = [[UILabel alloc]initWithFrame:CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
            lbl_notify.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
            lbl_notify.textColor = [UIColor redColor];
            lbl_notify.text = @"Total not 100%!";
            [self.view_scroll addSubview:lbl_notify];
            yOrigin_all += lbl_notify.frame.size.height;
        }
        
        yOrigin_all += 5;
        UIView *view_separator = [[UIView alloc]initWithFrame:CGRectMake(0, yOrigin_all, self.view.frame.size.width, 1)];
        view_separator.backgroundColor = [UIColor lightGrayColor];
        [self.view_scroll addSubview:view_separator];
        
        yOrigin_all += view_separator.frame.size.height;
        
        yOrigin_all += 8;
    }
    
    NSArray *viewArray =  [[NSBundle mainBundle] loadNibNamed:@"FinalFooter" owner:self options:nil];
    UIView *view1 = [viewArray objectAtIndex:0];
    CGRect rect = view1.frame;
    rect.origin.y = yOrigin_all;
    [view1 setFrame:rect];
    [self.view_scroll addSubview:view1];
    yOrigin_all += view1.frame.size.height;
    
    [self.view_scroll setContentSize:CGSizeMake(self.view.frame.size.width, yOrigin_all)];
    
    yOrigin_all = Y_ORIGIN_MAIN;
    
}

- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}


- (void) createTable1
{
    
    
    if (flag==0) {
        
        //NSLog(@"ok create table");
        int table_text_tag = 0;
        
        for (int i = 0 ; i < cus_ary.count; ++i) {
            
            // NSLog(@"ok on loop 1 with i: %i",i);
            //[ary_sem removeAllObjects];
            
            //cus_ary1=cus_ary;
            ary_semmmmm = [[NSMutableArray alloc]init];
            ary_semmmmm = [[cus_ary objectAtIndex:i] objectForKey:@"CUSTOM_VALUE"];
            
            NSLog(@"//////// %@",ary_semmmmm);
            
            UILabel* label_header = [[UILabel alloc]initWithFrame:CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
            //label_header.tag = i;
            label_header.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12.0f];
            label_header.text = [[cus_ary objectAtIndex:i] objectForKey:@"COURSE_TITLE"];
            //[header_view addSubview:self.label_header];
            [self.view_scroll addSubview:label_header];
            yOrigin_all += label_header.frame.size.height;
            
            
            
            for (int j = 0; j < ary_semmmmm.count; ++j) {
                NSLog(@"ok on loop 2 with j: %i",j);
                yOrigin_all += 5;
                UILabel *cell_label = [[UILabel alloc]initWithFrame: CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
                cell_label.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
                cell_label.text = [[ary_semmmmm objectAtIndex:j] objectForKey:@"TITLE"];
                [self.view_scroll addSubview:cell_label];
                
                UIView *cell_view_text = [[UIView alloc]initWithFrame: CGRectMake(xorigin_text, yOrigin_all, 60, 27)];
                cell_view_text.backgroundColor = [UIColor whiteColor];
                [cell_view_text.layer setCornerRadius:2.0f];
                [cell_view_text.layer setBorderWidth:1.0f];
                [cell_view_text.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                
                cell_text = [[UITextField alloc]initWithFrame:CGRectMake(3, 0, cell_view_text.frame.size.width - 3, cell_view_text.frame.size.height)];
                [cell_text setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                cell_text.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
                cell_text.tag = table_text_tag;
                cell_text.delegate = self;
                cell_text.tintColor = [UIColor blueColor];
                
                
                cell_text.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[ary_semmmmm objectAtIndex:j] objectForKey:@"VALUE"]]];
                
                
                
                [cell_text addTarget:self action:@selector(click_cus:) forControlEvents:UIControlEventEditingDidEnd];
                [cell_text addTarget:self action:@selector(click_cus:) forControlEvents:UIControlEventEditingChanged];
                [cell_text addTarget:self action:@selector(goup:) forControlEvents:UIControlEventEditingDidBegin];
                [cell_text addTarget:self action:@selector(godown:) forControlEvents:UIControlEventEditingDidEnd];
                [cell_view_text addSubview:cell_text];
                [self.view_scroll addSubview:cell_view_text];
                
                
                table_text_tag++;
                yOrigin_all += cell_label.frame.size.height;
                
            }
            
            
            int sum = 0;
            
            for (int k = 0; k < ary_sem.count; ++k) {
                NSString *sumstr = [NSString stringWithFormat:@"%@",[[ary_sem objectAtIndex:k] objectForKey:@"value"]];
                int temp = (int)[sumstr integerValue];
                sum += temp;
                
            }
            
            //        if (sum != 100) {
            //            yOrigin_all +=5;
            //            UILabel *lbl_notify = [[UILabel alloc]initWithFrame:CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
            //            lbl_notify.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
            //            lbl_notify.textColor = [UIColor redColor];
            //            lbl_notify.text = @"Total not 100%!";
            //            [self.view_scroll addSubview:lbl_notify];
            //            yOrigin_all += lbl_notify.frame.size.height;
            //        }
            
            yOrigin_all += 5;
            UIView *view_separator = [[UIView alloc]initWithFrame:CGRectMake(0, yOrigin_all, self.view.frame.size.width, 1)];
            view_separator.backgroundColor = [UIColor lightGrayColor];
            [self.view_scroll addSubview:view_separator];
            
            yOrigin_all += view_separator.frame.size.height;
            
            yOrigin_all += 8;
        }
        
        NSArray *viewArray =  [[NSBundle mainBundle] loadNibNamed:@"FinalFooter2" owner:self options:nil];
        UIView *view1 = [viewArray objectAtIndex:0];
        CGRect rect = view1.frame;
        rect.origin.y = yOrigin_all;
        [view1 setFrame:rect];
        [self.view_scroll addSubview:view1];
        yOrigin_all += view1.frame.size.height;
        
        [self.view_scroll setContentSize:CGSizeMake(self.view.frame.size.width, yOrigin_all)];
        
        yOrigin_all = Y_ORIGIN_MAIN;
    }
    else
    {
        NSLog(@"ok else part");
        int table_text_tag = 0;
        
        for (int i = 0 ; i < cus_ary.count; ++i) {
            
            // NSLog(@"ok on loop 1 with i: %i",i);
            //[ary_sem removeAllObjects];
            
            //cus_ary1=cus_ary;
            ary_semmmmm = [[NSMutableArray alloc]init];
            ary_semmmmm = [[cus_ary objectAtIndex:i] objectForKey:@"CUSTOM_VALUE"];
            
            NSLog(@"//////// %@",ary_semmmmm);
            
            UILabel* label_header = [[UILabel alloc]initWithFrame:CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
            //label_header.tag = i;
            label_header.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12.0f];
            label_header.text = [[cus_ary objectAtIndex:i] objectForKey:@"COURSE_TITLE"];
            //[header_view addSubview:self.label_header];
            [self.view_scroll addSubview:label_header];
            yOrigin_all += label_header.frame.size.height;
            
            
            
            for (int j = 0; j < ary_semmmmm.count; ++j) {
                NSLog(@"ok on loop 2 with j: %i",j);
                yOrigin_all += 5;
                UILabel *cell_label = [[UILabel alloc]initWithFrame: CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
                cell_label.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
                cell_label.text = [[ary_semmmmm objectAtIndex:j] objectForKey:@"TITLE"];
                [self.view_scroll addSubview:cell_label];
                
                UIView *cell_view_text = [[UIView alloc]initWithFrame: CGRectMake(xorigin_text, yOrigin_all, 60, 27)];
                cell_view_text.backgroundColor = [UIColor whiteColor];
                [cell_view_text.layer setCornerRadius:2.0f];
                [cell_view_text.layer setBorderWidth:1.0f];
                [cell_view_text.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                
                cell_text = [[UITextField alloc]initWithFrame:CGRectMake(3, 0, cell_view_text.frame.size.width - 3, cell_view_text.frame.size.height)];
                [cell_text setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
                cell_text.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
                cell_text.tag = table_text_tag;
                cell_text.delegate = self;
                cell_text.tintColor = [UIColor blueColor];
                
                cell_text.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[array_send objectAtIndex:j]objectForKey:@"dibya"]]];
                //cell_text.text=[self nullChecker:[NSString stringWithFormat:@"%@",[ary_send2 objectAtIndex:j]]];
                
                NSLog(@"%@",array_send);
                [cell_text addTarget:self action:@selector(click_cus:) forControlEvents:UIControlEventEditingDidEnd];
                [cell_text addTarget:self action:@selector(click_cus:) forControlEvents:UIControlEventEditingChanged];
                [cell_text addTarget:self action:@selector(goup:) forControlEvents:UIControlEventEditingDidBegin];
                [cell_text addTarget:self action:@selector(godown:) forControlEvents:UIControlEventEditingDidEnd];
                [cell_view_text addSubview:cell_text];
                [self.view_scroll addSubview:cell_view_text];
                
                
                table_text_tag++;
                yOrigin_all += cell_label.frame.size.height;
                
            }
            
            
            int sum = 0;
            
            for (int k = 0; k < ary_sem.count; ++k) {
                NSString *sumstr = [NSString stringWithFormat:@"%@",[[ary_sem objectAtIndex:k] objectForKey:@"value"]];
                int temp = (int)[sumstr integerValue];
                sum += temp;
                
            }
            
            //        if (sum != 100) {
            //            yOrigin_all +=5;
            //            UILabel *lbl_notify = [[UILabel alloc]initWithFrame:CGRectMake(xorigin_label, yOrigin_all, 250, 27)];
            //            lbl_notify.font = [UIFont fontWithName:@"OpenSans" size:11.0f];
            //            lbl_notify.textColor = [UIColor redColor];
            //            lbl_notify.text = @"Total not 100%!";
            //            [self.view_scroll addSubview:lbl_notify];
            //            yOrigin_all += lbl_notify.frame.size.height;
            //        }
            
            yOrigin_all += 5;
            UIView *view_separator = [[UIView alloc]initWithFrame:CGRectMake(0, yOrigin_all, self.view.frame.size.width, 1)];
            view_separator.backgroundColor = [UIColor lightGrayColor];
            [self.view_scroll addSubview:view_separator];
            
            yOrigin_all += view_separator.frame.size.height;
            
            yOrigin_all += 8;
        }
        
        NSArray *viewArray =  [[NSBundle mainBundle] loadNibNamed:@"FinalFooter2" owner:self options:nil];
        UIView *view1 = [viewArray objectAtIndex:0];
        CGRect rect = view1.frame;
        rect.origin.y = yOrigin_all;
        [view1 setFrame:rect];
        [self.view_scroll addSubview:view1];
        yOrigin_all += view1.frame.size.height;
        
        [self.view_scroll setContentSize:CGSizeMake(self.view.frame.size.width, yOrigin_all)];
        
        yOrigin_all = Y_ORIGIN_MAIN;
        
    }
    
}



-(IBAction)click1:(id)sender
{
    UITextField *textF = sender;
    
    str_name = [NSString stringWithFormat:@"%@",[array_key objectAtIndex:textF.tag]];
    NSString *str_value = [NSString stringWithFormat:@"%@",[[array_sender objectAtIndex:textF.tag] objectForKey:str_name]];
    
    NSLog(@"array of keys size: %@", str_name);
    NSLog(@"array_sender size: %li", array_sender.count);
    
    NSMutableDictionary *dic_new_search = [[NSMutableDictionary alloc]init];
    [dic_new_search setObject:str_value forKey:str_name];
    
    int index_now = (int)[array_sender indexOfObject:dic_new_search];
    
    
    NSMutableDictionary *dic_new = [[NSMutableDictionary alloc]init];
    [dic_new setObject:[NSString stringWithFormat:@"%@",textF.text] forKey:str_name];
    
    [array_sender replaceObjectAtIndex:index_now withObject:dic_new];
    
    
    
    NSLog(@"--------%@, now index: %i",textF.text, index_now);
    NSLog(@"click1___ %li :textfield tag",textF.tag);
    NSLog(@"the new sender: %@", array_sender);
    
}

-(IBAction)click_cus:(id)sender
{
    UITextField *textF = sender;
    
    str_name = [NSString stringWithFormat:@"%@",[array_vsend objectAtIndex:textF.tag]];
    
    NSString *str_value = [NSString stringWithFormat:@"%@",[[array_send objectAtIndex:textF.tag] objectForKey:@"dibya"]];  //str_name
    
    
    NSLog(@"array of keys size: %@", str_name);
    NSLog(@"array_send size: %li", array_send.count);
    
    NSMutableDictionary *dic_new_search = [[NSMutableDictionary alloc]init];
    [dic_new_search setObject:str_value forKey:@"dibya"];
    
    int index_now = (int)[array_send indexOfObject:dic_new_search];
    
    
    NSMutableDictionary *dic_new = [[NSMutableDictionary alloc]init];
    [dic_new setObject:[NSString stringWithFormat:@"%@",textF.text] forKey:@"dibya"];
    
    [array_send replaceObjectAtIndex:index_now withObject:dic_new];
    
    
    
    NSLog(@"--------%@, now index: %i",textF.text, index_now);
    NSLog(@"click_cus___ %li :textfield tag",textF.tag);
    NSLog(@"the new sender with custom value: %@", array_send);
    
    //    sttttr=[dic_new objectForKey:str_name];
    //ary_send2=[[array_send objectAtIndex:textF.tag]objectForKey:str_name];
    
    
    
    //cusdic=[[NSMutableDictionary alloc]init];
    
    
}





- (void)numpadtool  {
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    cell_text.inputAccessoryView = numberToolbar;
    
}


-(void)cancelNumberPad{
    [cell_text resignFirstResponder];
    cell_text.text=@"";
}

-(void)doneWithNumberPad{
    // NSString *numberFromTheKeyboard = phone_num.text;
    
    [cell_text resignFirstResponder];
    
    
}





#pragma mark - textfield animate up

-(void)goup:(id)sender
{
    [self animateTextField:sender up:YES];
}

-(void)godown:(id)sender
{
    [self animateTextField:sender up:YES];
}


-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    int multidev = (up ? -self.view.frame.size.height/15 : self.view.frame.size.height/15);
    
    CGPoint buttonPosition = [textField convertPoint:CGPointZero toView:self.view_scroll];
    //NSIndexPath *indexPath = [self.tablev indexPathForRowAtPoint:buttonPosition];
    
    
    [UIView animateWithDuration:movementDuration animations:^{
        
        /*  self.view_bluehead.frame = CGRectMake(self.view_bluehead.frame.origin.x
         , self.view_bluehead.frame.origin.y + movement + multidev                                       , self.view_bluehead.frame.size.width
         , self.view_bluehead.frame.size.height); */
        
        self.tablev.frame = CGRectMake(self.tablev.frame.origin.x
                                       , self.tablev.frame.origin.y
                                       , self.tablev.frame.size.width
                                       , self.tablev.frame.size.height + movement + multidev);
        
    } completion:^(BOOL finished){
        
        [self.view_scroll setContentOffset:CGPointMake(0, buttonPosition.y) animated:YES];
        
    }];
    
    
    
    //    [UIView beginAnimations: @"animateTextField" context: nil];
    //    [UIView setAnimationBeginsFromCurrentState: YES];
    //    [UIView setAnimationDuration: movementDuration];
    //    self.view_bluehead.frame = CGRectOffset(self.view.frame, 0, movement);
    //    [self.view bringSubviewToFront:self.view_bluehead];
    //    self.tablev.frame = CGRectOffset(self.view.frame, 0, movement);
    //    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField == _text_commentcode) {
//        [textField resignFirstResponder];
//        UIView *view_options = [[UIView alloc]initWithFrame:CGRectMake(_view_commentcode.frame.origin.x, _view_commentcode.frame.origin.y + _view_commentcode.frame.size.height, _view_commentcode.frame.size.width, 35)];
//        [view_options.layer setShadowOffset:CGSizeMake(2.0f, 2.0f)];
//        [view_options.layer setShadowColor:[[UIColor blackColor]CGColor] ];
//        [view_options.layer setShadowOpacity:0.7f];
//        [view_options.layer setCornerRadius:1.0f];
//        [view_options.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
//        [view_options.layer setBorderWidth:1.0f];
//        
//                
//    }
//}

@end
