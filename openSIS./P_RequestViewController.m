//
//  RequestViewController.m
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_RequestViewController.h"
#import "RequestTableViewCell.h"
#import "AFNetworking.h"
#import "pdashboardViewController.h"
#import "P_Add_requestViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "P_EditReqstViewController.h"
#import "P_SettingViewController.h"
#import "S_ReportViewController.h"
#import "P_SettingViewController.h"
#import "pdashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"

@interface P_RequestViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIView *view_onlongpress;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Title;
@property (strong, nonatomic) IBOutlet UIView *view_sublongpress;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dialogTitle;
@property (strong, nonatomic) IBOutlet UIView *view_schdule;

@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;

@end

@implementation P_RequestViewController
{

    NSIndexPath *currentIndex;
     NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type ,*success_c;
    
     NSString    *parentid;
    NSDictionary * dic;
    NSString * rqst_id;
    
    
    NSString *courseperiodnamestr , *coperiod , * cp_flag;

    NSMutableArray * course_period_title ,*ca_cp_id, *course_period_id, *course_period_ary;
  

    
    
    
    
    
    
    
    
    
    
}














-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ParentStoryboard" bundle: nil];
    pdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"pdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
    
}
-(IBAction)thirdButton:(id)sender
{
    NSLog(@"Third Button");
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
    P_msg1 * mvc=[[P_msg1 alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_msg1"];
    [self.navigationController pushViewController:mvc animated:NO];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
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
    
    
    
    
    [self alldata];
    
    
    [self courseperiodname];
    
    
    
    
    [self loaddata];
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
-(IBAction)addbtn:(id)sender
{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"P_Schedule" bundle: nil];
        P_Add_requestViewController* sd = [storyboard instantiateViewControllerWithIdentifier:@"p_newreqst"];
        [self.navigationController pushViewController:sd animated:NO];
    
        
    }

-(void)loaddata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];
    
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    NSLog(@"%@",mp_id);
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_schedule_request.php?action=view&student_id=%@&syear=%@",student_id,s_year];
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
        
        NSMutableArray *userarray=[[NSMutableArray alloc]init];
        userarray=[dictionary1 objectForKey:@"request_data"];
        
        
        int*strsucc=[[dictionary1 objectForKey:@"success"]intValue];
        
        if (strsucc==1) {
            
            
            
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


-(void)loaddelete
{
    
    
    
        
        
        
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];
    
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
        ip_url *obj123=[[ip_url alloc]init];
        NSString *str123=[obj123 ipurl];
        NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_schedule_request.php?action=delete&student_id=%@&syear=%@&req_id=%@",student_id,s_year,rqst_id];
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
                [self loaddata];
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            //  transparentView.hidden=NO;
            //  NSLog(@"ok----");
            //[self.view addSubview:transparentView];
        }];
        
        
        [operation start];
        
        

    

    
    
    
    
    
}








-(void)courseperiodname
{
    
    
    
    
    pick= [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    pick  .delegate = self;
    
    pick.dataSource = self;
    pick.tag=60;
    [ pick  setShowsSelectionIndicator:YES];
    
    self.mp_text.inputView = pick;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.mp_text.inputAccessoryView = mypickerToolbar;
    
    
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
        
        
        
        
        _mp_text.text=(NSString *)[ary_stdname objectAtIndex:row];
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
    if ([cp_flag isEqualToString:@"1"]) {
        [self loaddata];
    }
    
    
    NSLog(@"Done Clicked");
    
    
    
    
    
    
    
    
    
    
    [_mp_text resignFirstResponder];
    
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
        
        _mp_text.text=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
    }
    
    else
    {
        
        _mp_text.text=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
        
    }
    
    
}











































-(void)viewWillAppear:(BOOL)animated
{
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)action_edit:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"P_Schedule" bundle: nil];
    

    P_EditReqstViewController* editvc =[[P_EditReqstViewController alloc]init];
    editvc=[storyboard instantiateViewControllerWithIdentifier:@"p_editrqst"];
    
    
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
