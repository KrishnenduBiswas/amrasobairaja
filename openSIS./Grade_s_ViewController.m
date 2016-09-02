////
////  Grade_s_ViewController.m
////  openSiS
////
////  Created by os4ed on 3/9/16.
////  Copyright © 2016 openSiS. All rights reserved.
////
//
//#import "Grade_s_ViewController.h"
//#import "StdgradeTableViewCell.h"
//#import "SdashboardViewController.h"
//#import "Gradebook_s_ViewController.h"
//#import "S_slideViewController.h"
//#import "AppDelegate.h"
//#import "GPAViewController.h"
//#import "FgradViewController.h"
//
//#import "ip_url.h"
//
//
//@interface Grade_s_ViewController ()<UIPickerViewDataSource , UIPickerViewDelegate , UIGestureRecognizerDelegate>
//{
//
//    S_slideViewController *slide;
//    int multiheight , totalheight;
//    NSString *courseperiodnamestr , * cp_flag;
//    
//   // NSMutableArray * course_period_title ,*ca_cp_id, *course_period_id, *course_period_ary;
//    NSMutableDictionary * dic;
//    
//    
//}
//@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
//@property (strong, nonatomic) IBOutlet UIView *view_gradebook;
//@end
//
//@implementation Grade_s_ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //[self alldata1];
//    
//    // Do any additional setup after loading the view.
//    slide = [[S_slideViewController alloc]init];
//    [slide setrect:self.view];
//    [slide setparentobject:self parentname:@"gradestudent"];
//    
////    [NSTimer scheduledTimerWithTimeInterval:2.0
////                                     target:self
////                                   selector:@selector(fetchdata)
////                                   userInfo:nil
////                                    repeats:YES];
////    
//    
//    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
//    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
//    swipeleft.numberOfTouchesRequired = 1;
//   //[baseView addGestureRecognizer:swipeleft];
//    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
//    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
//    swiperight.numberOfTouchesRequired = 1;
//    //[baseView addGestureRecognizer:swiperight];
// 
//
//    
//    course_period_title=[[NSMutableArray alloc]init];
//    
//    ary_gradebook=[[NSMutableArray alloc]initWithObjects:@"Gradebook Grades",@"Final Grades",@"Transcripts",@"GPA/Class Rank", nil];
//    
//    _view_gradebook.layer.borderWidth =  1.0f;
//    _view_gradebook.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
//    [_view_gradebook.layer setCornerRadius:3.5f];
//    _view_gradebook.clipsToBounds = YES;
//    
//    
//     [self courseperiod123];
//    [self alldata];
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    
//    [_view_coursePeriodName.layer setCornerRadius:2.0f];
//    _view_coursePeriodName.layer.borderWidth = 1.0f;
//    _view_coursePeriodName.clipsToBounds = YES;
//    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
//    // eta gradebook view er height set korar jonno
//    
//    if (self.view.frame.size.height == 568) {
//        multiheight = 28;
//    }
//    else if (self.view.frame.size.height == 667)
//    {
//        multiheight = 30;
//    }
//    else if (self.view.frame.size.height == 736)
//    {
//        multiheight = 33;
//    }
//    
//    int k2 = (int)ary_gradebook.count;
//    totalheight = k2 * multiheight;
//    CGRect rec = self.view_gradebook.frame;
//    rec.size.height = totalheight;
//    [self.view_gradebook setFrame:rec];
//    
//   }
//
//-(void)viewDidAppear:(BOOL)animated
//{
//    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0   inSection:0];
//    [self.gradtab scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    
//    
//}
//
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return ary_gradebook.count;
//    
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    StdgradeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellID"];
//
//    cell = (StdgradeTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"StdgradeTableViewCell" owner:self options:nil ]objectAtIndex:0];
//    cell.clipsToBounds = YES;
//    cell.cell_lbl.text = [NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]];
//
//
//    return cell;
//
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 27.0f;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSString *str_data=[ary_gradebook objectAtIndex:indexPath.row];
//    
//    
//    if([str_data isEqualToString:@"Gradebook Grades"])
//    {
//        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//        Gradebook_s_ViewController *obj1 =[[Gradebook_s_ViewController alloc]init];
//        obj1=[sb instantiateViewControllerWithIdentifier:@"Grdbook"];
//        
//        
//        [self.navigationController pushViewController:obj1 animated:YES];
//        
//        
//    }
//    if([str_data isEqualToString:@"GPA/Class Rank"])
//    {
//        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//        GPAViewController *gpa =[[GPAViewController alloc]init];
//        gpa=[sb instantiateViewControllerWithIdentifier:@"GPA"];
//        
//        
//        [self.navigationController pushViewController:gpa animated:YES];
//        
//        
//    }
//    if([str_data isEqualToString:@"Final Grades"])
//    {
//        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//        FgradViewController *fgvc =[[FgradViewController alloc]init];
//        fgvc=[sb instantiateViewControllerWithIdentifier:@"final"];
//        
//        
//        [self.navigationController pushViewController:fgvc animated:YES];
//        
//        
//    }
//
//
//    
//}
//
//
//
//-(IBAction)home:(id)sender
//{
//    
//   
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
//    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
//    
//    [self.navigationController pushViewController:sd animated:NO];
//    
//    
//    
//}
//
//-(void)courseperiod123{
//    
//    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
//    
//    selectcustomerpicker  .delegate = self;
//    
//    selectcustomerpicker .dataSource = self;
//    
//    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
//    selectcustomerpicker.tag=60;
//    courseperiodName.inputView = selectcustomerpicker;
//    
//    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
//    
//    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
//    
//    [mypickerToolbar sizeToFit];
//    
//    
//    
//    NSMutableArray *barItems = [[NSMutableArray alloc] init];
//    
//    
//    
//    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    
//    [barItems addObject:flexSpace];
//    
//    
//    
//    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
//    
//    [barItems addObject:doneBtn];
//    
//    
//    
//    [mypickerToolbar setItems:barItems animated:YES];
//    
//    
//    
//    courseperiodName.inputAccessoryView = mypickerToolbar;
//    
//    
//    
//    
//    
//    
//}
//
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//
//{
//    return 1;
//}
//
//
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//
//{
//    if (pickerView.tag==60)
//    {
//        
//        return marking_period_title.count;
//    }
//    
//    return 0;
//    
//    
//}
//
//
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//
//{
//    
//    if (pickerView.tag==60)
//    {
//        return [marking_period_title objectAtIndex:row];
//    }
//    
//    //
//    return 0;
//    
//    
//    
//}
//- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//
//{
//    
//    
//    
//    if (pickerView.tag==60) {
//        
//        
//        
//        courseperiodName.text=(NSString *)[marking_period_title objectAtIndex:row];
//        
//        NSString *strC1 =(NSString *)[marking_period_title objectAtIndex:row];
//        period123 = [marking_period_id objectAtIndex:[marking_period_title indexOfObjectIdenticalTo:strC1]];
//        
//        NSLog(@"id ut6e..........%@",period123);
//        
//        
//        
//        
//    }
//    
//}
//
//
//-(void)alldata1
//{
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    
//    marking_period=[[appDelegate.dic_term objectForKey:@"marking_period_list"]mutableCopy];
//    
//    if ([marking_period count]>0) {
//        marking_period_title= [[NSMutableArray alloc] init];
//        marking_period_id = [[NSMutableArray alloc] init];
//        for (int i = 0; i<[marking_period count]; i++) {
//            NSDictionary *dic15 = [marking_period objectAtIndex:i];
//            [marking_period_title  addObject:[dic15 objectForKey:@"title"]];
//            [marking_period_id addObject:[dic15 objectForKey:@"id"]];
//            
//        }
//        
//    }
//    else {
//        NSLog(@"No  list");
//    }
//    
//    
//    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
//    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
//    NSLog(@"llllllll%@",strt);
//    
//    NSLog(@"course ary----%@",marking_period);
//    for (int i=0; i<[marking_period count]; i++) {
//        
//        
//        if ([strt isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"id"]]) {
//            dic16=[marking_period objectAtIndex:i];
//            NSLog(@"dic16---%@",dic16);
//            
//            t=true;
//            break;
//            
//        }
//        
//    }
//    
//    
//    if (t==true) {
//        
//        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
//        _str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
//        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
//        [df setObject:_str_term1 forKey:@"period"];
//        NSLog(@"jjjjj%@",_str_term1);
//        
//        
//    }
//    
//    else
//    {
//        courseperiodName.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
//        _str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"id"]];
//        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
//        [df setObject:_str_term1 forKey:@"period"];
//       
//        
//        
//        
//    }
//}
//
//-(void)pickerDoneClicked1
//
//{
//    NSLog(@"Done Clicked");
//    
//    [courseperiodName resignFirstResponder];
//    
//}
//
//-(void)alldata
//{
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    //someString = appDelegate.dic;  //..to read
//    //  appDelegate.dic =dic;     //..to write
//    // appDelegate.dic_techinfo=dic_techinfo;
//    
//    
//       dic=appDelegate.dic;
//    NSLog(@"dic===========%@",dic);
//    course_period_ary=[[dic objectForKey:@"marking_period_list"]mutableCopy];
//    
//    if ([course_period_ary count]>0) {
//        course_period_title= [[NSMutableArray alloc] init];
//        course_period_id = [[NSMutableArray alloc] init];
//        for (int i = 0; i<[course_period_ary count]; i++) {
//            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
//            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
//            [course_period_id addObject:[dic15 objectForKey:@"id"]];
//            [ca_cp_id addObject:[dic15 objectForKey:@"id"]];
//            
//        }
//        
//    }
//    else {
//        NSLog(@"No  list");
//    }
//    
//    
//    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
//    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
//    
//    
//    // NSLog(@"course ary----%@",course_period_ary);
//    if ([course_period_ary count] > 0) {
//        for (int i=0; i<[course_period_ary count]; i++) {
//            
//            
//            if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"id"]]) {
//                dic177=[course_period_ary objectAtIndex:i];
//                
//                break;
//                
//            }
//            
//                }
//    }
//    else
//    {
//        
//        NSLog(@"No Data Found");
//    }
//    
//      
//    
//}
//
//#pragma mark-------Getdata
//-(NSString *)getCourseperiodtextfielddata
//{
//    courseperiodnamestr = [NSString stringWithFormat:@"%@",courseperiodName.text];
//    return courseperiodnamestr;
//}
//#pragma mark-------setdata
//-(void)setCourseperiodtextfielddata:(NSString*)str
//{
//    courseperiodnamestr=str;
//    courseperiodName.text = courseperiodnamestr;
//}
//
//-(IBAction)click:(id)sender
//{
//    NSLog(@"slid open");
//    [self open];
//}
//
//#pragma mark SideBarOpenFunction
//
//-(void)open
//{
//    [slide open:self.view];
//    
//}
//-(void)close
//{
//    [slide close:nil];
//    //[self fetchdata];
//    //[self showdata];
//    
//}
//
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if (textField == courseperiodName) {
//        [courseperiodName resignFirstResponder];
//        
//    }
//    
//    return YES;
//}
//
//
//
//
//
//
//
//
//
//@end
//
//  Grade_s_ViewController.m
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Grade_s_ViewController.h"
#import "StdgradeTableViewCell.h"
#import "SdashboardViewController.h"
#import "Gradebook_s_ViewController.h"
#import "S_slideViewController.h"
#import "AppDelegate.h"
#import "GPAViewController.h"
#import "FgradViewController.h"

#import "ip_url.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"


@interface Grade_s_ViewController ()<UIPickerViewDataSource , UIPickerViewDelegate , UIGestureRecognizerDelegate>
{
    
    S_slideViewController *slide;
    int multiheight , totalheight;
    NSString *courseperiodnamestr , *coperiod , * cp_flag;
    
    NSMutableArray * course_period_title ,*ca_cp_id, *course_period_id, *course_period_ary;
   // NSMutableDictionary * dic;
    
    
}
@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@property (strong, nonatomic) IBOutlet UIView *view_gradebook;
@end

@implementation Grade_s_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    slide = [[S_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"gradestudent"];
    
    //    [NSTimer scheduledTimerWithTimeInterval:2.0
    //                                     target:self
    //                                   selector:@selector(fetchdata)
    //                                   userInfo:nil
    //                                    repeats:YES];
    //
    
    
    
    
    courseperiodName.text=_mptext;
    
    
    
    
    
    
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
    
    
    [self courseperiod123];
    [self alldata];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
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
    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0   inSection:0];
    [self.gradtab scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ary_gradebook.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StdgradeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell = (StdgradeTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"StdgradeTableViewCell" owner:self options:nil ]objectAtIndex:0];
    cell.clipsToBounds = YES;
    cell.cell_lbl.text = [NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return multiheight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str_data=[ary_gradebook objectAtIndex:indexPath.row];
    
    
    if([str_data isEqualToString:@"Gradebook Grades"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
        Gradebook_s_ViewController *obj1 =[[Gradebook_s_ViewController alloc]init];
        obj1=[sb instantiateViewControllerWithIdentifier:@"Grdbook"];
        
        
        [self.navigationController pushViewController:obj1 animated:YES];
        
        
    }
    if([str_data isEqualToString:@"GPA/Class Rank"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
        GPAViewController *gpa =[[GPAViewController alloc]init];
        gpa=[sb instantiateViewControllerWithIdentifier:@"GPA"];
        
        
        [self.navigationController pushViewController:gpa animated:YES];
        
        
    }
    if([str_data isEqualToString:@"Final Grades"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
        FgradViewController *fgvc =[[FgradViewController alloc]init];
        fgvc=[sb instantiateViewControllerWithIdentifier:@"final"];
        
        
        [self.navigationController pushViewController:fgvc animated:YES];
        
        
    }
    
    
    
}



-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
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

//-(void)alldata
//{
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    //someString = appDelegate.dic;  //..to read
//    //  appDelegate.dic =dic;     //..to write
//    // appDelegate.dic_techinfo=dic_techinfo;
//    
//    
//    dic=appDelegate.dic;
//    NSLog(@"dic===========%@",dic);
//    course_period_ary=[[dic objectForKey:@"marking_period_list"]mutableCopy];
//    
//    if ([course_period_ary count]>0) {
//        course_period_title= [[NSMutableArray alloc] init];
//        course_period_id = [[NSMutableArray alloc] init];
//        for (int i = 0; i<[course_period_ary count]; i++) {
//            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
//            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
//            [course_period_id addObject:[dic15 objectForKey:@"id"]];
//            [ca_cp_id addObject:[dic15 objectForKey:@"id"]];
//            
//        }
//        
//    }
//    else {
//        NSLog(@"No  list");
//    }
//    
//    
//    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
//    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
//    
//    
//    // NSLog(@"course ary----%@",course_period_ary);
//    if ([course_period_ary count] > 0) {
//        for (int i=0; i<[course_period_ary count]; i++) {
//            
//            
//            if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"id"]]) {
//                dic177=[course_period_ary objectAtIndex:i];
//                
//                break;
//                
//            }
//            
//        }
//    }
//    else
//    {
//        
//        NSLog(@"No Data Found");
//    }
//    
//    
//    
//}
//

-(void)alldata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
    dic_techinfo
    
    =appDelegate.dic_techinfo;
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
                
                c_ap=true;
                break;
                
            }
            
            
        }
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
        dic_techinfo = (NSMutableDictionary *)responseObject;
        // NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"success"]];
        //  NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            //   NSLog(@"uuuuuu====%@",dic_techinfo);
            
           // notofi.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"notification_count"]];
            NSString *str_count=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
            if ([str_count isEqualToString:@"0"]) {
             //   msg_count_tab.hidden=YES;
            //    msg_count.hidden=YES;
            }
            else
            {
            //    msg_count_tab.hidden=NO;
             //   msg_count.hidden=NO;
                
              //  msg_count_tab.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
             //   msg_count.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
            }
            // NSLog(@"lbl___---%@",lbl_hidden.text);
            
            NSUserDefaults *ox=[NSUserDefaults standardUserDefaults];
            _profile=[ox objectForKey:@"profile"];
            // ip_url *obj=[[ip_url alloc]init];
            // NSString  *ip=[obj ipurl];
            //  NSLog(@"%@",ip);
            NSMutableArray *INFO1=[[NSMutableArray alloc]init];
            INFO1=[dic_techinfo objectForKey:@"tech_info"];
            
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
    //[self showdata];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == courseperiodName) {
        [courseperiodName resignFirstResponder];
        
    }
    
    return YES;
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
































@end
