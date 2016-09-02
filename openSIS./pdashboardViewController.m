//
//  SdashboardViewController.m
//  openSiS
//
//  Created by os4ed on 3/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "pdashboardViewController.h"
#import "P_slideViewController.h"
#import "Grade_s_ViewController.h"
#import "P_Schedule_s_ViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "MsgViewController.h"
#import "P_SettingViewController.h"
#import "P_SchoolinfoViewController.h"
#import "P_attendenceViewController.h"
#import "S_ReportViewController.h"
#import "P_msg1.h"
#import "P_studentViewController.h"
#import "Grade_p_ViewController.h"


@interface pdashboardViewController ()<UIPickerViewDelegate , UIPickerViewDataSource>
{

    P_slideViewController *slide;
NSString *courseperiodnamestr;
    NSMutableDictionary *dic,*dic_techinfo;
}
@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@end

@implementation pdashboardViewController





// student section er marking period teacher section er course period er moto kaj korbe ami copy kore6i bole tai variable er name gulo course period er name e a6e.






- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSLog(@"appdel.dic......%@",appDelegate.dic);
    
    
    
    
    
    
    
    
    
    
    
    slide = [[P_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"pdashboard"];
    
//    [NSTimer scheduledTimerWithTimeInterval:2.0
//                                     target:self
//                                   selector:@selector(fetchdata)
//                                   userInfo:nil
//                                    repeats:YES];
    
    [self fetchdata];
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    mtable.userInteractionEnabled=YES;
    //table.userInteractionEnabled = YES;
    //[table addGestureRecognizer:tapmainview];
    //newView.userInteractionEnabled = NO;
    
    flag =0;k=0;
    [labelView setFrame:CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, self.view.frame.size.width, 0)];
    labelView.backgroundColor = [UIColor redColor];
   [self alldata];
    
   [self courseperiod123];
    
    [self tabledata];
    
    // Do any additional setup after loading the view.
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



-(void)tabledata
{
    
    ary_data=[[NSMutableArray alloc]initWithObjects:@"School Info",@"Student",@"Schedule",@"Grades",@"Attendance",@"Extra Curricular", nil];
    img_ary=[[NSMutableArray alloc]initWithObjects:@"schoolinfo",@"mystudent",@"sch",@"grade",@"attendence",@"e_cur",nil];
    
    
    table.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
}



-(IBAction)msgg:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
    P_msg1 * mvc=[[P_msg1 alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_msg1"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
}

-(IBAction)settting:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
}

#pragma mark - TableView DataSource and Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    
    return ary_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell;
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"cell2" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.clipsToBounds = YES;
    lbl.text=[ary_data objectAtIndex:indexPath.row];
    img.image=[UIImage imageNamed:[img_ary objectAtIndex:indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40.0f;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str_data=[ary_data objectAtIndex:indexPath.row];
    
    
    if([str_data isEqualToString:@"Grades"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Grades" bundle:nil];
        Grade_p_ViewController *obj =[[Grade_p_ViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"p_garade"];
        
        
        obj.mptext=courseperiodName.text;
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }
    
    else if([str_data isEqualToString:@"Schedule"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Schedule" bundle:nil];
        P_Schedule_s_ViewController *obj =[[P_Schedule_s_ViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"p_schdle1"];
        
        obj.mptext=courseperiodName.text;
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }
    
    
    else if([str_data isEqualToString:@"School Info"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"ParentStoryboard" bundle:nil];
        P_SchoolinfoViewController *obj =[[P_SchoolinfoViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"IKO"];
        
        
        obj.mptext=courseperiodName.text;
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }
    
    if([str_data isEqualToString:@"Attendance"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Att" bundle:nil];
        P_attendenceViewController *obj =[[P_attendenceViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"p_att"];
        
        
        [self.navigationController pushViewController:obj animated:YES];
        

    
    }
    
    
    if([str_data isEqualToString:@"Student"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Student" bundle:nil];
        P_studentViewController *obj =[[P_studentViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"p_stu"];
        
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
        
    }

    
    
    
    
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    
    
    
    
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
    //[self fetchdata];
    [self showdata];
    
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
        
        return ary_stdname.count;
    }
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    if (pickerView.tag==60)
    {
        return [ary_stdname objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    if (pickerView.tag==60) {
        
        
        
        
        courseperiodName.text=(NSString *)[ary_stdname objectAtIndex:row];
               NSString *strC1 =(NSString *)[ary_stdname objectAtIndex:row];
        coperiod=[ary_stdid objectAtIndex:[ary_stdname indexOfObjectIdenticalTo:strC1]];
        //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSString *strkk =(NSString *)[ary_stdid objectAtIndex:row];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
        dic_8 = [appDelegate.dic mutableCopy];
        [dic_8 setObject:strkk forKey:@"selected_student"];
        appDelegate.dic = [dic_8 mutableCopy];
       
        
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
    
    
    NSMutableDictionary *dic1678=[[NSMutableDictionary alloc]init];
    NSString *strt78=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];
    ary_stdlist=[[NSMutableArray alloc]init ];
    ary_stdname=[[NSMutableArray alloc]init ];
    
    ary_stdid=[[NSMutableArray alloc]init ];
    ary_stdlist=[[appDelegate.dic_techinfo objectForKey:@"students_list"]mutableCopy ];
    
    for (int i=0; i<[ary_stdlist count]; i++) {
        
        
        if ([strt78 isEqual:[[ary_stdlist  objectAtIndex:i]objectForKey:@"ID"]]) {
            dic1678=[ary_stdlist objectAtIndex:i];
            
            [ary_stdid  addObject:[dic1678 objectForKey:@"ID"]];
            
            
            NSLog(@"-----------%@",ary_stdid);
            [ary_stdname addObject:[dic1678 objectForKey:@"VALUE"]];
            
            s_name=true;
            break;
            
            
        }
        
    }
    
    if (s_name==true) {
        
        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
    }
    
    else
    {
        
        courseperiodName.text=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
        
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
            
            
            
            
            NSString*str=[dictionary1 objectForKey:@"UserMP"];
    
            NSArray*arryy=[dictionary1 objectForKey:@"marking_period_list"];
            
            for (int i=0; i<arryy.count; i++) {
                if ([str isEqual:[[arryy objectAtIndex:i]objectForKey:@"id"]]) {
                    NSString*stpp=(NSString*)[[arryy objectAtIndex:i]objectForKey:@"title"];
                    [self setCourseperiodtextfielddata:stpp];

                    
                }
            }
            
            
            
            
            
            
            
            
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
            
            NSUserDefaults *ox=[NSUserDefaults standardUserDefaults];
            _profile=[ox objectForKey:@"profile"];
            // ip_url *obj=[[ip_url alloc]init];
            // NSString  *ip=[obj ipurl];
            //  NSLog(@"%@",ip);
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == courseperiodName) {
        [courseperiodName resignFirstResponder];
        
    }
    
    return YES;
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





-(IBAction)report:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    S_ReportViewController * report=[[S_ReportViewController alloc]init];
    report=[sb instantiateViewControllerWithIdentifier:@"rprt"];
    
    //report.sel_mp=period123;
    
    
    [self.navigationController pushViewController:report animated:YES];
    
    
    
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
