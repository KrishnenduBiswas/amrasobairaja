//
//  Gradebook_s_ViewController.m
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Gradebook_p_ViewController.h"
#import "P_slideViewController.h"
#import "AFNetworking.h"
#import "PtdgrdbookTableViewCell.h"
#import "Grade_p_ViewController.h"
#import "P_Grade_detail_ViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "CPdetails.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"


@interface Gradebook_p_ViewController ()<UIPickerViewDelegate , UIPickerViewDataSource ,UITableViewDelegate>
{

    NSMutableArray *grade_arry;
    NSArray *arry;
    int currentwidth, currentheight;
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;
    
    
    NSString    *parentid;

    
    
    P_slideViewController *slide;
    int multiheight , totalheight;
    NSString *courseperiodnamestr , *coperiod , * cp_flag;
    
    NSMutableArray * course_period_title ,*ca_cp_id, *course_period_id, *course_period_ary;
    // NSMutableDictionary * dic;



}
@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@property (strong, nonatomic) IBOutlet UIView *view_gradebook;


@end

@implementation Gradebook_p_ViewController
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
    
    
    
    
    
    
    slide = [[P_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"gradbookeparent"];
    
    //    [NSTimer scheduledTimerWithTimeInterval:2.0
    //                                     target:self
    //                                   selector:@selector(fetchdata)
    //                                   userInfo:nil
    //                                    repeats:YES];
    //
    
    
    [self alldata];
    
    courseperiodName.text=_mptext;
    
    
    [self courseperiod1];
    
    
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swiperight];
    
    
    
    course_period_title=[[NSMutableArray alloc]init];
    
    ary_gradebook=[[NSMutableArray alloc]initWithObjects:@"Gradebook Grades",@"Final Grades",@"Transcripts",@"GPA/Class Rank", nil];
    
    _view_gradebook.layer.borderWidth =  1.0f;
    _view_gradebook.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_gradebook.layer setCornerRadius:3.5f];
    _view_gradebook.clipsToBounds = YES;
    
    
   
    //[self alldata];

    
    
    
    courseperiodName.text=_mptext;
    
    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    [self loaddata];
    
     arry=[[NSArray alloc]initWithObjects:@"Totals",@"Detailed", nil ];
    [self courseperiod123];
    
    
    
    grade_table.tableFooterView=[[UIView alloc]init];
    
     AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"appdeldic---%@",appDelegate.dic);
    
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
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
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    
    
    
    [stname.layer setCornerRadius:2.0f];
    stname.layer.borderWidth = 1.0f;
    stname.clipsToBounds = YES;
    stname.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    
    
    
    [self alldata];
    
    
    
    
    
    
}

-(void)loaddata1
{
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_gradebook_grades.php?student_id=1&school_id=1&syear=2015&mp_id=17&action_type=totals
    
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
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_gradebook_grades.php?parent_id=%@&student_id=%@&syear=%@&mp_id=%@&action_type=totals",parentid,student_id,s_year,mp_id];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    
    
    
    
    
    
    
    
    grade_arry =[[NSMutableArray alloc]init];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        
        NSLog(@"............%@",dictionary1);
        
        NSMutableArray *userarray=[[NSMutableArray alloc]init];
        userarray=[dictionary1 objectForKey:@"gradebook_grade_data"];
        
        for (int i=0; i<[userarray count]; i++) {
            
            
            grade_arry =userarray;
            
            // [self.rqstarry addObject:[userarray objectAtIndex:i]];
            
            
        }
        
        [grade_table reloadData];
        
        NSString *str_succ1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        
        if ([str_succ1 isEqualToString:@"1"]) {
            
            //NSLog(@"----------%@",str_succ1);
            
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"user details" message:str_succ1 delegate:self cancelButtonTitle:nil otherButtonTitles:@"OKK", nil];
//            [alert show];
            
            
            
            
        }
        //[self performSegueWithIdentifier:@"log_detail" sender:self];
        else
        {
            NSLog(@"not success");
            
        }
        
        // NSLog(@"%@",[dictionary1 objectForKey:@"Message"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
    [operation start];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// tableview er delegate and datasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return grade_arry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PtdgrdbookTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"T1"];
    
    cell = (PtdgrdbookTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"PtdgrdbookTableViewCell" owner:self options:nil ]objectAtIndex:0];
    // cell.clipsToBounds = YES;
   
    cell.title_lbl.text=[NSString stringWithFormat:@"%@ - %@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"TITLE"] , [[grade_arry objectAtIndex:indexPath.row]objectForKey:@"TEACHER"]] ;
    
    cell.percent_lbl.text=[NSString stringWithFormat:@"%@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"PERCENT"]];
    
    cell.graderange_lbl.text=[NSString stringWithFormat:@"%@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"BAR1"]];
    
    cell.grade.text=[NSString stringWithFormat:@"%@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"GRADE"]];
    
    
    cell.ungrade_lbl.text=[NSString stringWithFormat:@"%@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"UNGRADED"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    

    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Grades" bundle:nil];
    P_Grade_detail_ViewController *obj =[[P_Grade_detail_ViewController alloc]init];
    obj=[sb instantiateViewControllerWithIdentifier:@"p_grddetail"];
    
    
    obj.c_id=[NSString stringWithFormat:@"%@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"ID"]];
    
    [self.navigationController pushViewController:obj animated:NO];



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 55.0f;
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
    }
    
}

-(IBAction)back:(id)sender
{

    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Grades" bundle:nil];
    Grade_p_ViewController *obj =[[Grade_p_ViewController alloc]init];
    obj=[sb instantiateViewControllerWithIdentifier:@"p_garade"];
    
    
       
    [self.navigationController pushViewController:obj animated:NO];
    
    
}



-(void)loaddata
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:2];
        });
    });
    
    
    
}


-(void)courseperiod1{
    
    selectcustomerpicker1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker1.delegate = self;
    
    selectcustomerpicker1.dataSource = self;
    
    [ selectcustomerpicker1  setShowsSelectionIndicator:YES];
    selectcustomerpicker1.tag=60;
    _mp_text.inputView = selectcustomerpicker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    _mp_text.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}






















-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker.delegate = self;
    
    selectcustomerpicker.dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=61;
    courseperiodName.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked2)];
    
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
        
        return arry.count;
    }
    
    
    else if (pickerView.tag==61) {
        
          return ary_stdname.count;
    }

    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    if (pickerView.tag==60)
    {
        return [arry objectAtIndex:row];
    }
    
    else if (pickerView.tag==61) {
        
        return [ary_stdname objectAtIndex:row];
    }

    
    
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    if (pickerView.tag==60) {
        
        
        _mp_text.text=[arry objectAtIndex:[selectcustomerpicker1 selectedRowInComponent:0]];
        
    }
    
    
    else if (pickerView.tag==61) {
        
        
        
        
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
    
    [_mp_text resignFirstResponder];
    
    NSString * strmp= _mp_text.text;
    if ([strmp isEqualToString:@"Detailed"]) {
        
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Grades" bundle:nil];
        P_Grade_detail_ViewController *obj =[[P_Grade_detail_ViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"p_grddetail"];
        
        
        obj.c_id=@"all";
        
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    
}

-(void)pickerDoneClicked2

{
    
    
    if ([cp_flag isEqualToString:@"1"]) {
        [self loaddata];
    }

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

























/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
