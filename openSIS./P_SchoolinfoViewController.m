//
//  SchoolinfoViewController.m
//  openSiS
//
//  Created by os4ed on 4/18/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_SchoolinfoViewController.h"

#import "s_infocellTableViewCell.h"
#import "pdashboardViewController.h"
#import "pinfoViewController.h"
#import "P_slideViewController.h"
#import "P_ListViewController.h"

#import "AppDelegate.h"
#import "ip_url.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"



@interface P_SchoolinfoViewController ()<UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
        NSMutableArray *ary_gradebook, *ary_setup;
        
        P_slideViewController *slide;
        NSString *courseperiodnamestr;
   
         UIPickerView *selectcustomerpicker;
    NSString *str_c_school_id123,*school_year123,*period123,*sub123,*cou123,*coperiod;

    
#pragma mark - for Multiple device
        
        int multiheight;
        // for setting view size
        int totalheight;
        // for setting setup view size
        int totalheight2;
       // SlideViewController *slide;
        IBOutlet UITextField *currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName;
}



@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;

 @property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;

@property (strong, nonatomic) IBOutlet UIView *view_firstView;
@property (strong, nonatomic) IBOutlet UIView *view_gradebook;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *baseView;

@property (strong, nonatomic) IBOutlet UITableView *table_setup;
@property (strong, nonatomic) IBOutlet UIView *view_setup;





/////////////////////////////////////

@property (strong, nonatomic) IBOutlet UILabel *lbl_grades;

@property (strong, nonatomic) IBOutlet UILabel *lbl_gradebook;
@property (strong, nonatomic) IBOutlet UIButton *btn_postfinalgrades;



@end

@implementation P_SchoolinfoViewController
@synthesize baseView;
- (void)viewDidLoad {
    [super viewDidLoad];
    slide = [[P_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"schoolinfo"];
    
//    [NSTimer scheduledTimerWithTimeInterval:2.0
//                                     target:self
//                                   selector:@selector(fetchdata)
//                                   userInfo:nil
//                                    repeats:YES];
    
    courseperiodName.text=_mptext;
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    //mtable.userInteractionEnabled=YES;
    //table.userInteractionEnabled = YES;
    //[table addGestureRecognizer:tapmainview];
    //newView.userInteractionEnabled = NO;
    
    
    [self alldata];
    
    [self courseperiod123];

    
    _view_firstView.layer.borderWidth = 1.0f;
    _view_firstView.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_firstView.layer setCornerRadius:3.5f];
    _view_firstView.clipsToBounds = YES;
    
    
    _view_gradebook.layer.borderWidth =  1.0f;
    _view_gradebook.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_gradebook.layer setCornerRadius:3.5f];
    _view_gradebook.clipsToBounds = YES;
    
    
    _view_setup.layer.borderWidth =  1.0f;
    _view_setup.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_setup.layer setCornerRadius:3.5f];
    _view_setup.clipsToBounds = YES;
    
    
    NSArray *ary = [[NSArray alloc]initWithObjects:@"School Information",@"Calendar", nil];
    
    ary_gradebook = [[NSMutableArray alloc]init];
    
    [ary_gradebook addObjectsFromArray:ary];
    NSLog(@"arrrr %@", ary_gradebook);

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


-(void)viewWillAppear:(BOOL)animated
{
    // eta gradebook view er height set korar jonno
    
    if (self.view.frame.size.height == 568) {
        multiheight = 36;
    }
    else if (self.view.frame.size.height == 667)
    {
        multiheight = 42;
    }
    else if (self.view.frame.size.height == 736)
    {
        multiheight = 48;
    }
    
    int k2 = (int)ary_gradebook.count;
    totalheight = k2 * multiheight;
    CGRect rec = self.view_gradebook.frame;
    rec.size.height = totalheight;
    [self.view_gradebook setFrame:rec];
    
    int k3 = (int)ary_setup.count;
    totalheight2 = k3 * multiheight;
    CGRect rec2 = self.view_setup.frame;
    rec2.size.height = totalheight2;
    [self.view_setup setFrame:rec2];
    
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
//    [self fetchdata];
//    [self showdata];
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tablev) {
        NSString *str_data=[ary_gradebook objectAtIndex:indexPath.row];
        if([str_data isEqualToString:@"School Information"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"ParentStoryboard" bundle:nil];
            pinfoViewController *obj = [sb instantiateViewControllerWithIdentifier:@"pinfo"];
            
            
            [self.navigationController pushViewController:obj animated:YES];
            
            
        }
        
        else if ([str_data isEqualToString:@"Calendar"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"ParentStoryboard" bundle:nil];
            P_ListViewController *obj = [sb instantiateViewControllerWithIdentifier:@"p_list"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0   inSection:0];
    [self.tablev scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self.table_setup scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tablev) {
        return ary_gradebook.count;
    }
    
    return ary_setup.count;
}

- (s_infocellTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    s_infocellTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"gbcell"];
    
    if (tableView == _tablev) {
        
        
        cell = (s_infocellTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"s_infocellTableViewCell" owner:self options:nil ]objectAtIndex:0];
        cell.clipsToBounds = YES;
        cell.lbl_txt.text = [NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]];
        NSLog(@"eta table %@",[NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]]);
    }
    
    
    
    return cell;
    
}
//lkjkljkldgdfgdfgd

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return multiheight;
}


-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ParentStoryboard" bundle: nil];
    pdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"pdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
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

@end
