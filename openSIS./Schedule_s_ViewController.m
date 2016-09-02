//
//  Schedule_s_ViewController.m
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Schedule_s_ViewController.h"
#import "SdashboardViewController.h"
#import "RequestViewController.h"
#import "AppDelegate.h"
#import "S_slideViewController.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "S_MyScheduleViewController.h"


@interface Schedule_s_ViewController ()<UIPickerViewDataSource , UIPickerViewDelegate>
{

 NSString *courseperiodnamestr , *coperiod , * cp_flag;
     S_slideViewController *slide;
    NSMutableArray * course_period_title ,*ca_cp_id, *course_period_id, *course_period_ary;
    NSMutableDictionary * dic;


}
@property (strong, nonatomic) IBOutlet UIView *view_schdule;

@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@end

@implementation Schedule_s_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mp_text.text=_mptext;
    slide = [[S_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"schdulestudent"];
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    
    _view_schdule.layer.borderWidth =  1.0f;
    _view_schdule.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_schdule.layer setCornerRadius:3.5f];
    _view_schdule.clipsToBounds = YES;
    
       
    
    [self alldata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)myschdule:(id)sender {
    
    S_MyScheduleViewController *obj1 =[[S_MyScheduleViewController alloc]init];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    obj1=[sb instantiateViewControllerWithIdentifier:@"mysch"];
    [self.navigationController pushViewController:obj1 animated:YES];
    
    
}
- (IBAction)myrqst:(id)sender
{
    
    RequestViewController *obj1 =[[RequestViewController alloc]init];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    obj1=[sb instantiateViewControllerWithIdentifier:@"rqst"];
    [self.navigationController pushViewController:obj1 animated:YES];
    
}

-(void)courseperiodname
{
    
    
    
    
    pick= [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    pick  .delegate = self;
    
    pick.dataSource = self;
    
    [ pick  setShowsSelectionIndicator:YES];

    self.mp_text.inputView = pick;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.mp_text.inputAccessoryView = mypickerToolbar;
    
    
}

- (void)dismisspicker
{
    [self.mp_text resignFirstResponder];
   
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    return picary.count;
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{

    
  
    return [picary objectAtIndex:row];
    
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    _mp_text.text=(NSString *)[picary objectAtIndex:row];
   
    NSString *strC1 =(NSString *)[picary objectAtIndex:row];
    coperiod=[ca_cp_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
    //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
    NSString *strkk =(NSString *)[course_period_id objectAtIndex:row];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
    dic_8 = [appDelegate.dic mutableCopy];
    [dic_8 setObject:strkk forKey:@"UserMP"];
    appDelegate.dic = [dic_8 mutableCopy];
    NSLog(@"marking period id1111------%@",picary);
    
    NSLog(@"-------%@",coperiod);
    
    cp_flag=@"1";
    
    
}

-(NSString *)getCourseperiodtextfielddata
{
    courseperiodnamestr = [NSString stringWithFormat:@"%@",_mp_text.text];
    return courseperiodnamestr;
}
#pragma mark-------setdata
-(void)setCourseperiodtextfielddata:(NSString*)str
{
    courseperiodnamestr=str;
    _mp_text.text = courseperiodnamestr;
}

-(IBAction)click:(id)sender
{
    NSLog(@"slid open");
    [self open];
}

#pragma mark SideBarOpenFunction

-(void)open
{
    [slide open:self.view];
    
}
-(void)close
{
    [slide close:nil];
    [self fetchdata];
    //[self showdata];
    
}

-(void)alldata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
    dic=appDelegate.dic;
    NSLog(@"dic===========%@",dic);
    course_period_ary=[[dic objectForKey:@"marking_period_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
       picary= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [picary  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"id"]];
            [ca_cp_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
    
    
    // NSLog(@"course ary----%@",course_period_ary);
    if ([course_period_ary count] > 0) {
        for (int i=0; i<[course_period_ary count]; i++) {
            
            
            if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"id"]]) {
                dic177=[course_period_ary objectAtIndex:i];
                
                break;
                
            }
            
        }
    }
    else
    {
        
        NSLog(@"No Data Found");
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
        _dic_techinfo = (NSMutableDictionary *)responseObject;
        // NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[_dic_techinfo objectForKey:@"success"]];
        //  NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            //   NSLog(@"uuuuuu====%@",dic_techinfo);
            
            notofi.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"notification_count"]];
            NSString *str_count=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
            if ([str_count isEqualToString:@"0"]) {
                msg_count_tab.hidden=YES;
                msg_count.hidden=YES;
            }
            else
            {
                msg_count_tab.hidden=NO;
                msg_count.hidden=NO;
                
                msg_count_tab.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
                msg_count.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
            }
            // NSLog(@"lbl___---%@",lbl_hidden.text);
            
                         NSMutableArray *INFO1=[[NSMutableArray alloc]init];
            INFO1=[_dic_techinfo objectForKey:@"tech_info"];
            
            NSString *staff_id_value=[NSString stringWithFormat:@"%@",[[INFO1 objectAtIndex:0]objectForKey:@"STAFF_ID" ]];
            
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            
            [df setValue:staff_id_value forKey:@"iphone"];
            
        }
        
        
        else
        {
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            
            //  transparentView.hidden=NO;
            // NSLog(@"ok----");
            //[self.view addSubview:transparentView];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
}




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
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==self.mp_text) {
        [self courseperiodname];
    }
}
@end
