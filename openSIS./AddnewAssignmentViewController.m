//
//  AddnewAssignmentViewController.m
//  openSiS
//
//  Created by os4ed on 10/30/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "AddnewAssignmentViewController.h"
#import "TeacherDashboardViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "AppDelegate.h"
#import "ClassWorkViewController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface AddnewAssignmentViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker *datePicker1,*datepicker2;
    UIPickerView *selectcustomerpicker;
    NSMutableArray *arr_picker;
    IBOutlet UISwitch *switch1;
}

@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet UIView *view_title;
@property (strong, nonatomic) IBOutlet UITextField *text_title;
@property (strong, nonatomic) IBOutlet UIView *view_points;
@property (strong, nonatomic) IBOutlet UITextField *text_points;
@property (strong, nonatomic) IBOutlet UIView *view_assignmenttypes;
@property (strong, nonatomic) IBOutlet UILabel *msg_count_tab;
@property (strong, nonatomic) IBOutlet UITextField *text_assignmenttypes;
@property (strong, nonatomic) IBOutlet UILabel *lbl_points;
@property (strong, nonatomic) IBOutlet UIView *view_assignDate;
@property (strong, nonatomic) IBOutlet UITextField *text_assigndate;
@property (strong, nonatomic) IBOutlet UILabel *lbl_assigndate;
@property (strong, nonatomic) IBOutlet UIView *view_duedate;
@property (strong, nonatomic) IBOutlet UITextField *text_duedate;
@property (strong, nonatomic) IBOutlet UIView *view_description;
@property (strong, nonatomic) IBOutlet UITextView *textview_description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_description;
@property (strong, nonatomic) IBOutlet UILabel *lbl_duedate;
@property (strong, nonatomic) IBOutlet UIButton *button_save;
@property (strong, nonatomic) IBOutlet UILabel *lbl_assignmenttype;
- (IBAction)action_save:(id)sender;
- (IBAction)action_switch:(id)sender;


@end

@implementation AddnewAssignmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    self.msg_count_tab.text=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"message_count"]];
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    self.text_assignmenttypes.text=[df objectForKey:@"title123"];
     flag=@"N";
    arr_picker = [[NSMutableArray alloc]init];
    ARY_PICK_TITLE=[[NSMutableArray alloc]init];
    ary_id=[[NSMutableArray alloc]init];
     [self picker_assignmenttype];
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

    
    
    [self loaddata1];
    
    [self toolbar];
    [self dodesign];
    [self loadcalender];
    [self loadcalender2];
    
    
    
    
   
 //   self.text_assignmenttypes.text = [NSString stringWithFormat:@"%@",[arr_picker objectAtIndex:0]];
    // Do any additional setup after loading the view.
}

-(void)alertmsg:(NSString*)msg
{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];

}

-(void)loaddata1
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    pick_id=[DF objectForKey:@"iphone_id"];
    NSLog(@"type_id----%@",pick_id);
 

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
      NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
         NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
  //  UserMP
    
       NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/assignments.php?type=add_view&staff_id=%@&mp_id=%@&cpv_id=%@&school_id=%@",STAFF_ID_K,mp_id,cpv_id1,school_id];
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
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            
            arr_picker=[dictionary1 objectForKey:@"assignment_types"];
         NSMutableDictionary *dic15=[[NSMutableDictionary alloc]init];
            for (int i = 0; i<[arr_picker count]; i++) {
                dic15 = [arr_picker objectAtIndex:i];
                [ARY_PICK_TITLE  addObject:[dic15 objectForKey:@"TITLE"]];
                [ary_id addObject:[dic15 objectForKey:@"ASSIGNMENT_TYPE_ID"]];
                
                
            }

            
            
            
              
            
            
       
            
          
                   
        
        }
        
        
        else
        {
            
          
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
         }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}


-(void)dodesign
{
    [self design:self.view_assignDate];
    [self design:self.view_assignmenttypes];
    [self design:self.view_description];
    [self design:self.view_duedate];
    [self design:self.view_points];
    [self design:self.view_title];
}

-(void)design:(UIView*)obj
{
    
    obj.layer.borderWidth =  1.0f;
    obj.backgroundColor = [UIColor whiteColor];
    obj.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [obj.layer setCornerRadius:3.5f];
    obj.clipsToBounds = YES;
    
}

-(void)toolbar
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.text_points.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad  {
    [self.text_points resignFirstResponder];
    self.text_points.text=@"";
}

-(void)doneWithNumberPad    {
    // NSString *numberFromTheKeyboard = phone_num.text;
    
    [self.text_points resignFirstResponder];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [self animateTextField1:textView up:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextField1:textView up:NO];
}


#pragma mark textview
-(void)animateTextField1:(UITextView*)textview up:(BOOL)up
{
    const int movementDistance = -180; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (IBAction)action_save:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:assign_date];
    dt2 = [df dateFromString:due_date];
    NSComparisonResult result = [dt2 compare:dt1];
    
    if ([self.text_title.text length]<1) {
        [self alertmsg:@"Please enter title"];
    }
    
    else if ([self.text_points.text length]<1)
    {
    
              [self alertmsg:@"Please enter points"];
    
    }
    else if ([self.text_assigndate.text length]<1)
    {
        
        [self alertmsg:@"Please enter assigndate"];
        
    }
    else if ([self.text_duedate.text length]<1)
    {
        
        [self alertmsg:@"Please enter duedate"];
        
    }
    
    else if (result==NSOrderedAscending )
    {
    
        NSLog(@"great");
        [self alertmsg:@"Due date must be greater than assigned date."];
    }
  /*  else if ([self.textview_description.text length]<1)
    {
        
        [self alertmsg:@"Please enter description"];
        
    }*/
    
    else
    {
    
    
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(savedata) withObject:nil afterDelay:2];
            });
        });

    
    }

    
    
}


-(void)savedata
{
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/assignments.php?type=add_submit&staff_id=2&school_id=1&syear=2015&mp_id=16&cpv_id=1&assignment_details=[{"TITLE":"test Assignment title New","POINTS":"3","APPLY_TO_ALL":"Y","DESCRIPTION":"fgfgfg","DUE_DATE":"2015-11-22","ASSIGNED_DATE":"2015-10-23","ASSIGNMENT_TYPE_ID":"2"}]
   
    
 
    NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    NSMutableArray *arrData=[[NSMutableArray alloc]init];
      NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
       NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];


    
    
    [dict setValue:pick_id forKey:@"ASSIGNMENT_TYPE_ID"];
    [dict setValue:self.text_title.text forKey:@"TITLE"];
     [dict setValue:self.text_points.text forKey:@"POINTS"];
       [dict setValue:self.textview_description.text forKey:@"DESCRIPTION"];
       [dict setValue:assign_date forKey:@"ASSIGNED_DATE"];
      [dict setValue:due_date forKey:@"DUE_DATE"];
     [dict setValue:flag forKey:@"APPLY_TO_ALL"];
    
    
    NSLog(@"%@",dict);
    [arrData addObject:dict];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    NSString * str111 = [Base64 encode:data];
    str111=[arrData JSONRepresentation];
      NSLog(@"----String To Post To Server ---%@",str111);
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
      NSString *urlStr = [NSString stringWithFormat:@"/assignments.php?type=add_submit"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    //
    //    NSLog(@"----%@",url12);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
  //  &staff_id=%@&school_id=%@&syear=%@&mp_id=%@&cpv_id=%@",STAFF_ID_K,school_id,year_id,mp_id,cpv_id1
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"staff_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[STAFF_ID_K dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[school_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[mp_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"cpv_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[cpv_id1 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // delivery_type=%@&delivery_date=%@&delivery_time=%@&description=%@&gofor_cut=%@&distance_amout=%@",uid,pa_amt,SCH_TYPE,date,time,DES,go_cut,d_amount];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"assignment_details\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[str111 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSLog(@"request...%@",request);
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"======%@",returnData);
    //   NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary  *datadic=[[NSMutableDictionary alloc]init];
    datadic = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:NULL];
    NSLog(@"datadic-------%@",datadic);
    
    NSString *succ=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"success"]];
    if ([succ isEqualToString:@"1"]) {
        NSUserDefaults*df=[NSUserDefaults standardUserDefaults];
        [df setObject:pick_id forKey:@"iphone_id"];
        [df setObject:self.text_assignmenttypes.text forKey:@"title123"];
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ClassWorkViewController *obj = [sb instantiateViewControllerWithIdentifier:@"classwork"];
        
            [self.navigationController pushViewController:obj animated:YES];
        

        
    }
    
    else
    {
    
          NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        [self alertmsg:msg];
    
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
///   UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ClassWorkViewController *obj = [sb instantiateViewControllerWithIdentifier:@"classwork"];
//    
//    [self.navigationController pushViewController:obj animated:YES];
    
    
    
    
    
    
}







- (IBAction)action_switch:(id)sender {
    
    if ([switch1 isOn]) {
        
        flag=@"Y";
       
    } else {
        flag=@"N";
    }
}


- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Tabbar

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
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings"bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
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





#pragma mark - calendar and picker

-(void)loadcalender
{
    
    datePicker1 = [[UIDatePicker alloc] init];
    
    datePicker1.datePickerMode =UIDatePickerModeDate;
    datePicker1.date = [NSDate date];
    [datePicker1 addTarget:self action:@selector(click_calender:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker1:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    self.text_assigndate.inputView = datePicker1;
   
    // Set UITextfield's inputAccessoryView as UIToolbar
    
    self.text_assigndate.inputAccessoryView = datePickerToolbar1;
}



-(IBAction)dismissPicker1:(id)sender
{
    
    [self.text_assigndate  resignFirstResponder];
    [self.text_duedate resignFirstResponder];
    [self.text_assignmenttypes resignFirstResponder];
    
    if ([assign_flag isEqualToString:@"1"]) {
        
        NSLog(@"ASSIGN---%@",assign_date);
        
    }
    
    else
    {
    
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        
        
        
        
        
        assign_date=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:[NSDate date]]];
        self.text_assigndate.text =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] ;

    }
    
    
}

-(IBAction)click_calender:(id)sender
{
   // NSDate *selectedDate = datePicker1.date;
   
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy"];
    //[self.text_assigndate setText:[df stringFromDate:selectedDate]];
    NSString *datestr = [NSString stringWithFormat:@"%@",[df stringFromDate:datePicker1.date]];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
   
  assign_date=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:datePicker1.date]];
    self.text_assigndate.text = datestr;
     assign_flag=@"1";
}


-(void)loadcalender2
{
    
    datepicker2 = [[UIDatePicker alloc] init];
    
    datepicker2.datePickerMode =UIDatePickerModeDate;
    datepicker2.date = [NSDate date];
    [datepicker2 addTarget:self action:@selector(click_calender2:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker2:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
   
    self.text_duedate.inputView = datepicker2;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.text_duedate.inputAccessoryView = datePickerToolbar1;
}
-(IBAction)dismissPicker2:(id)sender
{
    
    [self.text_assigndate  resignFirstResponder];
    [self.text_duedate resignFirstResponder];
    [self.text_assignmenttypes resignFirstResponder];
    
    if ([due_flag isEqualToString:@"1"]) {
        
        NSLog(@"duedaTE-----%@",due_date);
        
    }
    
    else
    {
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
        
        
        
        
        
          due_date=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:[NSDate date]]];
        self.text_duedate.text =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]] ;
        
    }
    
    
}

-(IBAction)click_calender2:(id)sender
{
    //NSDate *selectedDate = datePicker1.date;
    due_flag=@"1";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM dd, yyyy"];
//    [self.text_duedate setText:[df stringFromDate:selectedDate]];
     NSString *datestr = [NSString stringWithFormat:@"%@",[df stringFromDate:datepicker2.date]];
  
    //    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    //    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    //
    //
    //    /
    //    str_date= [formatter1 stringFromDate:selectedDate];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    
    
    
    
    due_date=[NSString stringWithFormat:@"%@",[formatter1 stringFromDate:datepicker2.date]];
    
      self.text_duedate.text = datestr;
    due_flag=@"1";
    
}

-(void)picker_assignmenttype

{
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    
    self.text_assignmenttypes.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker1:)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_assignmenttypes.inputAccessoryView = mypickerToolbar;

}



#pragma mark - Picker View Delegate datasource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [ARY_PICK_TITLE objectAtIndex:row];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return   ARY_PICK_TITLE.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.text_assignmenttypes.text = [NSString stringWithFormat:@"%@",[ ARY_PICK_TITLE objectAtIndex:row]];
    
   
    
    NSString *strC1 =(NSString *)[ARY_PICK_TITLE objectAtIndex:row];
   pick_id = [ary_id objectAtIndex:[ARY_PICK_TITLE indexOfObjectIdenticalTo:strC1]];
    

}

@end
