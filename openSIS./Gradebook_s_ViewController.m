//
//  Gradebook_s_ViewController.m
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Gradebook_s_ViewController.h"
#import "AFNetworking.h"
#import "StdgrdbookTableViewCell.h"
#import "Grade_s_ViewController.h"
#import "Grade_detail_ViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "CPdetails.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"


@interface Gradebook_s_ViewController ()<UIPickerViewDelegate , UIPickerViewDataSource ,UITableViewDelegate>
{

    NSMutableArray *grade_arry;
    UIPickerView * selectcustomerpicker;
    NSArray *arry;
    int currentwidth, currentheight;
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;
    


}
@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;

@end

@implementation Gradebook_s_ViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata];
    
     arry=[[NSArray alloc]initWithObjects:@"Totals",@"Detailed", nil ];
    [self courseperiod123];
    
    grade_table.tableFooterView=[[UIView alloc]init];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
}

-(void)loaddata
{
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/student/stu_gradebook_grades.php?student_id=1&school_id=1&syear=2015&mp_id=17&action_type=totals
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    //    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    //    student_id=[DF objectForKey:@"iphone"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_gradebook_grades.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&action_type=totals",student_id,s_year_id,s_year,mp_id];
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
    
    StdgrdbookTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"T"];
    
    cell = (StdgrdbookTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"StdgrdbookTableViewCell" owner:self options:nil ]objectAtIndex:0];
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

    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    CPdetails *cpdetail=[[CPdetails alloc]init];
    cpdetail=[sb instantiateViewControllerWithIdentifier:@"CP"];
    cpdetail.detail_array=grade_arry;
    cpdetail.id_str=[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"ID"];
    cpdetail.name_title=[NSString stringWithFormat:@"%@ - %@",[[grade_arry objectAtIndex:indexPath.row]objectForKey:@"TITLE"] , [[grade_arry objectAtIndex:indexPath.row]objectForKey:@"TEACHER"]] ;
    

    [self.navigationController pushViewController:cpdetail animated:YES];



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 80.0f;
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
    }
    
}

-(IBAction)back:(id)sender
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
   Grade_s_ViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"stdgarade"];
   
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
}


-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    _mp_text.inputView = selectcustomerpicker;
    
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
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    if (pickerView.tag==60)
    {
        return [arry objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    if (pickerView.tag==60) {
        
        
        _mp_text.text=[arry objectAtIndex:[selectcustomerpicker selectedRowInComponent:0]];
        
    }
    
}
-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    [_mp_text resignFirstResponder];
    
    NSString * strmp= _mp_text.text;
    if ([strmp isEqualToString:@"Detailed"]) {
        
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
       Grade_detail_ViewController *obj =[[Grade_detail_ViewController alloc]init];
        obj=[sb instantiateViewControllerWithIdentifier:@"grddetail"];
        
        
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    
}


-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
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
