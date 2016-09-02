//
//  TeacherDashboardViewController.m
//  openSiS
//
//  Created by EjobIndia on 17/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//
#import "AppDelegate.h"
#import "TeacherDashboardViewController.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
#import "attendence.h"
#import "GradesViewController.h"
#import "AFNetworking.h"
#import "schoolinfo.h"
#import "ip_url.h"
#import "MBProgressHUD.h"
#import "ScheduleHomeController.h"
#import "msg1.h"
#import "SettingsMenu.h"
#import "Month1ViewController.h"
#import "stdsearch.h"
#import "SettingsMenu.h"
#import "AppDelegate.h"
@interface TeacherDashboardViewController ()
{
    SlideViewController *slide;
    NSString *courseperiodnamestr;
}

@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;

@end

@implementation TeacherDashboardViewController
@synthesize dic,img_profile,profile;

@synthesize  school_id,school_year1,str_term1,str_sub1,str_cou1,str_cp1,dic_techinfo;


#pragma mark---Settings

-(IBAction)settings:(id)sender
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
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



#pragma mark-------viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  [self showdata];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"teacherdashboard"];
   
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

   
    
    ca_cp_id=[[NSMutableArray alloc]init];
   course_period_ary=[[NSMutableArray alloc]init];
    [self alldata];
    //[self alldata];
  [self courseperiod123];
  //  [self alldata];
//    [self courseperiodname];
    
    [self tabledata];
    
    //*currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName
    
    UITapGestureRecognizer *mising= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(m_attendence:)];
    mising.numberOfTapsRequired = 1;
  
    //[self.view addGestureRecognizer:tapmainview];
    [view_missing_attendence addGestureRecognizer:mising];
    
    
  
    
    
//    newView.frame=CGRectMake(0, 0, self.view.frame.size.width - 50, self.view.frame.size.height);
//    int x = newView.frame.size.width;
//    slidewidth = x / 2;
//    int y1 = newView.frame.size.height;
//    
//    slideheight = y1 / 2;
    //[Xbutton setFrame:CGRectMake(213, 0, 46, 30)];
    
    //[newView addSubview:Xbutton];
    // Do any additional setup after loading the view.
    /*UITapGestureRecognizer *tapmainview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    tapmainview.numberOfTapsRequired = 1;
    tapmainview.delegate = self;
    //[self.view addGestureRecognizer:tapmainview];
    [baseView addGestureRecognizer:tapmainview];*/
    
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
    

}



-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    [self fetchdata];
    [self setcourseperiodonthisobj];
  //  [self showdata];
}


-(IBAction)m_attendence:(id)sender
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    attendence* vc = [storyboard instantiateViewControllerWithIdentifier:@"atten"];
    vc.dic=dic;
    vc.dic_techinfo=dic_techinfo;
    vc.school_name=currentSchool.text;
    vc.school_year_name=schoolYear.text;
    vc.school_term=term.text;
    vc.school_sub=subject.text;
    vc.school_course=course.text;
    vc.school_courseperiod=coursePeriod.text;
    vc.school_courseperiodname=courseperiodName.text;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    




}
- (void)setcourseperiodonthisobj
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
        courseperiodName.text = [NSString stringWithFormat:@"%@",[course_period_title_2 objectAtIndex:indexofcpv]];
        
    }
    
}


-(void)showdata
{
  AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  //  dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    NSLog(@"slide--value------%@",appDelegate.cp_value);
    // NSLog(@"dic===========%@",dic);
    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
    
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
        // NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
    
    
    //  NSLog(@"course ary----%@",course_period_ary);
    for (int i=0; i<[course_period_ary count]; i++) {
        
        
        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
            dic177=[course_period_ary objectAtIndex:i];
            
            c_ap=true;
            break;
            
        }
        
        
        else
        {
            
            
            
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
    
    [self courseperiod123];

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
            lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
            
            //missing attendence count ////
            NSString *str_missing_attendence=[NSString stringWithFormat:@"%@",lbl_hidden.text];
            if ([str_missing_attendence isEqualToString:@"0"]) {
                
            }
            
            else
            {
                
                [self droptable];
            }
            

            notofi.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"notification_count"]];
            NSString *str_count=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            if ([str_count isEqualToString:@"0"]) {
                msg_count_tab.hidden=YES;
                msg_count.hidden=YES;
            }
            else
            {
                msg_count_tab.hidden=NO;
                msg_count.hidden=NO;
                
                msg_count_tab.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
                msg_count.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
            }
                   }
        
        
        else
        {
          //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
         //   UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
          //  [alert show];
            
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
-(void)droptable{
    
   // [msg_count sizeToFit];
  //  [notofi sizeToFit];
  //  [msg_count_tab sizeToFit];
    
//   lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
//    notofi.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"notification_count"]];
//    NSString *str_count=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
//    if ([str_count isEqualToString:@"0"]) {
//        msg_count_tab.hidden=YES;
//         msg_count.hidden=YES;
//    }
//    else
//    {
//        msg_count_tab.hidden=NO;
//        msg_count.hidden=NO;
//
//     msg_count_tab.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
//       msg_count.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
//    }
//    NSLog(@"lbl___---%@",lbl_hidden.text);
    lbl_lvlview_drop.text =[NSString stringWithFormat:@"You have %@ mising attendence",[dic_techinfo objectForKey:@"missing_attendance_count"]];
    
    
    NSLog(@"label hidden value------%@",lbl_hidden.text);
    if (![lbl_hidden.text isEqual:@"0"] && flag == 0) {
        
        
        [UIView animateWithDuration:0.5f animations:^{
            labelView.frame =
            CGRectMake(labelView.frame.origin.x,
                       labelView.frame.origin.y,
                       labelView.frame.size.width,
                       labelView.frame.size.height + 40);
            
        }];
        [UIView animateWithDuration:0.5f animations:^{
            table.frame =
            CGRectMake(table.frame.origin.x,
                       table.frame.origin.y + 40,
                       table.frame.size.width,
                       table.frame.size.height);
            
        }];
        
        flag = 1;
        k = 1;
        
    }
    else if([lbl_hidden.text isEqual:@"0"] && k == 1)
    {
        [UIView animateWithDuration:0.5f animations:^{
            labelView.frame =
            CGRectMake(labelView.frame.origin.x,
                       labelView.frame.origin.y,
                       labelView.frame.size.width,
                       labelView.frame.size.height - 40);
            
        }];
        
        [UIView animateWithDuration:0.5f animations:^{
            table.frame =
            CGRectMake(table.frame.origin.x,
                       table.frame.origin.y - 40,
                       table.frame.size.width,
                       table.frame.size.height);
            
        }];
        
        flag = 0;
        k =0;
        
    }

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

-(void)labelborderset:(UILabel*)lbl1
{
    lbl1.layer.borderWidth=4.0f;
    lbl1.layer.borderColor=[UIColor clearColor].CGColor;
    lbl1.layer.cornerRadius=2.0f;
    lbl1.clipsToBounds=YES;
}

-(void)alldata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
  
    
    
    
    dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    NSLog(@"dic===========%@",dic);
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
    
    
   // NSLog(@"course ary----%@",course_period_ary);
    if ([course_period_ary count] > 0) {
          for (int i=0; i<[course_period_ary count]; i++) {
        
        
        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
            dic177=[course_period_ary objectAtIndex:i];
           
            c_ap=true;
            break;
            
        }
        
        
        else
        {
            
            
            
        }
        
    }
    }
    else
    {
    
        NSLog(@"No Data Found");
    }
    
    if (c_ap==true) {
        coursePeriod.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"cpv_id"]];
    }
    
    else
    {
        
        
       // coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
       // courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
      //  str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
        
        
    }
    
    
    
    
}


-(void)courseperiodname
{

    
  
    
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
          [dic_8 setObject:strkk forKey:@"UserCoursePeriodVar"];
          appDelegate.dic = [dic_8 mutableCopy];
          NSLog(@"course period id1111------%@",course_period_ary);
          
          NSLog(@"-------%@",coperiod);
          
          cp_flag=@"1";
  }
    
}

-(void)tabledata
{

    ary_data=[[NSMutableArray alloc]initWithObjects:@"Attendance",@"Gradebook",@"My Students",@"Schedule",@"Extra Curricular",@"School Information", nil];
    img_ary=[[NSMutableArray alloc]initWithObjects:@"attendence",@"grade",@"mystudent",@"sch",@"e_cur",@"schoolinfo",nil];

    
    table.tableFooterView=[[UIView alloc]init];
    




}


   


-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    
    if ([cp_flag isEqualToString:@"1"]) {
      //  AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       /// [dic setObject:coperiod forKey:@"UserCoursePeriod"];
      //  appDelegate.dic=dic;
        

        
        
        
    }
    [currentSchool resignFirstResponder];
     [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
     [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}
-(IBAction)click:(id)sender
{

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
    [self fetchdata];
    [self showdata];

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
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"cell123" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
   
    cell.clipsToBounds = YES;
    lbl.text=[ary_data objectAtIndex:indexPath.row];
    img.image=[UIImage imageNamed:[img_ary objectAtIndex:indexPath.row]];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 46.0f;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str_data=[ary_data objectAtIndex:indexPath.row];
    
    NSMutableArray *INFO=[[NSMutableArray alloc]init];
    INFO=[dic_techinfo objectForKey:@"tech_info"];
    
    
    
   // NSString *str_school_id=[NSString stringWithFormat:@"%@",[[INFO objectAtIndex:0]objectForKey:@"CURRENT_SCHOOL_ID"]];
    
    NSString *str_staff_id=[NSString stringWithFormat:@"%@",[[INFO objectAtIndex:0]objectForKey:@"STAFF_ID"]];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"date and time------%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    NSString *STR_date_local =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    
    if ([str_data isEqualToString:@"Attendance"]) {
        UIStoryboard *s1=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        takeattendance *obj=[s1 instantiateViewControllerWithIdentifier:@"take"];
      //  obj.school_id1=str_school_id;
        obj.staff_id=str_staff_id;
        obj.str_date=STR_date_local;
       obj.cpv_id=[dic objectForKey:@"UserCourse"];
        obj.dic=dic;
        obj.dic_techinfo=dic_techinfo;
        obj.s_lbl.text=str_cp1;
        [self.navigationController pushViewController:obj animated:YES];
    }
    else if([str_data isEqualToString:@"Gradebook"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GradesViewController *obj = [sb instantiateViewControllerWithIdentifier:@"grades"];
        
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }
    else if([str_data isEqualToString:@"Schedule"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ScheduleHomeController *obj = [sb instantiateViewControllerWithIdentifier:@"schedulehome"];
        
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }
    
    else if([str_data isEqualToString:@"My Students"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Student" bundle:nil];
        stdsearch *obj = [sb instantiateViewControllerWithIdentifier:@"stdsearch"];
        
        
        [self.navigationController pushViewController:obj animated:YES];
        
        
    }

    else if([str_data isEqualToString:@"School Information"])
    {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
            schoolinfo *obj = [sb instantiateViewControllerWithIdentifier:@"sinfo"];
        
      
                [self.navigationController pushViewController:obj animated:YES];
        
        
    }

    else
    {
        
//        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
//        schoolinfo *obj = [sb instantiateViewControllerWithIdentifier:@"sinfo"];
//        
//        
//        [self.navigationController pushViewController:obj animated:YES];
        
        
        
    }

    
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{


    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"msg" bundle:nil];
        msg1*obj = [sb instantiateViewControllerWithIdentifier:@"msg1"];
    
    
    [self.navigationController pushViewController:obj animated:YES];

}
#pragma mark---Settings


#pragma mark -- clendar
-(IBAction)calendar:(id)sender
{

    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];

}

@end
