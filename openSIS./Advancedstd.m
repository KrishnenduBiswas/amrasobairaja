//
//  AdvancedStudentScheduleController.m
//  openSiS
//
//  Created by os4ed on 12/7/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "AdvancedStudentScheduleController.h"
#import "Student.h"
#import "TeacherDashboardViewController.h"
#import "SettingsMenu.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "Advancedstd.h"
#import "AppDelegate.h"
@interface Advancedstd ()
{

    NSString *switch_flag;

}


@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UISwitch *switch_includeInactive;
@property (weak, nonatomic) IBOutlet UIButton *button_save;
- (IBAction)action_save:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *view_comments;
@property (strong, nonatomic) IBOutlet UIView *view_birthdayFrom;
@property (strong, nonatomic) IBOutlet UIView *view_birthdayTo;
@property (strong, nonatomic) IBOutlet UIView *view_HeaderMedical;
@property (strong, nonatomic) IBOutlet UIView *view_MedicalDate;
@property (strong, nonatomic) IBOutlet UIView *view_DoctorsNote;
@property (strong, nonatomic) IBOutlet UIView *view_HeaderImmunization;
@property (strong, nonatomic) IBOutlet UIView *view_Immunization_type;
@property (strong, nonatomic) IBOutlet UIView *view_Immunization_date;
@property (strong, nonatomic) IBOutlet UIView *view_Immunization_Comments;
@property (strong, nonatomic) IBOutlet UIView *view_MedicalAlert_date;
@property (strong, nonatomic) IBOutlet UIView *view_HeaderMedicalAlert;
@property (strong, nonatomic) IBOutlet UIView *view_MedicalAlert_alert;
@property (strong, nonatomic) IBOutlet UIView *view_Nursevisit_date;
@property (strong, nonatomic) IBOutlet UIView *view_Nursevisit_reason;
@property (strong, nonatomic) IBOutlet UIView *view_Nursevisit_result;
@property (strong, nonatomic) IBOutlet UIView *view_Nursevisit_Comments;
@property (strong, nonatomic) IBOutlet UIView *view_HeaderNurseVisit, *view_HeaderGoal, *view_GoalTitle, *view_GoalDesc, *view_ProgressPeriod, *view_ProgressAssesment;


@property (weak, nonatomic) IBOutlet UITextField *text_comments,*text_birthdayFrom,*text_birthdayTo,*text_MedicalDate,*text_DoctorsNote,*text_Immunization_type,*text_Immunization_date,*text_Immunization_Comments,*text_MedicalAlert_date,*text_MedicalAlert_alert, *text_Nursevisit_date, *text_Nursevisit_reason, *text_Nursevisit_result, *text_Nursevisit_Comments, *text_GoalTitle, *text_GoalDesc, *text_ProgressPeriod, *text_ProgressAssesment;



@end

@implementation Advancedstd
{
    UIDatePicker *datepicker1, *datepicker2, *datepicker3, *datepicker4, *datepicker5, *datepicker6;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scroll setContentSize:CGSizeMake(self.scroll.frame.size.width, self.button_save.frame.origin.y + 80)];
     switch_flag=@"N";
    [self loadcaleder1];
    [self loadcaleder2];
    [self loadcaleder3];
    [self loadcaleder4];
    [self loadcaleder5];
    [self loadcaleder6];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
}

-(IBAction)switchon:(id)sender
{

    if ([self.switch_includeInactive isOn]) {
        
        switch_flag=@"Y";
        
    }
    else
    {
    
         switch_flag=@"N";
    
    }


}

#pragma mark---Settings

-(IBAction)settings:(id)sender
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self dodesignsforTextViews:self.view_birthdayFrom];
    [self dodesignsforTextViews:self.view_birthdayTo];
    [self dodesignsforTextViews:self.view_comments];
    
    
    [self dodesignsforTextViews:self.view_DoctorsNote];
    [self dodesignsforTextViews:self.view_Immunization_Comments];
    [self dodesignsforTextViews:self.view_Immunization_date];
    
    
    [self dodesignsforTextViews:self.view_Immunization_type];
    [self dodesignsforTextViews:self.view_MedicalAlert_alert];
    [self dodesignsforTextViews:self.view_MedicalAlert_date];
    
    
    [self dodesignsforTextViews:self.view_MedicalDate];
    
    [self dodesignsforTextViews:self.view_Nursevisit_Comments];
    [self dodesignsforTextViews:self.view_Nursevisit_date];
    [self dodesignsforTextViews:self.view_Nursevisit_reason];
    [self dodesignsforTextViews:self.view_Nursevisit_result];
    
    
    [self dodesignsforTextViews:self.view_GoalTitle];
    [self dodesignsforTextViews:self.view_GoalDesc];
    [self dodesignsforTextViews:self.view_ProgressAssesment];
    [self dodesignsforTextViews:self.view_ProgressPeriod];
    
    
    [self dodesignforHeaders:self.view_HeaderImmunization];
    [self dodesignforHeaders:self.view_HeaderMedical];
    [self dodesignforHeaders:self.view_HeaderMedicalAlert];
    [self dodesignforHeaders:self.view_HeaderNurseVisit];
    [self dodesignforHeaders:self.view_HeaderGoal];


    
}

-(void)loadcaleder1
{
    
    datepicker1 = [[UIDatePicker alloc] init];
    
    datepicker1.datePickerMode = UIDatePickerModeDate;
    [datepicker1 addTarget:self action:@selector(click_calender:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_birthdayFrom.inputView = datepicker1;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_birthdayFrom.inputAccessoryView = datePickerToolbar1;
    
}
-(void)loadcaleder2
{
    
    datepicker2 = [[UIDatePicker alloc] init];
    
    datepicker2.datePickerMode = UIDatePickerModeDate;
    [datepicker2 addTarget:self action:@selector(click_calender2:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_birthdayTo.inputView = datepicker2;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_birthdayTo.inputAccessoryView = datePickerToolbar1;
    
}
-(void)loadcaleder3
{
    
    datepicker3 = [[UIDatePicker alloc] init];
    
    datepicker3.datePickerMode = UIDatePickerModeDate;
    [datepicker3 addTarget:self action:@selector(click_calender3:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_Immunization_date.inputView = datepicker3;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_Immunization_date.inputAccessoryView = datePickerToolbar1;
    
}
-(void)loadcaleder4
{
    
    datepicker4 = [[UIDatePicker alloc] init];
    
    datepicker4.datePickerMode = UIDatePickerModeDate;
    [datepicker4 addTarget:self action:@selector(click_calender4:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_MedicalAlert_date.inputView = datepicker4;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_MedicalAlert_date.inputAccessoryView = datePickerToolbar1;
    
}
-(void)loadcaleder5
{
    
    datepicker5 = [[UIDatePicker alloc] init];
    
    datepicker5.datePickerMode = UIDatePickerModeDate;
    [datepicker5 addTarget:self action:@selector(click_calender5:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_MedicalDate.inputView = datepicker5;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_MedicalDate.inputAccessoryView = datePickerToolbar1;
    
}

-(void)loadcaleder6
{
    
    datepicker6 = [[UIDatePicker alloc] init];
    
    datepicker6.datePickerMode = UIDatePickerModeDate;
    [datepicker6 addTarget:self action:@selector(click_calender6:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_Nursevisit_date.inputView = datepicker6;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_Nursevisit_date.inputAccessoryView = datePickerToolbar1;
    
}



-(IBAction)dismissPicker1:(id)sender

{
    [self.text_birthdayFrom resignFirstResponder];
    [self.text_birthdayTo resignFirstResponder];
    [self.text_Immunization_date resignFirstResponder];
    [self.text_MedicalAlert_date resignFirstResponder];
    [self.text_MedicalDate resignFirstResponder];
    [self.text_Nursevisit_date resignFirstResponder];
    
}


-(IBAction)click_calender:(id)sender
{
    NSDate *selectedDate = datepicker1.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd"];
    self.text_birthdayFrom.text = [df stringFromDate:selectedDate];
    //[lbl_date setText:[df stringFromDate:selectedDate]];
    
}

-(IBAction)click_calender2:(id)sender
{
    NSDate *selectedDate = datepicker2.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd"];
    self.text_birthdayTo.text = [df stringFromDate:selectedDate];
}

-(IBAction)click_calender3:(id)sender
{
    NSDate *selectedDate = datepicker3.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMM, yyyy"];
    self.text_Immunization_date.text = [df stringFromDate:selectedDate];
    
}

-(IBAction)click_calender4:(id)sender
{
    NSDate *selectedDate = datepicker4.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMM, yyyy"];
    self.text_MedicalAlert_date.text = [df stringFromDate:selectedDate];
    
}
-(IBAction)click_calender5:(id)sender
{
    NSDate *selectedDate = datepicker5.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMM, yyyy"];
    self.text_MedicalDate.text = [df stringFromDate:selectedDate];
    
}

-(IBAction)click_calender6:(id)sender
{
    NSDate *selectedDate = datepicker6.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMM, yyyy"];
    self.text_Nursevisit_date.text = [df stringFromDate:selectedDate];
}

- (NSString *)convertDate:(NSString *)dateStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMM, yyyy"];
    NSDate *date = [df dateFromString:dateStr];
    [df setDateFormat:@"yyyy-MM-dd"];
    dateStr = [df stringFromDate:date];
    
    return dateStr;
}

- (IBAction)action_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)dodesignsforTextViews:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    disview.clipsToBounds = YES;
}

- (void)dodesignforHeaders:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.00f]CGColor]];
    [disview.layer setBorderWidth:1.0f];
    
}

- (NSString *)gettheString
{
    //self.senderString = @"";
    if ([self.senderString isEqualToString:@"(null)"] || [self.senderString isEqualToString:@""] || [self.senderString isEqualToString:@"null"] || !self.senderString) {
        self.senderString = @"";
    }
    
    if (self.text_birthdayFrom.text.length > 0) {
        NSString *tempDay = [self.text_birthdayFrom.text substringToIndex:2];
        NSString *tempMonth = [self.text_birthdayFrom.text substringFromIndex:3];
        self.senderString = [NSString stringWithFormat:@"%@&day_from_birthdate=%@",self.senderString,tempDay];
        self.senderString = [NSString stringWithFormat:@"%@&month_from_birthdate=%@",self.senderString,tempMonth];
    }
    
    if (self.text_birthdayTo.text.length > 0) {
        
        NSString *tempDay = [self.text_birthdayFrom.text substringToIndex:2];
        NSString *tempMonth = [self.text_birthdayFrom.text substringFromIndex:3];
        
        self.senderString = [NSString stringWithFormat:@"%@&day_to_birthdate=%@",self.senderString,tempDay];
        self.senderString = [NSString stringWithFormat:@"%@&month_to_birthdate=%@",self.senderString,tempMonth];
    }
    
    if (self.text_GoalTitle.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&goal_title=%@",self.senderString,self.text_GoalTitle.text];
    }

    if (self.text_GoalDesc.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&goal_description=%@",self.senderString,self.text_GoalDesc.text];
    }

    if (self.text_ProgressAssesment.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&progress_description=%@",self.senderString,self.text_ProgressAssesment.text];
    }

    if (self.text_ProgressPeriod.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&progress_name=%@",self.senderString,self.text_ProgressPeriod.text];
    }

    
    
    
    if (self.text_comments.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&mp_comment=%@",self.senderString,self.text_comments.text];
    }
    
    if (self.text_DoctorsNote.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&doctors_note_comments=%@",self.senderString,self.text_DoctorsNote.text];
    }
    
    if (self.text_Immunization_date.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&imm_date=%@",self.senderString,[self convertDate:self.text_Immunization_date.text]];
    }
    
    if (self.text_Immunization_Comments.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&imm_comments=%@",self.senderString,self.text_Immunization_Comments.text];
    }
    
    if (self.text_Immunization_type.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&type=%@",self.senderString,self.text_Immunization_type.text];
    }
    
    if (self.text_MedicalAlert_alert.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&med_alrt_title=%@",self.senderString,self.text_MedicalAlert_alert.text];
    }
    
    if (self.text_MedicalAlert_date.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&ma_date=%@",self.senderString,[self convertDate:self.text_MedicalAlert_date.text]];
    }
    
    if (self.text_MedicalDate.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&med_date=%@",self.senderString,[self convertDate:self.text_MedicalDate.text]];
        
    }
    
    
    
    if (self.text_Nursevisit_Comments.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&med_vist_comments=%@",self.senderString,self.text_Nursevisit_Comments.text];
        
    }

    if (self.text_Nursevisit_date.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&nv_date=%@",self.senderString,[self convertDate:self.text_Nursevisit_date.text]];
        
    }

    if (self.text_Nursevisit_reason.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&reason=%@",self.senderString,self.text_Nursevisit_reason.text];
        
    }

    if (self.text_Nursevisit_result.text.length > 0) {
        self.senderString = [NSString stringWithFormat:@"%@&result=%@",self.senderString,self.text_Nursevisit_result.text];
        
    }
   
        self.senderString = [NSString stringWithFormat:@"%@&include_inactive=%@",self.senderString,switch_flag];
        
    

    
    NSLog(@"The Parameter String: %@", self.senderString);
    return self.senderString;
}


-(IBAction)home:(id)sender
{
    
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // NSLog(@"dic===========%@",dic);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    // vc.dic=dic;
    //vc.dic_techinfo=dic_techinfo;
    // appDelegate.dic=dic;
    //   appDelegate.dic_techinfo=dic_techinfo;
    
    [self.navigationController pushViewController:vc animated:NO];
    
}
-(IBAction)thirdButton:(id)sender
{
    NSLog(@"Third Button");
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"msg" bundle:nil];
    msg1*obj = [sb instantiateViewControllerWithIdentifier:@"msg1"];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
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
        NSMutableDictionary* dic_techinfo = (NSMutableDictionary *)responseObject;
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
                
                //  [self droptable];
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





- (IBAction)action_save:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Student" bundle:nil];
    Student *slc = [[Student alloc]init];
    slc = [sb instantiateViewControllerWithIdentifier:@"tstudentlist"];
    slc.senderString = [self gettheString];
    slc.flag_check=switch_flag;
    [self.navigationController pushViewController:slc animated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
