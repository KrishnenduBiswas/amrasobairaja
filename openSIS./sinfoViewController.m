//
//  sinfoViewController.m
//  openSiS
//
//  Created by os4ed on 4/18/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "sinfoViewController.h"

#import "AppDelegate.h"
#import "ip_url.h"
#import "mapViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"


@interface sinfoViewController ()<UIPickerViewDataSource , UIPickerViewDelegate>
{

       IBOutlet UIView *VIEW_MAP;
    int multiheight , totalheight;
    NSString *courseperiodnamestr , *coperiod , * cp_flag;
    
    NSMutableArray * course_period_title ,*ca_cp_id, *course_period_id, *course_period_ary;
    NSMutableDictionary * dic;
    int currentwidth, currentheight;
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;
    UIPickerView *selectcustomerpicker;
    NSMutableArray *ary_gradebook;
    
    IBOutlet UITextField *courseperiodName;

    
}

@end

@implementation sinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *mising= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OPENMAP:)];
    mising.numberOfTapsRequired = 1;
    
    //[self.view addGestureRecognizer:tapmainview];
    [VIEW_MAP addGestureRecognizer:mising];
    
    [self loaddata];
    [self courseperiod123];
     [self alldata];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(IBAction)OPENMAP:(id)sender
{
    
    
    NSString *str_address=[NSString stringWithFormat:@"%@ %@ %@ %@",add.text,city.text,stae.text,zip.text];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    mapViewController *obj = [sb instantiateViewControllerWithIdentifier:@"map"];
    obj.str_address=str_address;
    obj.str_name=sname.text;
    [self.navigationController pushViewController:obj animated:YES];
    
    NSLog(@"HELLOW");
    
}


-(void)loaddata1
{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/school_info.php?school_id=%@",s_year_id];
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
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            NSDictionary  *sinfo=[dictionary1 objectForKey:@"school_data"];
            NSLog(@"sinfo----%@",sinfo);
            
            
            sname.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"TITLE"]];
            add.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"ADDRESS"]];
            city.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"CITY"]];
            stae.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"STATE"]];
            tel.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"PHONE"]];
            website.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"WWW_ADDRESS"]];
            email.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"E_MAIL"]];
            prin.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"PRINCIPAL"]];
            zip.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"ZIPCODE"]];
            
            base.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"REPORTING_GP_SCALE"]];
            
            
            
            
        }
        
        
        else
        {
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //   lbl_show.hidden=NO;
            //    mtable.hidden=YES;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}

-(void)loaddata
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        });
    });
    
    
}

-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    courseperiodName.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    courseperiodName.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView.tag==60)
    {
        
        return course_period_title.count;
    }
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    if (pickerView.tag==60)
    {
        return [course_period_title objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    if (pickerView.tag==60) {
        
        
        
        
        courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
        // coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
        coperiod=[ca_cp_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSString *strkk =(NSString *)[course_period_id objectAtIndex:row];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
        dic_8 = [appDelegate.dic mutableCopy];
        [dic_8 setObject:strkk forKey:@"UserMP"];
        appDelegate.dic = [dic_8 mutableCopy];
        NSLog(@"marking period id1111------%@",course_period_ary);
        
        NSLog(@"-------%@",coperiod);
        
        cp_flag=@"1";
    }
    
}
-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    [courseperiodName resignFirstResponder];
    
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
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
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

#pragma mark-------Getdata
-(NSString *)getCourseperiodtextfielddata
{
    courseperiodnamestr = [NSString stringWithFormat:@"%@",courseperiodName.text];
    return courseperiodnamestr;
}
#pragma mark-------setdata
-(void)setCourseperiodtextfielddata:(NSString*)str
{
    courseperiodnamestr=str;
    courseperiodName.text = courseperiodnamestr;
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



-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
