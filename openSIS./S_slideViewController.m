//
//  S_slideViewController.m
//  openSiS
//
//  Created by os4ed on 3/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "S_slideViewController.h"
#import "AppDelegate.h"
#import "SdashboardViewController.h"
#import "MBProgressHUD.h"
#import "UIImageView+PhotoFrame.h"
#import "ip_url.h"
#import "Grade_s_ViewController.h"
#import "Schedule_s_ViewController.h"
#import "SettingViewController.h"
#import "SchoolinfoViewController.h"
#import "S_ReportViewController.h"

#import "sinfoViewController.h"


#import "FgradViewController.h"
#import "GPAViewController.h"

@interface S_slideViewController ()<UIGestureRecognizerDelegate, UIPickerViewDataSource,UIPickerViewDelegate >
{
 NSString    *staff_id_d;
    
    SdashboardViewController *superstudentdash;
    Grade_s_ViewController *superstudentgrade;
    Schedule_s_ViewController *superschdule;
    
    SettingViewController *supersettiing;
    
    SchoolinfoViewController  *superinfo;
    S_ReportViewController *superreport;
    
    
    FgradViewController*superfinal;
    GPAViewController*supergpa;
    
    
    
    
    
     NSString *thisparentName;
    NSMutableDictionary *dic,*dic_techinfo;
     UIView *view_inactive;
    NSString *school_year1;
    NSString *courseperiodnamestr;

}

@property (strong, nonatomic) IBOutlet UIView *view_schoolyear;

@property (strong, nonatomic) IBOutlet UIView *view_term;

@property (strong, nonatomic) IBOutlet UITextField *schoolYear;
@property (strong, nonatomic) IBOutlet UITextField *term;

@property (strong, nonatomic) UIView *superV;



@end

@implementation S_slideViewController
@synthesize view_schoolyear,view_term,schoolYear,term;


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

#pragma-mark parent
- (void)setparentobject:(id)parent parentname:(NSString *)parentname
{
    thisparentName = parentname;
    if ([thisparentName isEqualToString:@"sdashboard"]) {
       superstudentdash = [[SdashboardViewController alloc]init];
        superstudentdash = parent;
    }
    
    else if ([thisparentName isEqualToString:@"gradestudent"])
    {
        superstudentgrade=[[Grade_s_ViewController alloc]init];
        superstudentgrade=parent;
    }
    else if ([thisparentName isEqualToString:@"schdulestudent"])
    {
        superschdule=[[Schedule_s_ViewController alloc]init];
        superschdule=parent;
        
    }
    else if ([thisparentName isEqualToString:@"settingstudent"])
    {
        supersettiing=[[SettingViewController alloc]init];
        supersettiing=parent;
    }

    else if ([thisparentName isEqualToString:@"schoolinfo"])
    {
        superinfo=[[SchoolinfoViewController alloc]init];
        superinfo=parent;
    }
    else if ([thisparentName isEqualToString:@"reportstudent"])
    {
        superreport=[[S_ReportViewController alloc]init];
        superreport=parent;
    }
    else if ([thisparentName isEqualToString:@"finalgradestudent"])
    {
        superfinal=[[FgradViewController alloc]init];
        superfinal=parent;
    }
    else if ([thisparentName isEqualToString:@"fGPAstudent"])
    {
        supergpa=[[GPAViewController alloc]init];
        supergpa=parent;
    }
    
    
    

}

-(void)term1{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=3;
    term.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(termClicked1)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    term.inputAccessoryView = mypickerToolbar;
}

-(void)currentschoolyear
{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=2;
    schoolYear.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(yearClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    schoolYear.inputAccessoryView = mypickerToolbar;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    if (pickerView.tag==2)
    {
        
        return school_year_title.count;
    }
    
    else if (pickerView.tag==3)
    {
        
        return marking_period_title.count;
    }
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView.tag==2)
    {
        return [school_year_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==3)
    {
        return [marking_period_title objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
     if (pickerView.tag==2) {
        
        
        
        
        schoolYear.text=(NSString *)[school_year_title objectAtIndex:row];
        
        NSString *strC1 =(NSString *)[school_year_title objectAtIndex:row];
        school_year123 = [school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"-------%@",strC1);
        
      
        school_year_p=[school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
         
        term_flag=@"1";
    }
    
    
    else  if (pickerView.tag==3) {
        
        
        
        
//        term.text=(NSString *)[marking_period_title objectAtIndex:row];
//        
//        NSString *strC1 =(NSString *)[marking_period_title objectAtIndex:row];
//        period123 = [marking_period_id objectAtIndex:[marking_period_title indexOfObjectIdenticalTo:strC1]];
//        S_ReportViewController * report=[[S_ReportViewController alloc]init];
//        term_flag=@"1";
        
        
        
        
        term.text=(NSString *)[marking_period_title objectAtIndex:row];
        // coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[marking_period_title objectAtIndex:row];
        coperiod=[marking_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSString *strkk =(NSString *)[course_period_id objectAtIndex:row];
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
        dic_8 = [appDelegate.dic mutableCopy];
        [dic_8 setObject:strkk forKey:@"UserMP"];
        appDelegate.dic = [dic_8 mutableCopy];
        //NSLog(@"marking period id1111------%@",course_period_ary);
        
        NSLog(@"-------%@",coperiod);
        
        cp_flag=@"1";
        
        
        
        
        
        
        
        
        
           }
    
    
       
}

-(void)setrect:(UIView *)superview
{
    _superV = superview;
    
}
- (void)viewDidLoad
{
    
    
    self.view.frame=CGRectMake(0, 0, _superV.frame.size.width - 70, _superV.frame.size.height);
    int x = self.view.frame.size.width;
    slidewidth = x / 2;
    int y1 = self.view.frame.size.height;
    
    slideheight = y1 / 2;
    
    self.view.center = CGPointMake(-(float)slidewidth, (float)slideheight);
    
    [super viewDidLoad];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
    dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    
    
    NSLog(@"dic===========%@----term-----%@-------sub------%@----course---%@",dic,appDelegate.dic_term,appDelegate.dic_sub,appDelegate.dic_course);
    
    NSMutableArray *INFO1=[[NSMutableArray alloc]init];
    INFO1=[dic_techinfo objectForKey:@"tech_info"];
    
    
    staff_id_d=[[INFO1 objectAtIndex:0]objectForKey:@"STAFF_ID"];
    
    c_school=[[NSMutableArray alloc]init];
    school_year=[[NSMutableArray alloc]init];
    marking_period=[[NSMutableArray alloc]init];
    subject_ary=[[NSMutableArray alloc]init];
    course_ary=[[NSMutableArray alloc]init];
    course_period_ary=[[NSMutableArray alloc]init];
    ca_cp_id=[[NSMutableArray alloc]init];
   
    [self currentschoolyear];
    [self term1];
        [self alldata1];
    
    self.img_profile.layer.borderWidth = 4.0f;
    self.img_profile.layer.borderColor = [UIColor whiteColor].CGColor;
    // self.img_profile.clipsToBounds = YES;
    [self.img_profile applyPhotoFrame];

    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    view_term.layer.borderWidth = 1.0f;
   
    view_schoolyear.layer.borderWidth = 1.0f;
    currentSchool.layer.borderWidth = 1.0f;
    
    
    
        currentSchool.clipsToBounds = YES;
    view_schoolyear.clipsToBounds = YES;
       view_term.clipsToBounds = YES;
    
    
   
    currentSchool.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    view_schoolyear.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
   
    view_term.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    
    
    //[self setcourseperiod];
    
}

-(IBAction)open:(UIView *)superview  {
   
    if ([thisparentName isEqualToString:@"sdashboard"])
    {
        term.text = [superstudentdash getCourseperiodtextfielddata];
    }
    
    else if ([thisparentName isEqualToString:@"gradestudent"])
    {
    
    term.text = [superstudentgrade getCourseperiodtextfielddata];
    
    }
    
    else if ([thisparentName isEqualToString:@"schdulestudent"])
    {
        
        term.text = [superschdule getCourseperiodtextfielddata];
        
    }
    else if ([thisparentName isEqualToString:@"settingstudent"])
    {
        
        term.text = [superschdule getCourseperiodtextfielddata];
        
    }
    
    else if ([thisparentName isEqualToString:@"schoolinfo"])
    {
        
        term.text = [superinfo getCourseperiodtextfielddata];
        
    }
    else if ([thisparentName isEqualToString:@"reportstudent"])
    {
        
        term.text = [superinfo getCourseperiodtextfielddata];
        
    }
    
    ///////getdata
    view_inactive = [[UIView alloc]initWithFrame:_superV.frame];
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [view_inactive addGestureRecognizer:swipeleft];
    //[view_inactive setFrame:_superV.frame];
    [view_inactive setAlpha:0.0];
    view_inactive.backgroundColor = [UIColor blackColor];
    [superview addSubview:view_inactive];
    
    [self.view setCenter:CGPointMake(-slidewidth, slideheight)];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3f];
    [view_inactive setAlpha:0.6f];
    [self.view setCenter:CGPointMake(slidewidth, slideheight)];
    
    [superview addSubview:self.view];
    [UIView commitAnimations];
    
    
}
- (IBAction)close:(id)sender {
    
    if ([thisparentName isEqualToString:@"sdashboard"]) {
       [superstudentdash setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", term.text]];//setdata
        
      
    }
    else if ([thisparentName isEqualToString:@"gradestudent"])
    {
    
    [superstudentgrade setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", term.text]];//setdata
    
    }
    
    else if ([thisparentName isEqualToString:@"schdulestudent"])
    {
        
        [superschdule setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", term.text]];//setdata
        
    }
    
    else if ([thisparentName isEqualToString:@"schoolinfo"])
    {
        
        [superinfo setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", term.text]];//setdata
        
    }
    
    else if ([thisparentName isEqualToString:@"reportstudent"])
    {
        
        [superinfo setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", term.text]];//setdata
        
    }
    
    
    
   
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.3f];
    [self.view setCenter:CGPointMake(-slidewidth, slideheight)];
    [view_inactive setAlpha:0.0f];
    //[newView removeFromSuperview];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removetheview)];
    [UIView commitAnimations];
    
    
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    
    //[self.view removeFromSuperview];
}
-(void)removetheview
{
    [self.view removeFromSuperview];
}


-(void)yearClicked1

{
    
    
    [schoolYear resignFirstResponder];
}

-(void)termClicked1
{

    [term resignFirstResponder];
    
    
    S_ReportViewController * report=[[S_ReportViewController alloc]init];
    
    [report loaddata];
    

    

}

-(void)alldata1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:marking_period_type forKey:@"tanay"];
    
    
    marking_period=[[appDelegate.dic_term objectForKey:@"marking_period_list"]mutableCopy];
    
    if ([marking_period count]>0) {
        course_period_id = [[NSMutableArray alloc] init];
        marking_period_title= [[NSMutableArray alloc] init];
        marking_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[marking_period count]; i++) {
            NSDictionary *dic15 = [marking_period objectAtIndex:i];
            [marking_period_title  addObject:[dic15 objectForKey:@"title"]];
            [marking_period_id addObject:[dic15 objectForKey:@"id"]];
            [course_period_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    NSString *strt=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserMP"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",marking_period);
    for (int i=0; i<[marking_period count]; i++) {
        
        
        if ([strt isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"id"]]) {
            dic16=[marking_period objectAtIndex:i];
            NSLog(@"dic16---%@",dic16);
            
            t=true;
            break;
            
        }
        
    }
    
    
    if (t==true) {
        
        term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
        _str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:_str_term1 forKey:@"period"];
        
        
    }
    
    else
    {
        term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
        _str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"id"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:_str_term1 forKey:@"period"];
    }
    
    // school year data
    
    school_year=[[appDelegate.dic_year objectForKey:@"Schoolyear_list"]mutableCopy];
    
    if ([school_year count]>0) {
        school_year_title = [[NSMutableArray alloc] init];
        school_year_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[school_year count]; i++) {
            NSDictionary *dic15 = [school_year objectAtIndex:i];
            [school_year_title  addObject:[dic15 objectForKey:@"TITLE"]];
            [school_year_id addObject:[dic15 objectForKey:@"VALUE"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    
    NSMutableDictionary *dic167=[[NSMutableDictionary alloc]init];
    NSString *strt7=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SYEAR"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",school_year);
    for (int i=0; i<[school_year count]; i++) {
        
        
        if ([strt7 isEqual:[[school_year  objectAtIndex:i]objectForKey:@"VALUE"]]) {
            dic167=[school_year objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16);
            
            y=true;
            break;
            
            
        }
        
         }
    
    if (y==true) {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"TITLE"]];
        school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"VALUE"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year1 forKey:@"school_year"];
    }
    
    else
    {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"TITLE"]];
        school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"VALUE"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year1 forKey:@"school_year"];
    }

    

    // slider er user name , image sob print kora a6e
    
    
    
    NSLog(@"dicvalue---%@",dic);
    
    lbl_username.text=[NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"FIRST_NAME"],[dic objectForKey:@"LAST_NAME"]];
    
    lbl_useremail.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"EMAIL"]];
    
    NSString *gender12=[NSString stringWithFormat:@"%@",[dic objectForKey:@"GENDER"]];
    if ([gender12 isEqualToString:@"Female"]) {
        //  self.img_profile.layer.cornerRadius = img_profile.frame.size.width / 2;
        self.img_profile.layer.borderWidth = 4.0f;
        self.img_profile.layer.borderColor = [UIColor whiteColor].CGColor;
        // self.img_profile.clipsToBounds = YES;
        self.img_profile.image=[UIImage imageNamed:@"female"];
        [self.img_profile applyPhotoFrame];
        
    }
    
    else
    {
        //  self.img_profile.layer.cornerRadius = img_profile.frame.size.width / 2;
        self.img_profile.layer.borderWidth = 4.0f;
        self.img_profile.layer.borderColor = [UIColor whiteColor].CGColor;
        // self.img_profile.clipsToBounds = YES;
        self.img_profile.image=[UIImage imageNamed:@"male"];
        [self.img_profile applyPhotoFrame];
        
        
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSInteger weekday1 = [comps weekday];
    NSLog(@"The week day number: %ld", (long)weekday1);
    NSString *day;
    if (weekday1==1) {
        day=@"Sunday";
    }
    else  if (weekday1==2) {
        day=@"Monday";
    }
    else  if (weekday1==3) {
        day=@"Tuesday";
    }
    else  if (weekday1==4) {
        day=@"Wednesday";
    }
    
    else  if (weekday1==5) {
        day=@"Thursday";
        
    }
    
    
    else  if (weekday1==6) {
        day=@"Friday";
    }
    
    else  if (weekday1==7) {
        day=@"Saturday";
    }
    else
    {
        
        
    }
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd,yyyy"];
    NSLog(@"date and time------%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    lbl_currentDate.text=[NSString stringWithFormat:@"%@ %@",day,[dateFormatter stringFromDate:[NSDate date]]];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField !=courseperiodName && textField != term && textField != currentSchool && textField != schoolYear && textField != subject && textField != course) {
       // [self animateTextField:coursePeriod up:YES];
    }
    
    
    if (textField ==term) {
        
        old_term=_str_term1;
        
        NSLog(@"oldterm---%@",old_term);
        
        
        
    }
    
    if (textField==schoolYear) {
        
        old_year=school_year1;
        NSLog(@"old year---%@",old_year);
        
        
    }
    
    
}


-(IBAction)ok:(id)sender
{
    NSLog(@"Ok pressed");
    
    
    
    [self close:nil];
    
    
    
    
    
    
    

    
    
    
    
    
    
    
}

-(IBAction)logout:(id)sender
{
    NSLog(@"Logout button pressed");
    //  [self.navigationController popToRootViewControllerAnimated:YES];
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    //    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"er"];aPa
    
    if (superstudentdash) {
        [superstudentdash.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superstudentgrade)
    {
        [superstudentgrade.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superinfo)
    {
        [superinfo.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superreport)
    {
        [superreport.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superschdule)
    {
        [superschdule.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supersettiing)
    {
        [supersettiing.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superfinal)
    {
        [superfinal.navigationController popToRootViewControllerAnimated:YES];
    }
    
    else if (supergpa)
    {
        [supergpa.navigationController popToRootViewControllerAnimated:YES];
    }

  
    
    
   

}

@end
