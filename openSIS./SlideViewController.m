//
//  SlideViewController.m
//  conceptslider
//
//  Created by os4ed on 10/5/15.
//  Copyright © 2015 os4ed. All rights reserved.
//
#import "AFNetworking.h"
#import "SlideViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "MBProgressHUD.h"
#import "UIImageView+PhotoFrame.h"
#import "attendence.h"
#import "GradesViewController.h"
#import "AssignmentViewController.h"
#import "ViewController.h"
#import "GradesTotalViewController.h"
#import "GradesAssignmentType.h"
#import "PostfinalgradesController.h"
#import "ScheduleHomeController.h"
#import "attendetail.h"
#import "msg1.h"
#import "MessageGroupController.h"
#import "CourseManagerSubject.h"
#import "mp.h"

@interface SlideViewController ()

{
    NSString    *staff_id_d;
    
    TeacherDashboardViewController *superteacherdashobject;
    attendence *superattendanceobject;
    GradesViewController *supergradesobject;
    AssignmentViewController *superassignmentobject;
    GradesTotalViewController *supergradesTotalobject;
    GradesAssignmentType *supergradesassignmenttypeobject;
    PostfinalgradesController *superpostfinalgradesobject;
    ScheduleHomeController *superschedulehomeobject;
    attendetail *superattendetailobject;
    msg1 *supermsg1object;
    MessageGroupController *supermessagegroupobject;
    CourseManagerSubject *supercoursemanagersubjectobject;
    mp *supermp_period;
    NSMutableDictionary *dic,*dic_techinfo;

    IBOutlet UIView*kkview;
    
    NSString *term123,*sub1234;
    attendence *atd;
    
    NSString *thisparentName;
    UIView *view_inactive;
}


@property (strong, nonatomic) IBOutlet UIView *view_currentSchool;
@property (strong, nonatomic) IBOutlet UIView *view_schoolyear;
@property (strong, nonatomic) IBOutlet UIView *view_subject;
@property (strong, nonatomic) IBOutlet UIView *view_courseperiod;
@property (strong, nonatomic) IBOutlet UIView *view_course;
@property (strong, nonatomic) IBOutlet UIView *view_term;
@property (strong, nonatomic) IBOutlet UITextField *currentSchool;
@property (strong, nonatomic) IBOutlet UITextField *schoolYear;
@property (strong, nonatomic) IBOutlet UITextField *term;
@property (strong, nonatomic) IBOutlet UITextField *subject;
@property (strong, nonatomic) IBOutlet UITextField *course;
@property (strong, nonatomic) IBOutlet UITextField *coursePeriod;
@property (strong, nonatomic) UIView *superV;


//- (IBAction)close:(id)sender;



@end

@implementation SlideViewController



@synthesize  school_id,school_year1,str_term1,str_sub1,str_cou1,str_cp1,term,currentSchool,schoolYear,subject,course,coursePeriod;

-(void)courseperiodname
{
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    coursePeriod.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    coursePeriod.inputAccessoryView = mypickerToolbar;
    
    
}

#pragma-mark parent
- (void)setparentobject:(id)parent parentname:(NSString *)parentname
{
    thisparentName = parentname;
    if ([thisparentName isEqualToString:@"teacherdashboard"]) {
        superteacherdashobject = [[TeacherDashboardViewController alloc]init];
        superteacherdashobject = parent;
    }
    else if ([thisparentName isEqualToString:@"missingattendance"])
    {
        superattendanceobject = [[attendence alloc]init];
        superattendanceobject = parent;
    }
    else if ([thisparentName isEqualToString:@"gradesmain"])
    {
        supergradesobject = [[GradesViewController alloc]init];
        supergradesobject = parent;
    }
    else if ([thisparentName isEqualToString:@"assignment"])
    {
        superassignmentobject = [[AssignmentViewController alloc]init];
        superassignmentobject = parent;
    }
    else if ([thisparentName isEqualToString:@"gradestotal"])
    {
        supergradesTotalobject = [[GradesTotalViewController alloc]init];
        supergradesTotalobject = parent;
    }
    else if ([thisparentName isEqualToString:@"gradesassignment"])
    {
        supergradesassignmenttypeobject = [[GradesAssignmentType alloc]init];
        supergradesassignmenttypeobject = parent;
    }
    else if ([thisparentName isEqualToString:@"postfinalgrades"])
    {
        superpostfinalgradesobject = [[PostfinalgradesController alloc]init];
        superpostfinalgradesobject = parent;
    }
    else if ([thisparentName isEqualToString:@"schedulehome"])
    {
        superschedulehomeobject = [[ScheduleHomeController alloc]init];
        superschedulehomeobject = parent;
    }
    else if ([thisparentName isEqualToString:@"attendetail"])
    {
        superattendetailobject = [[attendetail alloc]init];
        superattendetailobject = parent;
    }
    else if ([thisparentName isEqualToString:@"msg1"])
    {
        supermsg1object = [[msg1 alloc]init];
        supermsg1object = parent;
        
    }
    else if ([thisparentName isEqualToString:@"msggroup"])
    {
        supermessagegroupobject = [[MessageGroupController alloc]init];
        supermessagegroupobject = parent;
        
    }
    else if ([thisparentName isEqualToString:@"coursemanager"])
    {
        supercoursemanagersubjectobject = [[CourseManagerSubject alloc]init];
        supercoursemanagersubjectobject = parent;
        
    }

    
    else if ([thisparentName isEqualToString:@"mpperiod"])
    {
       supermp_period= [[mp alloc]init];
       supermp_period= parent;
        
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


-(void)currentcourse
{
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=5;
    course.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(courseClicked1)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    course.inputAccessoryView = mypickerToolbar;
    
}


-(void)currentsubject
{
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=4;
    subject.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(subClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    subject.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
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

-(void)currentschool
{
    
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=1;
    currentSchool.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(schoolClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    currentSchool.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    if (pickerView.tag==1) {
        
        return c_school_title.count;
    }
    else if (pickerView.tag==2)
    {
        
        return school_year_title.count;
    }
    
    else if (pickerView.tag==3)
    {
        
        return marking_period_title.count;
    }
    else if (pickerView.tag==4)
    {
        
        return subject_title.count;
    }
    else if (pickerView.tag==5)
    {
        
        return course_title.count;
    }
    
    else if (pickerView.tag==6)
    {
        
        return course_period_title.count;
    }
    else if (pickerView.tag==60)
    {
        
        return course_period_title.count;
    }
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView.tag==1) {
        
        
        return [c_school_title objectAtIndex:row];
    }
    else if (pickerView.tag==2)
    {
        return [school_year_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==3)
    {
        return [marking_period_title objectAtIndex:row];
    }
    
    
    else if (pickerView.tag==4)
    {
        return [subject_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==5)
    {
        return [course_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==6)
    {
        return [course_period_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==60)
    {
        return [course_period_title objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    if (pickerView.tag==1) {
        
        
        
        
        
        currentSchool.text=(NSString *)[c_school_title objectAtIndex:row];
        NSString *strC =(NSString *)[c_school_title objectAtIndex:row];
        str_c_school_id123 = [c_school_id objectAtIndex:[c_school_title indexOfObjectIdenticalTo:strC]];
        
        NSLog(@"-------%@",str_c_school_id123);
       
        
        school_id_p=[c_school_id objectAtIndex:[c_school_title indexOfObjectIdenticalTo:strC]];
       
        NSLog(@"school id---%@",school_id_p);
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_id_p forKey:@"school_id1"];
        flag123=@"1";
          s_flag=@"1";
     //   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [self dropdowndata];
//        [self currentschoolyear];
//        [self term1];
//        [self currentsubject];
//        [self currentcourse];
//        
//        [self courseperiod123];

     
    }
    
    
    
    else  if (pickerView.tag==2) {
        
        
        
        
        schoolYear.text=(NSString *)[school_year_title objectAtIndex:row];
        
        NSString *strC1 =(NSString *)[school_year_title objectAtIndex:row];
        school_year123 = [school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"-------%@",strC1);
        
     //   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        school_year_p=[school_year_id objectAtIndex:[school_year_title indexOfObjectIdenticalTo:strC1]];
//        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
//        [df setObject:school_year_p forKey:@"school_year"];
//        flag123=@"1";
//        [self dropdowndatayear];
//        
//          [self term1];
//        [self currentsubject];
//        [self currentcourse];
//        
//        [self courseperiod123];

          term_flag=@"1";
    }
    
    
    else  if (pickerView.tag==3) {
        
        
        
        
        term.text=(NSString *)[marking_period_title objectAtIndex:row];
        // term.text=[marking_period_title objectAtIndex:[selectcustomerpicker selectedRowInComponent:0]];
        NSString *strC1 =(NSString *)[marking_period_title objectAtIndex:row];
        period123 = [marking_period_id objectAtIndex:[marking_period_title indexOfObjectIdenticalTo:strC1]];
        term_flag=@"1";
//        NSLog(@"-------%@",period123);
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//        [DEF setObject:period123 forKey:@"period"];
//        
//        
//        NSLog(@"strterm---%@",str_term1);
//        flag123=@"1";
//        [self dropdowndataterm];
//        
//        [self currentsubject];
//        [self currentcourse];
//       
//        [self courseperiod123];
    }
    
    
    else  if (pickerView.tag==4) {
        
        
        
        
        
        subject.text=(NSString *)[subject_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[subject_title objectAtIndex:row];
        sub123 = [subject_id objectAtIndex:[subject_title indexOfObjectIdenticalTo:strC1]];
//        
//        NSLog(@"-------%@",sub123);
//        
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        //      [course_ary removeAllObjects];
//        //      [course_title removeAllObjects];
//        //      [course_id removeAllObjects];
//        
//        NSLog(@"course title----%@",course_title);
//        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//        [DEF setObject:sub123 forKey:@"sub"];
//       // school_sub_p=[DEF objectForKey:@"sub"];
//        
//        flag123=@"1";
//        [self dropdowndatasub];
//       // [self dropdowndatacourse];
//       [self currentcourse];
//    
//        [self courseperiod123];
//      // [self courseperiodname];
        
        sub_flag=@"1";
        
    }
    
    else  if (pickerView.tag==5) {
        
        
        
        
        
        course.text=(NSString *)[course_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_title objectAtIndex:row];
        cou123 = [course_id objectAtIndex:[course_title indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"-------%@",cou123);
        c_flag=@"1";
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//        [DEF setObject:cou123 forKey:@"course"];
//       
//        
//        flag123=@"1";
//        [self dropdowndatacourse];
//           [self courseperiod123];
        
    }
    
    
    else  if (pickerView.tag==6) {
        
        
        
        
        
        coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
         coperiod=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
       coperiod_user=[ca_cp_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSLog(@"course period id------%@",course_period_ary);
        NSLog(@"-------%@",coperiod);
     cp_flag=@"1";

    }
    
    else  if (pickerView.tag==60) {
        
        
        
        
        
        courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
        coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
        coperiod=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
        NSLog(@"course period id1111------%@",course_period_ary);
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
    

    self.view.frame=CGRectMake(0, 0, _superV.frame.size.width - 50, _superV.frame.size.height);
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
    [self currentschool];
    [self currentschoolyear];
    [self term1];
    [self currentsubject];
    [self currentcourse];
    [self courseperiod123];
  
    [self courseperiodname];
    
     [self alldata1];
    
    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    _view_term.layer.borderWidth = 1.0f;
    _view_subject.layer.borderWidth = 1.0f;
    _view_schoolyear.layer.borderWidth = 1.0f;
    _view_currentSchool.layer.borderWidth = 1.0f;
    _view_courseperiod.layer.borderWidth = 1.0f;
    _view_course.layer.borderWidth = 1.0f;
    
    
    
    _view_courseperiod.clipsToBounds = YES;
    _view_course.clipsToBounds = YES;
    _view_currentSchool.clipsToBounds = YES;
    _view_schoolyear.clipsToBounds = YES;
    _view_subject.clipsToBounds = YES;
    _view_term.clipsToBounds = YES;
    
    
    _view_course.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_courseperiod.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_currentSchool.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_schoolyear.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_subject.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_term.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
   

    [self setcourseperiod];
    [self setschoolname];
}
- (void)setschoolname
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray * course_period_title_2,* course_period_id_2;
    if (appDelegate.dic) {
        
        NSMutableArray * course_temp_arr = [[NSMutableArray alloc]init];
        course_temp_arr = [[appDelegate.dic objectForKey:@"course_period_list"]mutableCopy];
        
        if ([course_temp_arr count]>0) {
            course_period_title_2= [[NSMutableArray alloc] init];
            course_period_id_2 = [[NSMutableArray alloc] init];
            for (int i = 0; i<[course_temp_arr count]; i++) {
                NSDictionary *dic15 = [course_temp_arr objectAtIndex:i];
                [course_period_title_2  addObject:[dic15 objectForKey:@"title"]];
                [course_period_id_2 addObject:[dic15 objectForKey:@"cpv_id"]];
            }
            
            NSLog(@"222222222222222 %@",course_period_title);
            //[selectcustomerpicker reloadAllComponents];
            
        }
        else {
            NSLog(@"No  list");
        }
        
        NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
        NSInteger indexofcpv = [course_period_id_2 indexOfObject:cpv_id1];
        //[self setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@",[course_period_title objectAtIndex:indexofcpv]]];
        coursePeriod.text = [NSString stringWithFormat:@"%@",[course_period_title_2 objectAtIndex:indexofcpv]];
        
    }
    
}


- (void)setcourseperiod
{
     AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray * course_period_title_2,* course_period_id_2;
    if (appDelegate.dic) {
        
        NSMutableArray * course_temp_arr = [[NSMutableArray alloc]init];
        course_temp_arr = [[appDelegate.dic objectForKey:@"course_period_list"]mutableCopy];
        
        if ([course_temp_arr count]>0) {
             course_period_title_2= [[NSMutableArray alloc] init];
             course_period_id_2 = [[NSMutableArray alloc] init];
            for (int i = 0; i<[course_temp_arr count]; i++) {
                NSDictionary *dic15 = [course_temp_arr objectAtIndex:i];
                [course_period_title_2  addObject:[dic15 objectForKey:@"title"]];
                [course_period_id_2 addObject:[dic15 objectForKey:@"cpv_id"]];
            }
            
            NSLog(@"222222222222222 %@",course_period_title);
            //[selectcustomerpicker reloadAllComponents];
            
        }
        else {
            NSLog(@"No  list");
        }
        
        NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
        NSInteger indexofcpv = [course_period_id_2 indexOfObject:cpv_id1];
        //[self setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@",[course_period_title objectAtIndex:indexofcpv]]];
        coursePeriod.text = [NSString stringWithFormat:@"%@",[course_period_title_2 objectAtIndex:indexofcpv]];
        
    }

}


-(void)viewDidAppear:(BOOL)animated
{
    
}


#pragma MARK SCHOOL
-(void)dropdowndata
{
    
    
  //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
  
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin;
    if ([flag123 isEqualToString:@"1"]) {
        
       // http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_school_dropdown.php?school_id=1&staff_id=2
        str_checklogin=[NSString stringWithFormat:@"/manage_school_dropdown.php?school_id=%@&staff_id=%@",school_id1,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        
          str_checklogin=[NSString stringWithFormat:@"/manage_school_dropdown.php?school_id=%@&staff_id=%@",school_id1,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
      
        
    }
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
        
        dic= (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
          
            school_year1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"SYEAR"]];
           
            
            
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:school_year1 forKey:@"school_year"];
            
            school_year=[[dictionary1 objectForKey:@"Schoolyear_list"]mutableCopy];
            
            if ([school_year count]>0) {
                school_year_title = [[NSMutableArray alloc] init];
                school_year_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[school_year count]; i++) {
                    NSDictionary *dic15 = [school_year objectAtIndex:i];
                    [school_year_title  addObject:[dic15 objectForKey:@"title"]];
                    [school_year_id addObject:[dic15 objectForKey:@"start_date"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            
            NSMutableDictionary *S_YEAR=[[NSMutableDictionary alloc]init];
            NSString *strt=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"SYEAR"]];
            NSLog(@"%@",strt);
            
            
            for (int i=0; i<[school_year count]; i++) {
                
                
                if ([strt isEqual:[[school_year  objectAtIndex:i]objectForKey:@"start_date"]]) {
                    S_YEAR=[school_year objectAtIndex:i];
                    b_s=true;
                    break;
                    

                    
                }
                
                else
                {
                    
                    
                   // schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
                    
                }
                
            }
            
            
            if (b_s==true) {
                schoolYear.text=[NSString stringWithFormat:@"%@",[S_YEAR objectForKey:@"title"]];
                school_year1=[NSString stringWithFormat:@"%@",[S_YEAR objectForKey:@"start_date"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:school_year1 forKey:@"school_year"];

                
            }
            else
            {
                
             schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
                school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"start_date"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:school_year1 forKey:@"school_year"];
            }
            
            
        }
        
        
        
        
        else
        {
           // NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
       //     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         //   [alert show];
            
            
            
        }
        [self dropdowndatayear];
        [self dropdowndataterm];
        [self dropdowndatasub];
        [self dropdowndatacourse];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}
#pragma mark-marking period term
-(void)dropdowndatayear
{
 //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin;
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_syear_dropdown.php?school_id=1&syear=2015&staff_id=2

    if ([flag123 isEqualToString:@"1"]) {
        // NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        
        str_checklogin=[NSString stringWithFormat:@"/manage_syear_dropdown.php?school_id=%@&syear=%@&staff_id=%@",
school_id1,school_year12,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_syear_dropdown.php?school_id=%@&syear=%@&staff_id=%@",
                        school_id1,school_year12,staff_id_d];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
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
        dic= (NSMutableDictionary *)responseObject;
         AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        // appDelegate.dic=dic;
        appDelegate.dic_term=dictionary1;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            str_term1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserMP"]];
            
            NSLog(@"usermp---%@",str_term1);
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:str_term1 forKey:@"period"];
           
            marking_period_type=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"marking_period_type"]];
          
            [df setObject:marking_period_type forKey:@"tanay"];
            
            ////tERM/////
            [marking_period removeAllObjects];
            [marking_period_title removeAllObjects];
            [marking_period_id removeAllObjects];
            marking_period=[[dictionary1 objectForKey:@"marking_period_list"]mutableCopy];
            
            if ([marking_period count]>0) {
                marking_period_title= [[NSMutableArray alloc] init];
                marking_period_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[marking_period count]; i++) {
                    NSDictionary *dic15 = [marking_period objectAtIndex:i];
                    [marking_period_title  addObject:[dic15 objectForKey:@"title"]];
                    [marking_period_id addObject:[dic15 objectForKey:@"id"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
           
            NSMutableDictionary *TERM=[[NSMutableDictionary alloc]init];
            NSString *st_T=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserMP"]];
            
            NSLog(@"course ary----%@",marking_period);
            for (int i=0; i<[marking_period count]; i++) {
                
                
                if ([st_T isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"id"]]) {
                    TERM=[marking_period objectAtIndex:i];
                    
                    dt=true;
                    break;
                  //  term.text=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"title"]];
                    
                }
                
                else
                {
                   
                    
                    
                  //  term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
                    
                }
                
            }
            
            
            if (dt==true) {
             
                
              
                  term.text=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"title"]];
                str_term1=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"id"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:str_term1 forKey:@"period"];

            }
            
            else
            {
                 term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
                str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"id"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:str_term1 forKey:@"period"];

            }
        }
        
        
        
        else
        {
           // NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
         //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         //   [alert show];
            
            
            
        }
        
        [self dropdowndataterm];
        [self dropdowndatasub];
        [self dropdowndatacourse];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}

-(void)dropdowndataterm
{
    
    
   // http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_marking_period_dropdown.php?school_id=1&syear=2015&staff_id=2&mp_id=16
    
 //   marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
 //   term123=[df objectForKey:@"period"];
  str_term1=[df objectForKey:@"period"];
    marking_period_type=[df objectForKey:@"tanay"];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin;
    if ([flag123 isEqualToString:@"1"]) {
        //   NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        //        school_id=[df objectForKey:@"school"];
        //        school_year=[df objectForKey:@"year"];
        
        
        
        
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_marking_period_dropdown.php?school_id=%@&syear=%@&staff_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
       
        
    }
    
    else
    {
        
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_marking_period_dropdown.php?school_id=%@&syear=%@&staff_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
        
        
    }
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
      
       
        dic= (NSMutableDictionary *)responseObject;
           AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.dic_sub=dictionary1;

        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
          
            str_sub1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserSubject"]];
          
            
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:str_sub1 forKey:@"sub"];
            
          

                       ///SUBJECT////
            [subject_ary removeAllObjects];
            [subject_title removeAllObjects];
            [subject_id removeAllObjects];
            subject_ary=[[dictionary1 objectForKey:@"subject_list"]mutableCopy];
            
            if ([subject_ary count]>0) {
                subject_title = [[NSMutableArray alloc] init];
                subject_id= [[NSMutableArray alloc] init];
                for (int i = 0; i<[subject_ary count]; i++) {
                    NSDictionary *dic15 = [subject_ary objectAtIndex:i];
                    [subject_title  addObject:[dic15 objectForKey:@"title"]];
                    [subject_id addObject:[dic15 objectForKey:@"id"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            NSMutableDictionary *SUB=[[NSMutableDictionary alloc]init];
            NSString *strt_SUB=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserSubject"]];
            
            
            NSLog(@"course ary----%@",subject_ary);
            for (int i=0; i<[subject_ary count]; i++) {
                
                
                if ([strt_SUB isEqual:[[subject_ary  objectAtIndex:i]objectForKey:@"id"]]) {
                    SUB=[subject_ary objectAtIndex:i];
                    b_sub=true;
                    break;
                    
//                    subject.text=[NSString stringWithFormat:@"%@",[SUB objectForKey:@"title"]];
//                    str_sub1=[NSString stringWithFormat:@"%@",[SUB objectForKey:@"id"]];
//                    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//                    [DEF setObject:str_sub1 forKey:@"sub"];
                }
                
                else
                {
                    
//                    subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
//                    str_sub1=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"id"]];
//
//                    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//                    [DEF setObject:str_sub1 forKey:@"sub"];
                    
                }
            }
            
                if (b_sub==true) {
                    subject.text=[NSString stringWithFormat:@"%@",[SUB objectForKey:@"title"]];
                    str_sub1=[NSString stringWithFormat:@"%@",[SUB objectForKey:@"id"]];
                    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
                    [DEF setObject:str_sub1 forKey:@"sub"];
                }
                
                else
                {
                    subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
                    str_sub1=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"id"]];
                    
                    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
                    [DEF setObject:str_sub1 forKey:@"sub"];
                    
                }
                
            //}
            
            [self dropdowndatasub];
            [self dropdowndatacourse];
            
            
        }
        
        
        
        
        else
        {
          //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
          //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
          //  [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}



-(void)dropdowndatasub
{
 //   http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_course_dropdown.php?school_id=1&syear=2015&staff_id=2&course_id=17
 //   NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
   
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
    str_term1=[df objectForKey:@"period"];
    marking_period_type=[df objectForKey:@"tanay"];
  //  NSString *term123=[df objectForKey:@"period"];
     str_sub1=[df objectForKey:@"sub"];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString*str_checklogin;
    
    if ([flag123 isEqualToString:@"1"]) {
        //  NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        //  school_id=[df objectForKey:@"school"];
        //  school_year=[df objectForKey:@"year"];
        
        //  str_term1=[df objectForKey:@"period"];
        
        str_checklogin=[NSString stringWithFormat:@"/manage_subject_dropdown.php?school_id=%@&syear=%@&staff_id=%@&subject_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_sub1,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        str_checklogin=[NSString stringWithFormat:@"/manage_subject_dropdown.php?school_id=%@&syear=%@&staff_id=%@&subject_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,str_sub1,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
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
                NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
         
            str_cou1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserCourse"]];
            str_cp1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserCoursePeriod"]];
            NSLog(@"str____course--%@",str_cou1);
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:str_cou1 forKey:@"course"];
            
            ////COURSE///
            
            [course_ary removeAllObjects];
            [course_title removeAllObjects];
            [course_id removeAllObjects];
            course_ary=[[dictionary1 objectForKey:@"course_list"]mutableCopy];
            
            if ([course_ary count]>0) {
                course_title = [[NSMutableArray alloc] init];
                course_id= [[NSMutableArray alloc] init];
                for (int i = 0; i<[course_ary count]; i++) {
                    NSDictionary *dic15 = [course_ary objectAtIndex:i];
                    [course_title  addObject:[dic15 objectForKey:@"title"]];
                    [course_id addObject:[dic15 objectForKey:@"id"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            NSMutableDictionary *COURSE=[[NSMutableDictionary alloc]init];
            NSString *strt_C=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"UserCourse"]];
            
            
            NSLog(@"course ary----%@",course_ary);
            for (int i=0; i<[course_ary count]; i++) {
                
                
                if ([strt_C isEqual:[[course_ary  objectAtIndex:i]objectForKey:@"id"]]) {
                    COURSE=[course_ary objectAtIndex:i];
                    
                    b_c=true;
                    break;
                    
//                    course.text=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"title"]];
//                    str_cou1=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"id"]];
//                    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//                    [DEF setObject:str_cou1 forKey:@"course"];
                }
                
                else
                {
//                    course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
//                    str_cou1=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"id"]];
//                    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
//                    [DEF setObject:str_cou1 forKey:@"course"];
                }
                
            }
            
            
            if (b_c==true) {
                course.text=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"title"]];
                str_cou1=[NSString stringWithFormat:@"%@",[COURSE objectForKey:@"id"]];
                NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
                [DEF setObject:str_cou1 forKey:@"course"];
            }
            
            else
            {
                course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
                str_cou1=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"id"]];
                NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
                [DEF setObject:str_cou1 forKey:@"course"];
                
            
            }

            
            
        }
        
        
        
        
        else
        {
           // NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
         //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         //   [alert show];
            
            
            
        }
        [self dropdowndatacourse];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}

-(void)dropdowndatacourse
{
  //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_course_dropdown.php?school_id=1&syear=2015&staff_id=2&course_id=17
  //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *school_id1=[df objectForKey:@"school_id1"];
    NSString *school_year12=[df objectForKey:@"school_year"];
   NSString *cou123456=[df objectForKey:@"course"];
    str_term1=[df objectForKey:@"period"];
    marking_period_type=[df objectForKey:@"tanay"];
    NSLog(@"courename-----%@",course);
    [course_period_ary removeAllObjects];
    [course_period_title removeAllObjects];
    [course_period_id removeAllObjects];
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin;
    if ([flag123 isEqualToString:@"1"]) {
        
        
        
        str_checklogin=[NSString stringWithFormat:@"/manage_course_dropdown.php?school_id=%@&syear=%@&staff_id=%@&course_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,cou123456,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    else
    {
        
         str_checklogin=[NSString stringWithFormat:@"/manage_course_dropdown.php?school_id=%@&syear=%@&staff_id=%@&course_id=%@&mp_id=%@&mp_type=%@",school_id1,school_year12,staff_id_d,cou123456,str_term1,marking_period_type];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
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
       // dictionary1 = (NSMutableDictionary *)responseObject;
    //    dic= (NSMutableDictionary *)responseObject;
        dictionary1=[responseObject mutableCopy];
        [dictionary1 setObject:school_id1 forKey:@"SCHOOL_ID"];
          [dictionary1 setObject:school_year12 forKey:@"SYEAR"];
          [dictionary1 setObject:school_year forKey:@"Schoolyear_list"];
        [dictionary1 setObject:str_term1 forKey:@"UserMP"];
           [dictionary1 setObject:str_sub1 forKey:@"UserSubject"];
        [dictionary1 setObject:marking_period_type forKey:@"marking_period_type"];
          [dictionary1 setObject:subject_ary forKey:@"subject_list"];
          [dictionary1 setObject:  marking_period forKey:@"marking_period_list"];
        
         [dictionary1 setObject:cou123456   forKey:@"UserCourse"];
          [dictionary1 setObject:course_ary   forKey:@"course_list"];
                  [dictionary1 setObject:c_school   forKey:@"School_list"];
      

        
       

        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       appDelegate.dic=dictionary1;
      
        NSLog(@"value is-dddddd------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            
            
          
            
            /////COURSE pERIOD//
                    course_period_ary=[[dictionary1 objectForKey:@"course_period_list"]mutableCopy];
            
            if ([course_period_ary count]>0) {
                course_period_title= [[NSMutableArray alloc] init];
                course_period_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[course_period_ary count]; i++) {
                    NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
                    [course_period_title  addObject:[dic15 objectForKey:@"title"]];
                    [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
                    
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            NSMutableDictionary *C_PERIOD=[[NSMutableDictionary alloc]init];
            NSString *strt_P=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserCoursePeriod"]];
            
          //  NSLog(@"course ary----%@",course_period_ary);
            for (int i=0; i<[course_period_ary count]; i++) {
                
                
                if ([strt_P isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
                    C_PERIOD=[course_period_ary objectAtIndex:i];
                    
                    b_cp=true;
                    break;
//                    coursePeriod.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
//                    courseperiodName.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
//                    str_cp1=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"cpv_id"]];
                    
                }
                
                
                else
                {
                    
                    
//                    coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//                    courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
//                    str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
                }
                
            }
                if (b_cp==true) {
                    coursePeriod.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
                    courseperiodName.text=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"title"]];
                    str_cp1=[NSString stringWithFormat:@"%@",[C_PERIOD objectForKey:@"cpv_id"]];
                }
                
                else
                {
                
                    coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
                    courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
                    str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
                    
                
                }
                
                
                
       //     }
            
            
            
            
        }
        
        
        
        
        else
        {
           // NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
         //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         //   [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //   transparentView.hidden=NO;
        NSLog(@"ok----");
        //  [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
}


-(void)termClicked1

{
    
    
    if ([term_flag isEqualToString:@"1"]) {
        
    
    NSLog(@"Done Clicked");
    NSLog(@"-------%@",period123);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
    [DEF setObject:period123 forKey:@"period"];
    
    
    NSLog(@"strterm---%@",str_term1);
    flag123=@"1";
    [self dropdowndataterm];
    
    [self currentsubject];
    [self currentcourse];
    
    [self courseperiod123];
        term_flag=@"0";
    }
    
    
    else
    {
        NSLog(@"okkkkkk");
        
        
    
    }
    
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}
-(void)courseClicked1

{
    
      if ([c_flag isEqualToString:@"1"]) {
    NSLog(@"Done Clicked");
    NSLog(@"-------%@",cou123);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
    [DEF setObject:cou123 forKey:@"course"];
    
    
    flag123=@"1";
    [self dropdowndatacourse];
    [self courseperiod123];
          c_flag=@"0";
      }
    
    else
    {
    
    }
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}


-(void)subClicked1

{
      if ([sub_flag isEqualToString:@"1"]) {
    NSLog(@"Done Clicked");
    
    NSLog(@"-------%@",sub123);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //      [course_ary removeAllObjects];
    //      [course_title removeAllObjects];
    //      [course_id removeAllObjects];
    
    NSLog(@"course title----%@",course_title);
    NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
    [DEF setObject:sub123 forKey:@"sub"];
    // school_sub_p=[DEF objectForKey:@"sub"];
    
    flag123=@"1";
    [self dropdowndatasub];
    // [self dropdowndatacourse];
    [self currentcourse];
    
    [self courseperiod123];
    // [self courseperiodname];
          sub_flag=@"0";
      }
    
    else
    {
    
    }
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}

-(void)yearClicked1

{
      if ([term_flag isEqualToString:@"1"]) {
    NSLog(@"Done Clicked");
    
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
            [df setObject:school_year_p forKey:@"school_year"];
            flag123=@"1";
            [self dropdowndatayear];
    
              [self term1];
            [self currentsubject];
            [self currentcourse];
            
            [self courseperiod123];
          term_flag=@"0";
      }
    else
    {
    
    }

    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}
-(void)schoolClicked1

{  if ([s_flag isEqualToString:@"1"]) {
    NSLog(@"Done Clicked");
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self dropdowndata];
    
   
    [self term1];
    [self currentsubject];
    [self currentcourse];
    
    [self courseperiod123];
    s_flag=@"0";

}
    else
    {
           }
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}



-(void)pickerDoneClicked1

{
    if ([cp_flag isEqualToString:@"1"]) {
        NSLog(@"Done Clicked");
        
        NSLog(@"Done Clicked");
        NSLog(@"Done Clicked");
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSLog(@"---------%@",appDelegate.dic);
        NSLog(@"-------%@",coperiod);
        
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        NSString *school_id1=[df objectForKey:@"school_id1"];
        NSString *school_year12=[df objectForKey:@"school_year"];
        NSString *cou123456=[df objectForKey:@"course"];
        NSLog(@"courename-----%@",course);
        [course_period_ary removeAllObjects];
        [course_period_title removeAllObjects];
        [course_period_id removeAllObjects];
        
        
        ip_url *obj123=[[ip_url alloc]init];
        NSString *str123=[obj123 ipurl];
        NSString*str_checklogin;
        if ([flag123 isEqualToString:@"1"]) {
            
            
            
            str_checklogin=[NSString stringWithFormat:@"/manage_course_dropdown.php?school_id=%@&syear=%@&staff_id=%@&course_id=%@",school_id1,school_year12,staff_id_d,cou123456];
            NSLog(@"kkkkkkkkkkk%@",str_checklogin);
            cp_flag=@"0";
        }
        else
        {
            
            str_checklogin=[NSString stringWithFormat:@"/manage_course_dropdown.php?school_id=%@&syear=%@&staff_id=%@&course_id=%@",school_id1,school_year12,staff_id_d,cou123456];
            NSLog(@"kkkkkkkkkkk%@",str_checklogin);
            
        }
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
            // dictionary1 = (NSMutableDictionary *)responseObject;
            //    dic= (NSMutableDictionary *)responseObject;
            dictionary1=[responseObject mutableCopy];
            [dictionary1 setObject:school_id1 forKey:@"SCHOOL_ID"];
            [dictionary1 setObject:school_year12 forKey:@"SYEAR"];
            [dictionary1 setObject:school_year forKey:@"Schoolyear_list"];
            [dictionary1 setObject:str_term1 forKey:@"UserMP"];
            [dictionary1 setObject:str_sub1 forKey:@"UserSubject"];
            [dictionary1 setObject:marking_period_type forKey:@"marking_period_type"];
            [dictionary1 setObject:subject_ary forKey:@"subject_list"];
            [dictionary1 setObject:  marking_period forKey:@"marking_period_list"];
            
            [dictionary1 setObject:cou123456   forKey:@"UserCourse"];
            [dictionary1 setObject:course_ary   forKey:@"course_list"];
            [dictionary1 setObject:c_school   forKey:@"School_list"];
            
            [dictionary1 setObject:coperiod forKey:@"UserCoursePeriodVar"];
            
             [dictionary1 setObject:coperiod_user forKey:@"UserCoursePeriod"];
            
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            appDelegate.dic=dictionary1;
              usercourseperiod_var=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserCoursePeriodVar"]];
            NSLog(@"value is-dddddd------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
            //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
            
            //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
            NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
            NSLog(@"str_123-----%@",str_123);
            if([str_123 isEqualToString:@"1"])
                
                
                
            {
                
                
                
                
                
                
                
                
                
            }
            
            
            
            
            else
            {
             //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
                
             //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
              //  [alert show];
                
                
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            //   transparentView.hidden=NO;
            NSLog(@"ok----");
            //  [self.view addSubview:transparentView];
        }];
        
        
        [operation start];
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        
        
        
        
    }
    
    else
    {
        
    }
    
    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
}


-(IBAction)open:(UIView *)superview  {
    //self.view.frame=CGRectMake(0, 0, _superV.frame.size.width - 50, _superV.frame.size.height);
    if ([thisparentName isEqualToString:@"teacherdashboard"]) {
         coursePeriod.text = [superteacherdashobject getCourseperiodtextfielddata];
    }
    
    if ([thisparentName isEqualToString:@"postfinalgrades"])  {
        coursePeriod.text = [superpostfinalgradesobject getCourseperiodtextfielddata];
    }
    if ([thisparentName isEqualToString:@"coursemanager"])  {
        coursePeriod.text = [supercoursemanagersubjectobject getCourseperiodtextfielddata];
        
    }
    if ([thisparentName isEqualToString:@"mpperiod"])  {
      currentSchool.text = [supermp_period getCourseperiodtextfielddata];
        
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

- (void)setcourseperiodofparent
{
    [superpostfinalgradesobject setCourseperiodtextfielddata:coursePeriod.text];
}
- (IBAction)close:(id)sender {
    
     //  [superobject fetchdata];
//[superobject showdata];
    if ([thisparentName isEqualToString:@"assignment"]) {
       // coursePeriod.text = [superteacherdashobject getCourseperiodtextfielddata];
       
        [superassignmentobject callgetdata];
         [superassignmentobject tablereload];
    }
    if ([thisparentName isEqualToString:@"coursemanager"])  {
        [supercoursemanagersubjectobject accessingtheAppDelegateDictionary];
        
    }
    
    if ([thisparentName isEqualToString:@"teacherdashboard"]) {
        [superteacherdashobject setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", coursePeriod.text]];//setdata
    }
    if ([thisparentName isEqualToString:@"mpperiod"])  {
        
        
        NSString *str_c=[NSString stringWithFormat:@"%@", currentSchool.text];
        NSLog(@"-----------------%@",str_c);
        [supermp_period setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", str_c]];//setdata
        
    }

    
  
   // [self setcourseperiodofparent];
  //  [superpostfinalgradesobject loaddata];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.3f];
    [self.view setCenter:CGPointMake(-slidewidth, slideheight)];
    [view_inactive setAlpha:0.0f];
    //[newView removeFromSuperview];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(removetheview)];
    [UIView commitAnimations];

    [currentSchool resignFirstResponder];
    [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
    [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    //[self.view removeFromSuperview];
}
-(void)removetheview
{
    [self.view removeFromSuperview];
}
-(void)alldata1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  


     marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:marking_period_type forKey:@"tanay"];
    marking_period=[[appDelegate.dic_term objectForKey:@"marking_period_list"]mutableCopy];
    
    if ([marking_period count]>0) {
        marking_period_title= [[NSMutableArray alloc] init];
        marking_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[marking_period count]; i++) {
            NSDictionary *dic15 = [marking_period objectAtIndex:i];
            [marking_period_title  addObject:[dic15 objectForKey:@"title"]];
            [marking_period_id addObject:[dic15 objectForKey:@"id"]];
            
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
            
            //   term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
            //  str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
            
            t=true;
            break;
            
        }
        
        else
        {
            
            //    term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
            //  str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
            
            
            
        }
        
        
        
        
    }
    
    
    if (t==true) {
        
        term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"title"]];
        str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"id"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_term1 forKey:@"period"];
        
        
    }
    
    else
    {
        term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"title"]];
        str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"id"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_term1 forKey:@"period"];
    }
    
    
    
    
    
    
    
    
    
    
    c_school=[[dic objectForKey:@"School_list"]mutableCopy];
    
    if ([c_school count]>0) {
        c_school_title = [[NSMutableArray alloc] init];
        c_school_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[c_school count]; i++) {
            NSDictionary *dic15 = [c_school objectAtIndex:i];
            [c_school_title addObject:[dic15 objectForKey:@"title"]];
            [c_school_id addObject:[dic15 objectForKey:@"id"]];
            NSLog(@"dffg %@",c_school_title);
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    
    NSLog(@"c_school---%@",c_school);
    
    NSMutableDictionary *dic16q=[[NSMutableDictionary alloc]init];
    NSString *strtq=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SCHOOL_ID"]];
    
    NSLog(@"course ary----%@",c_school);
    for (int i=0; i<[c_school count]; i++) {
        
        
        if ([strtq isEqual:[[c_school objectAtIndex:i]objectForKey:@"id"]]) {
            dic16q=[c_school objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16q);
            
            //  currentSchool.text=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"title"]];
            
            // school_id=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"id"]];
            
            s=true;
            break;
        }
        
        else
        {
            
            //  currentSchool.text=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"title" ]];
            // school_id=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"id"]];
        }
        
    }
    
    if (s==true) {
        currentSchool.text=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"title"]];
        
        school_id=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"id"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_id forKey:@"school_id1"];
      
    }
    else
    {
        
        currentSchool.text=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"title" ]];
        school_id=[NSString stringWithFormat:@"%@",[[c_school objectAtIndex:0]objectForKey:@"id"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_id forKey:@"school_id1"];
        
    }
    
    
    
    school_year=[[dic objectForKey:@"Schoolyear_list"]mutableCopy];
    
    if ([school_year count]>0) {
        school_year_title = [[NSMutableArray alloc] init];
        school_year_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[school_year count]; i++) {
            NSDictionary *dic15 = [school_year objectAtIndex:i];
            [school_year_title  addObject:[dic15 objectForKey:@"title"]];
            [school_year_id addObject:[dic15 objectForKey:@"start_date"]];
            
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
        
        
        if ([strt7 isEqual:[[school_year  objectAtIndex:i]objectForKey:@"start_date"]]) {
            dic167=[school_year objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16);
            
            //  schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"title"]];
            // school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"start_date"]];
            y=true;
            break;
            
            
        }
        
        else
        {
            
            
            //  schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
            //  school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"start_date"]];
        }
        
    }
    
    if (y==true) {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"title"]];
        school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"start_date"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year1 forKey:@"school_year"];
    }
    
    else
    {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"title"]];
        school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"start_date"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year1 forKey:@"school_year"];
    }
    
    
    //NSMutableDictionary *dic_t=appDelegate.dic_term;
  //  NSLog(@"dic  t---%@",dic_t);
    subject_ary=[[dic objectForKey:@"subject_list"]mutableCopy];
    
    if ([subject_ary count]>0) {
        subject_title = [[NSMutableArray alloc] init];
        subject_id= [[NSMutableArray alloc] init];
        for (int i = 0; i<[subject_ary count]; i++) {
            NSDictionary *dic155 = [subject_ary objectAtIndex:i];
            [subject_title  addObject:[dic155 objectForKey:@"title"]];
            [subject_id addObject:[dic155 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic1665=[[NSMutableDictionary alloc]init];
    NSString *strt_s5=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserSubject"]];
    
    
    NSLog(@"course ary----%@",subject_ary);
    for (int i=0; i<[subject_ary count]; i++) {
        
        
        if ([strt_s5 isEqual:[[subject_ary  objectAtIndex:i]objectForKey:@"id"]]) {
            dic1665=[subject_ary objectAtIndex:i];
            
            
            //  subject.text=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"title"]];
            //  str_sub1=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"id"]];
            su=true;
            break;
        }
        
        else
        {
            
            //subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
            // str_sub1=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"id"]];
            
        }
        
    }
    
    if (su==true) {
        subject.text=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"title"]];
        str_sub1=[NSString stringWithFormat:@"%@",[dic1665 objectForKey:@"id"]];
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:str_sub1 forKey:@"sub"];
    }
    
    else
    {
        
        
        subject.text=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"title"]];
        str_sub1=[NSString stringWithFormat:@"%@",[[subject_ary objectAtIndex:0]objectForKey:@"id"]];
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:str_sub1 forKey:@"sub"];
    }
    
    
    
    
    
    
    course_ary=[[dic objectForKey:@"course_list"]mutableCopy];
    
    if ([course_ary count]>0) {
        course_title = [[NSMutableArray alloc] init];
        course_id= [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_ary count]; i++) {
            NSDictionary *dic15 = [course_ary objectAtIndex:i];
            [course_title  addObject:[dic15 objectForKey:@"title"]];
            [course_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    NSMutableDictionary *dic168=[[NSMutableDictionary alloc]init];
    NSString *strt8=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCourse"]];
    NSLog(@"%@",strt);
    
    NSLog(@"course ary----%@",course_ary);
    for (int i=0; i<[course_ary count]; i++) {
        
        
        if ([strt8 isEqual:[[course_ary  objectAtIndex:i]objectForKey:@"id"]]) {
            dic168=[course_ary objectAtIndex:i];
            
            
            c_a=true;
            break;
            //   course.text=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"title"]];
            //str_cou1=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"id"]];
            
            
        }
        
        else
        {
            //  course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
            //  str_cou1=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"id"]];
        }
        
    }
    if (c_a==true) {
        
        course.text=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"title"]];
        str_cou1=[NSString stringWithFormat:@"%@",[dic168 objectForKey:@"id"]];
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:str_cou1 forKey:@"course"];
        
    }
    
    else
    {
        course.text=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"title"]];
        str_cou1=[NSString stringWithFormat:@"%@",[[course_ary objectAtIndex:0]objectForKey:@"id"]];
        NSUserDefaults *DEF=[NSUserDefaults standardUserDefaults];
        [DEF setObject:str_cou1 forKey:@"course"];

        
    }
    
    
    
    
//    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
//    
//    if ([course_period_ary count]>0) {
//        course_period_title= [[NSMutableArray alloc] init];
//        course_period_id = [[NSMutableArray alloc] init];
//        for (int i = 0; i<[course_period_ary count]; i++) {
//            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
//            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
//            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
//            
//        }
//        
//    }
//    else {
//        NSLog(@"No  list");
//    }
    
    
    
    
    
    
    _view_term.layer.borderWidth = 1.0f;
    _view_subject.layer.borderWidth = 1.0f;
    _view_schoolyear.layer.borderWidth = 1.0f;
    _view_currentSchool.layer.borderWidth = 1.0f;
    _view_courseperiod.layer.borderWidth = 1.0f;
    _view_course.layer.borderWidth = 1.0f;
  
    _view_courseperiod.clipsToBounds = YES;
    _view_course.clipsToBounds = YES;
    _view_currentSchool.clipsToBounds = YES;
    _view_schoolyear.clipsToBounds = YES;
    _view_subject.clipsToBounds = YES;
    _view_term.clipsToBounds = YES;
    
    
    
    _view_course.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_courseperiod.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_currentSchool.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_schoolyear.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_subject.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    _view_term.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
  //  _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    
    
    
    
    
    NSLog(@"dicvalue---%@",dic);
    NSMutableArray *INFO=[[NSMutableArray alloc]init];
    INFO=[dic_techinfo objectForKey:@"tech_info"];
    
    
    NSLog(@"info-------------%@",INFO);
    lbl_username.text=[NSString stringWithFormat:@"%@ %@",[[INFO objectAtIndex:0]objectForKey:@"FIRST_NAME"],[[INFO objectAtIndex:0]objectForKey:@"LAST_NAME"]];
    
    lbl_useremail.text=[NSString stringWithFormat:@"%@",[[INFO objectAtIndex:0]objectForKey:@"EMAIL"]];
    
    
    kkview.clipsToBounds=YES;
    img_profile.clipsToBounds = YES;
    //
    img_profile.layer.cornerRadius = img_profile.frame.size.height / 2;
    img_profile.layer.borderWidth = 4.0f;
    img_profile.layer.borderColor = [UIColor whiteColor].CGColor;

    
    NSString *gender12=[NSString stringWithFormat:@"%@",[[INFO objectAtIndex:0]objectForKey:@"GENDER"]];
    if ([gender12 isEqualToString:@"Female"]) {
                       img_profile.image=[UIImage imageNamed:@"female"];
        //[self.img_profile applyPhotoFrame];
        
    }
    
    else
    {
        img_profile.image=[UIImage imageNamed:@"female"];
        //img_profile.image=[UIImage imageNamed:@"male"];
        //[self.img_profile applyPhotoFrame];
        
        
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
    
    
    
    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
             [ca_cp_id addObject:[dic15 objectForKey:@"cp_id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
    
    
    NSLog(@"course ary----%@",course_period_ary);
    for (int i=0; i<[course_period_ary count]; i++) {
        
        
        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
            dic177=[course_period_ary objectAtIndex:i];
            NSLog(@"dic16---%@",dic16);
            c_ap=true;
            break;
            
        }
        
        
        else
        {
            
            
            //  coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
            //  courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
            //  str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"period_id"]];
        }
        
    }
    
    if (c_ap==true) {
        coursePeriod.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"cpv_id"]];
    }
    
    else
    {
        
        
        coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
        
        
    }
    
    
    
    
    
    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField !=courseperiodName && textField != term && textField != currentSchool && textField != schoolYear && textField != subject && textField != course) {
        [self animateTextField:coursePeriod up:YES];
    }
    
    
    if (textField ==term) {
        
        old_term=str_term1;
        
        NSLog(@"oldterm---%@",old_term);
        
        
        
    }
    if (textField==subject) {
        
        old_sub=str_sub1;
        NSLog(@"old sub------%@",old_sub);
        
    }
    
    if (textField==course) {
        
        old_co=str_cou1;
        NSLog(@"old-course%@",old_co);
    }
    
    
    if (textField==currentSchool) {
        
        old_sc=school_id;
        NSLog(@"old school---%@",old_sc);
        
    }
    
    if (textField==schoolYear) {
        
        old_year=school_year1;
        NSLog(@"old year---%@",old_year);
        
        
    }
    
    if (textField==coursePeriod) {
        
        old_cp_id=str_cp1;
        NSLog(@"old cp---%@",old_cp_id);
        
        
    }
    
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField !=courseperiodName && textField !=term && textField != currentSchool && textField != schoolYear && textField != subject && textField != course) {
        [self animateTextField:coursePeriod up:NO];
    }
    
    
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}



-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    coursePeriod.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    coursePeriod.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}





-(IBAction)ok:(id)sender
{
    NSLog(@"Ok pressed");
}

-(IBAction)logout:(id)sender
{
    NSLog(@"Logout button pressed");
  //  [self.navigationController popToRootViewControllerAnimated:YES];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"er"];
    
    if (superteacherdashobject) {
        [superteacherdashobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superattendanceobject)
    {
        [superattendanceobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supergradesobject)
    {
        [supergradesobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superassignmentobject)
    {
        [superassignmentobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supergradesassignmenttypeobject)
    {
        [supergradesassignmenttypeobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supergradesTotalobject)
    {
        [supergradesTotalobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superpostfinalgradesobject)
    {
        [superpostfinalgradesobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superschedulehomeobject)
    {
        [superschedulehomeobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superattendetailobject)
    {
        [superattendetailobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supermsg1object)
    {
        [supermsg1object.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supermessagegroupobject)
    {
        [supermessagegroupobject.navigationController popToRootViewControllerAnimated:YES];
    }
    else if (supermp_period)
    {
        [supermp_period.navigationController popToRootViewControllerAnimated:YES];
    }

    
}







@end
