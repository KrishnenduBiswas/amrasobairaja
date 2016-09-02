//
//  S_slideViewController.m
//  openSiS
//
//  Created by os4ed on 3/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_slideViewController.h"
#import "AppDelegate.h"
#import "pdashboardViewController.h"
#import "MBProgressHUD.h"
#import "UIImageView+PhotoFrame.h"
#import "ip_url.h"
#import "Grade_s_ViewController.h"
#import "Schedule_s_ViewController.h"
#import "SettingViewController.h"
#import "SchoolinfoViewController.h"
#import "S_ReportViewController.h"

#import "sinfoViewController.h"

@interface P_slideViewController ()<UIGestureRecognizerDelegate, UIPickerViewDataSource,UIPickerViewDelegate >
{
 NSString    *staff_id_d;
    
    pdashboardViewController *superstudentdash;
    Grade_s_ViewController *superstudentgrade;
    Schedule_s_ViewController *superschdule;
    
    SettingViewController *supersettiing;
    
    SchoolinfoViewController  *superinfo;
    S_ReportViewController *superreport;
    
    
     NSString *thisparentName;
    NSMutableDictionary *dic,*dic_techinfo;
     UIView *view_inactive;
    NSString *school_year1;
    NSString *courseperiodnamestr;

}

@property (strong, nonatomic) IBOutlet UIView *view_schoolyear,*s_namevw;

@property (strong, nonatomic) IBOutlet UIView *view_term;

@property (strong, nonatomic) IBOutlet UITextField *schoolYear;
@property (strong, nonatomic) IBOutlet UITextField *term;

@property (strong, nonatomic) UIView *superV;



@end

@implementation P_slideViewController
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
    if ([thisparentName isEqualToString:@"pdashboard"]) {
       superstudentdash = [[pdashboardViewController alloc]init];
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
        superinfo=[[S_ReportViewController alloc]init];
        superinfo=parent;
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
-(void)studentname
{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=4;
    student_name.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(stdkeyreturn)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    student_name.inputAccessoryView = mypickerToolbar;
}

-(void)stdkeyreturn
{

    
    if ([std_flag isEqualToString:@"1"]) {
        
        AppDelegate *appDeledate=(AppDelegate *)[[UIApplication sharedApplication]delegate ];
         NSString  *    s_year=[NSString stringWithFormat:@"%@",[appDeledate.dic objectForKey:@"SYEAR"]];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:std_id forKey:@"stdid"];
          [df setObject:s_year forKey:@"school_year"];
        flag123=@"1";
        
        [self dropdowndatayear];
        [self term1];
        
        std_flag=@"0";
    }
    else
    {
        
    }

    
   
    [student_name resignFirstResponder];


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
    
    
    else
    {
    
        return ary_stdname.count;
    
    
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
    
    else
    {
    
    
        return [ary_stdname objectAtIndex:row];
    
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
    
    
    
    
    
  else if (pickerView.tag==4)
  {
      
        
        
        
       student_name.text=(NSString *)[ary_stdname objectAtIndex:row];
        
        NSString *strC1 =(NSString *)[ary_stdname objectAtIndex:row];
       std_id = [ary_stdid objectAtIndex:[ary_stdname indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"-------%@",std_id);
        
        std_flag=@"1";
      
        
       // term_flag=@"1";
    }
    

    
    
       
}

-(void)setrect:(UIView *)superview
{
    _superV = superview;
    
}
- (void)viewDidLoad
{
    
    ary_stdname=[[NSMutableArray alloc]init ];
    
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
    [self studentname];
    
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
    
    stu_nameview.layer.borderWidth=1.0f;
    
    
        currentSchool.clipsToBounds = YES;
    view_schoolyear.clipsToBounds = YES;
       view_term.clipsToBounds = YES;
    
    
   
    currentSchool.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    view_schoolyear.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
   
    view_term.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    
    
    stu_nameview.layer.borderColor = [[UIColor colorWithRed:0.271f green:0.600f blue:0.804f alpha:1.00f]CGColor];
    
    
    //[self setcourseperiod];
    
}

-(IBAction)open:(UIView *)superview  {
   
    if ([thisparentName isEqualToString:@"pdashboard"])
    {
        student_name.text = [superstudentdash getCourseperiodtextfielddata];
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
    
    if ([thisparentName isEqualToString:@"pdashboard"]) {
       [superstudentdash setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@", student_name.text]];//setdata
        
      
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
    
    if ([term_flag isEqualToString:@"1"]) {
        NSLog(@"Done Clicked");
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year_p forKey:@"school_year"];
        flag123=@"1";
      
        [self dropdowndatayear];
        [self term1];
        
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

    [schoolYear resignFirstResponder];
}
#pragma mark-marking period term
-(void)dropdowndatayear
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];

    
 NSString  *    sc_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//  NSString  *    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
  NSString  *    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
   NSString  *   mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];

    
    //  NSString *marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    NSString *std_id1=[df objectForKey:@"stdid"];
     NSString *sc_year=[df objectForKey:@"school_year"];
    
   // NSString *school_year12=[df objectForKey:@"studentname"];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
 
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/manage_syear_dropdown.php?school_id=1&syear=2015&staff_id=2
    
    if ([flag123 isEqualToString:@"1"]) {
        // NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
     //   http://107.170.94.176/openSIS_CE6_Mobile/webservice/parent/parent_nav.php?parent_id=2&student_id=1&syear=2015&mp_id=18
        str_checklogin=[NSString stringWithFormat:@"/parent/parent_nav.php?parent_id=%@&student_id=%@&syear=%@&mp_id=%@",
                        parentid,std_id1,sc_year,mp_id];
        NSLog(@"kkkkkkkkkkk%@",str_checklogin);
        
    }
    
    else
    {
        
        
        str_checklogin=[NSString stringWithFormat:@"/parent/parent_nav.php?parent_id=%@&student_id=%@&syear=%@&mp_id=%@",
                        parentid,std_id1,sc_year,mp_id];

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
         appDelegate.dic=dic;
        appDelegate.dic_term=dictionary1;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            // school year data
            
            school_year=[[dictionary1 objectForKey:@"Schoolyear_list"]mutableCopy];
            
            if ([school_year count]>0) {
                school_year_title = [[NSMutableArray alloc] init];
                school_year_id = [[NSMutableArray alloc] init];
                for (int i = 0; i<[school_year count]; i++) {
                    NSDictionary *dic15 = [school_year objectAtIndex:i];
                    [school_year_title  addObject:[dic15 objectForKey:@"VALUE"]];
                    [school_year_id addObject:[dic15 objectForKey:@"ID"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            
            NSMutableDictionary *dic167=[[NSMutableDictionary alloc]init];
            NSString *strt7=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SYEAR"]];
          
            
            NSLog(@"course ary----%@",school_year);
            for (int i=0; i<[school_year count]; i++) {
                
                
                if ([strt7 isEqual:[[school_year  objectAtIndex:i]objectForKey:@"ID"]]) {
                    dic167=[school_year objectAtIndex:i];
                    
                  
                    
                    y=true;
                    break;
                    
                    
                }
                
            }
            
            if (y==true) {
                
                schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"VALUE"]];
                school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"ID"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:school_year1 forKey:@"school_year"];
            }
            
            else
            {
                
                schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"VALUE"]];
                school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"ID"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:school_year1 forKey:@"school_year"];
            }

            
            
            
            
            
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
                    [marking_period_title  addObject:[dic15 objectForKey:@"TITLE"]];
                    [marking_period_id addObject:[dic15 objectForKey:@"ID"]];
                    
                }
                
            }
            else {
                NSLog(@"No  list");
            }
            
            
            NSMutableDictionary *TERM=[[NSMutableDictionary alloc]init];
            NSString *st_T=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"UserMP"]];
            
            NSLog(@"course ary----%@",marking_period);
            for (int i=0; i<[marking_period count]; i++) {
                
                
                if ([st_T isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"ID"]]) {
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
                
                
                
                term.text=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"TITLE"]];
                str_term1=[NSString stringWithFormat:@"%@",[TERM objectForKey:@"ID"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:str_term1 forKey:@"period"];
                
            }
            
            else
            {
                term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"TITLE"]];
                str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"ID"]];
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                [df setObject:str_term1 forKey:@"period"];
                
            }
        }
//
//        [self dropdowndataterm];
//        [self dropdowndatasub];
//        [self dropdowndatacourse];
        
        
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

    [term resignFirstResponder];
    
    
   // S_ReportViewController * report=[[S_ReportViewController alloc]init];
    
  //  [report loaddata];
    

    

}

-(void)alldata1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    marking_period_type=[NSString stringWithFormat:@"%@",[dic objectForKey:@"marking_period_type"]];
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:marking_period_type forKey:@"tanay"];
    
    
    marking_period=[[dic objectForKey:@"marking_period_list"]mutableCopy];
    
    if ([marking_period count]>0) {
        course_period_id = [[NSMutableArray alloc] init];
        marking_period_title= [[NSMutableArray alloc] init];
        marking_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[marking_period count]; i++) {
            NSDictionary *dic15 = [marking_period objectAtIndex:i];
            [marking_period_title  addObject:[dic15 objectForKey:@"TITLE"]];
            [marking_period_id addObject:[dic15 objectForKey:@"ID"]];
            [course_period_id addObject:[dic15 objectForKey:@"ID"]];
            
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
        
        
        if ([strt isEqual:[[marking_period  objectAtIndex:i]objectForKey:@"ID"]]) {
            dic16=[marking_period objectAtIndex:i];
            NSLog(@"dic16---%@",dic16);
            
            t=true;
            break;
            
        }
        
    }
    
    
    if (t==true) {
        
        term.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"TITLE"]];
        _str_term1=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:_str_term1 forKey:@"period"];
        
        
    }
    
    else
    {
        term.text=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"TITLE"]];
        _str_term1=[NSString stringWithFormat:@"%@",[[marking_period objectAtIndex:0]objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:_str_term1 forKey:@"period"];
    }
    
    // school year data
    
    school_year=[[dic objectForKey:@"Schoolyear_list"]mutableCopy];
    
    if ([school_year count]>0) {
        school_year_title = [[NSMutableArray alloc] init];
        school_year_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[school_year count]; i++) {
            NSDictionary *dic15 = [school_year objectAtIndex:i];
            [school_year_title  addObject:[dic15 objectForKey:@"VALUE"]];
            [school_year_id addObject:[dic15 objectForKey:@"ID"]];
            
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
        
        
        if ([strt7 isEqual:[[school_year  objectAtIndex:i]objectForKey:@"ID"]]) {
            dic167=[school_year objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16);
            
            y=true;
            break;
            
            
        }
        
         }
    
    if (y==true) {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"VALUE"]];
        school_year1=[NSString stringWithFormat:@"%@",[dic167 objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year1 forKey:@"school_year"];
    }
    
    else
    {
        
        schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"VALUE"]];
        school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:school_year1 forKey:@"school_year"];
    }

    
///student name////
    
//    school_year=[[appDelegate.dic_year objectForKey:@"Schoolyear_list"]mutableCopy];
//    
//    if ([school_year count]>0) {
//        school_year_title = [[NSMutableArray alloc] init];
//        school_year_id = [[NSMutableArray alloc] init];
//        for (int i = 0; i<[school_year count]; i++) {
//            NSDictionary *dic15 = [school_year objectAtIndex:i];
//            [school_year_title  addObject:[dic15 objectForKey:@"VALUE"]];
//            [school_year_id addObject:[dic15 objectForKey:@"ID"]];
//            
//        }
//        
//    }
//    else {
//        NSLog(@"No  list");
//    }
    
    
    
    NSMutableDictionary *dic1678=[[NSMutableDictionary alloc]init];
    NSString *strt78=[NSString stringWithFormat:@"%@",[dic objectForKey:@"selected_student"]];
    NSMutableArray *ary_stdlist=[[NSMutableArray alloc]init ];
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
        
        student_name.text=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[dic1678 objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];
    }
    
    else
    {
        
        student_name.text=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"VALUE"]];
        str_name=[NSString stringWithFormat:@"%@",[[ary_stdlist objectAtIndex:0]objectForKey:@"ID"]];
        NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
        [df setObject:str_name forKey:@"std_name"];

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
    //    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"er"];
    
    if (superstudentdash) {
        [superstudentdash .navigationController popToRootViewControllerAnimated:YES];
    }
    else if (superstudentgrade)
    {
        [superstudentgrade.navigationController popToRootViewControllerAnimated:YES];
    }

}

@end
