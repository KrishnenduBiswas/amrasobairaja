//
//  S_addgrpcomposeViewController.m
//  openSiS
//
//  Created by os4ed on 5/4/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "S_addgrpcomposeViewController.h"
#import "MsgViewController.h"
#import "SearchVC.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "OutboxViewController.h"
#import "S_TrashViewController.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"

@interface S_addgrpcomposeViewController ()
{
     NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
}
@property (strong, nonatomic) IBOutlet UITextView *txt_cc;
@property (strong, nonatomic) IBOutlet UITextField *from;
@property (strong, nonatomic) IBOutlet UITextView *msg_view;
@property (strong, nonatomic) IBOutlet UIView *header_view;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UITextField *txt_compose;
@property (strong, nonatomic) IBOutlet UITextView *to;
@property (strong, nonatomic) IBOutlet UIButton *btn_sndmsg;
@property (strong, nonatomic) IBOutlet UITextView *txt_bcc;
@property (strong, nonatomic) IBOutlet UITextField *txt_selectGroup;
@property (strong, nonatomic) IBOutlet UIPickerView *class_picker;
//@property (strong, nonatomic) IBOutlet UIView *view_theblack;

@property (strong, nonatomic) IBOutlet UIView *view_onlongpress;

@property (strong, nonatomic) IBOutlet UIView *view_sublongpress;


@end

@implementation S_addgrpcomposeViewController

{
    UIPickerView *selectcustomerpicker;
    NSMutableArray *array_groups;
    NSString *str_selectedgroupID;
    NSMutableArray *array_course_period_info;
    NSMutableDictionary *tempDict;
    NSString *cp_id;
    NSString *list_gpa_student;
    NSString *list_gpa_parent;
    NSMutableArray * course_period_title;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    str_selectedgroupID = @"";
    cp_id = @"";
    list_gpa_student = @"";
    list_gpa_parent = @"";
    
    
  
    course_period_title=[[NSMutableArray alloc]initWithObjects:@"Inbox",@"Outbox",@"Groups",@"Trash", nil];
    
    [self action_closeSelect:nil];
    array_groups = [[NSMutableArray alloc]init];
    [self.scroll setContentSize:CGSizeMake(self.scroll.frame.size.width, self.btn_sndmsg.frame.origin.y + 70)];
    // [self dodesignforHeaders:to];
    [self dodesignsforTextViews:self.to];
    [self dodesignforHeaders:self.from];
    [self dodesignsforTextViews:self.msg_view];
    [self dodesignforHeaders1:self.header_view];
    [self dodesignsforTextViews:self.txt_cc];
    [self dodesignsforTextViews:self.txt_bcc];
    
    [self dodesignforHeaders:self.txt_selectGroup];
    [self courseperiod123];
    
    [self courseperiod1234];
    
    
    
    //[self loaddata];
    [self.view_onlongpress setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.6]];
    // Do any additional setup after loading the view.
}


-(IBAction)home:(id)sender
{
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SdashboardViewController *home=[[SdashboardViewController alloc]init];
    home=[sb instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:home animated:NO];
    
    
    
    
    
}

-(void)courseperiod1234{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=7;
    
    _txt_compose.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked11)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    _txt_compose.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}



-(void)pickerDoneClicked11
{
    
    
   
        
        _txt_compose.text=inbox_data;
        [_txt_compose resignFirstResponder];
        if ([term_flag isEqualToString:@"1"]) {
            if ([inbox_data isEqualToString:@"Outbox"]) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"msg" bundle:[NSBundle mainBundle]];
                OutboxViewController *outt = [sb instantiateViewControllerWithIdentifier:@"outbox"];
                [self.navigationController pushViewController:outt animated:NO];
                
            }
            
            else    if ([inbox_data isEqualToString:@"Inbox"]) {
                
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
                MsgViewController *mgc =[[MsgViewController alloc]init];
                mgc=[sb instantiateViewControllerWithIdentifier:@"msg"];
                [self.navigationController pushViewController:mgc animated:NO];
                
            }
            
            else  if ([inbox_data isEqualToString:@"Trash"]) {
                
                
                UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
                S_TrashViewController *msgcm=[[S_TrashViewController alloc]init];
                msgcm=[sb instantiateViewControllerWithIdentifier:@"strash"];
                [self.navigationController pushViewController:msgcm animated:YES];
            }
            
            else
            {
                
                //            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
                //            composeViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"compose"];
                // vc.dic=dic;
                
                // vc.dic_techinfo=dic_techinfo;
                
                
                
                //  [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            
        }
        else
        {
            
            
            _txt_compose.text=@"Compose";
            
            
            
            
        }
        

    
    
    
    
    
    
    
    
    
    
    
    
    
}









-(void)loaddata
{
    // transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddataforgroup) withObject:nil afterDelay:1.0];
        });
    });
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    
    if (![self.str_To isEqualToString:@""]) {
        self.to.text = self.str_To;
        self.str_To = @"";
    }
    
    if (![self.str_prev_cc isEqualToString:@""]) {
        self.txt_cc.text = self.str_prev_cc;
        self.str_prev_cc = @"";
    }
    
    if (![self.str_prev_bcc isEqualToString:@""]) {
        self.txt_bcc.text = self.str_prev_bcc;
        self.str_prev_bcc = @"";
    }
    
    NSString *str2 = self.txt_cc.text;
    NSString *str = self.to.text;
    NSString *str3 = self.txt_bcc.text;
    
    if (str.length > 0 && [self.userIsEditindToField isEqualToString:@"0"]) {
        self.to.text = [str substringToIndex:str.length-1];
    }
    else if (str2.length > 0 && [self.userIsEditindToField isEqualToString:@"1"]) {
        self.txt_cc.text = [str2 substringToIndex:str2.length-1];
    }
    else if (str3.length > 0 && [self.userIsEditindToField isEqualToString:@"2"]) {
        self.txt_bcc.text = [str3 substringToIndex:str3.length-1];
    }
    
    
    
    NSString *strpick;
    //NSString *strdel=[NSString stringWithFormat:@"%@",delivery.text];
    strpick=[NSString stringWithFormat:@"%@",self.stradd1];
    //strdel=[NSString stringWithFormat:@"%@",stradd1];
    
    NSLog(@"string got: to: %@ cc: %@", strpick, self.str_cc);
    
    
    if ([strpick isEqualToString:@"(null)"]  ) {
        self.to.text=@"";
    }
    else
    {
        if ([self.to.text isEqualToString:@""]) {
            self.to.text = strpick;
        }
        else if (strpick.length < 1) {
            NSLog(@"dhuklo1");
            self.to.text = self.to.text ;
        }
        else  {
            
            self.to.text = [self.to.text stringByAppendingString:[NSString stringWithFormat:@", %@", strpick]];
        }
    }
    
    if ([self.str_cc isEqualToString:@"(null)"]) {
        self.txt_cc.text = @"";
    }
    
    else
    {
        if ([self.txt_cc.text isEqualToString:@""]) {
            self.txt_cc.text = self.str_cc;
        }
        else if (self.str_cc.length < 1) {
            NSLog(@"dhuklo2");
            self.txt_cc.text = self.txt_cc.text;
        }
        else  {
            self.txt_cc.text = [self.txt_cc.text stringByAppendingString:[NSString stringWithFormat:@", %@", self.str_cc]];
        }
    }
    
    if ([self.str_bcc isEqualToString:@"(null)"]) {
        self.txt_cc.text = @"";
    }
    
    else
    {
        if ([self.txt_bcc.text isEqualToString:@""]) {
            self.txt_bcc.text = self.str_bcc;
        }
        else if (self.str_bcc.length < 1) {
            NSLog(@"dhuklo3");
            self.txt_bcc.text = self.txt_bcc.text;
        }
        else  {
            self.txt_bcc.text = [self.txt_bcc.text stringByAppendingString:[NSString stringWithFormat:@", %@", self.str_bcc]];
        }
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)addgroup:(id)sender
{
    
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
//    ComposeAddGroup * vc = [storyboard instantiateViewControllerWithIdentifier:@"ComposeAddGroup"];
//    // vc.dic=dic;
//    
//    // vc.dic_techinfo=dic_techinfo;
//    
//    
//    
//    [self.navigationController pushViewController:vc animated:NO];
    
    
}




- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView==self.msg_view) {
        
        
        [self animateTextField1:self.msg_view up:YES];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if (textView==self.msg_view) {
        [self animateTextField1:self.msg_view up:NO];
    }
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


-(IBAction)send_msg:(id)sender
{
    [self savedataongroups];
}
-(IBAction)cancel:(id)sender
{
    
}

- (void)dodesignsforTextViews:(UITextView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    disview.clipsToBounds = YES;
}

- (void)dodesignforHeaders:(UITextField *)disview
{
    // [disview.layer setBorderColor:[[UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.00f]CGColor]];
    //[disview.layer setBorderWidth:1.0f];
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.620f green:0.620f blue:0.620f alpha:1.00f] CGColor]];
    [disview.layer setBorderWidth:1.0f];
    [disview.layer setCornerRadius:1.5f];
    
}
- (void)dodesignforHeaders1:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.00f]CGColor]];
    [disview.layer setBorderWidth:1.0f];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str=@"bcc";
    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    //    if (isBackSpace == -8) {
    //        NSLog(@"Backspace was pressed");
    //    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SearchVC * svc = [storyboard instantiateViewControllerWithIdentifier:@"searchh"];
    if (isBackSpace != -8 ) {
        if (textView == self.to && ![text isEqualToString:@"\n"]) {
            svc.str_v = str;
            svc.str_search = text;
            svc.flag_field = @"to";
            
            [self.navigationController pushViewController:svc animated:YES];
            //return YES;
        }
        else if (textView == self.txt_cc && ![text isEqualToString:@"\n"])
        {
            
            // vc.dic_techinfo=dic_techinfo;
            svc.flag_field = @"cc";
            svc.str_v = str;
            svc.str_search = text;
            [self.navigationController pushViewController:svc animated:YES];
        }
        else if (textView == self.txt_bcc && ![text isEqualToString:@"\n"])
        {
            
            // vc.dic_techinfo=dic_techinfo;
            svc.flag_field = @"bcc";
            svc.str_v = str;
            svc.str_search = text;
            [self.navigationController pushViewController:svc animated:YES];
        }
        
        
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}
#pragma mark - Tabbar


-(IBAction)report:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    S_ReportViewController * report=[[S_ReportViewController alloc]init];
    report=[sb instantiateViewControllerWithIdentifier:@"rprt"];
    
    //report.sel_mp=period123;
    
    
    [self.navigationController pushViewController:report animated:YES];
    
    
    
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"msg" bundle:nil];
//    msg1*obj = [sb instantiateViewControllerWithIdentifier:@"msg1"];
//    [self.navigationController pushViewController:obj animated:YES];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings"bundle:nil];
//    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
//    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
//    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
//    [self.navigationController pushViewController:obj animated:YES];
}

-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag =  60;
    self.txt_selectGroup.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.txt_selectGroup.inputAccessoryView = mypickerToolbar;
    
}


-(void)pickerDoneClicked1
{
    [self.txt_selectGroup resignFirstResponder];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        return array_groups.count;
        
    }
    else if (pickerView == self.class_picker)
    {
        return array_course_period_info.count;
    }
    
    
    if (selectcustomerpicker.tag==7) {
        return course_period_title.count;
    }
    return 0;
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        return [[array_groups objectAtIndex:row] objectForKey:@"GROUP_NAME"];
    }
    else if (pickerView == self.class_picker) {
        return [[array_course_period_info objectAtIndex:row] objectForKey:@"TITLE"];
    }
    
    if (selectcustomerpicker.tag==7) {
        return  [course_period_title objectAtIndex:row];
    }

    
    
    
    
    return nil;
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    if (pickerView == selectcustomerpicker) {
        self.txt_selectGroup.text =(NSString*)[[array_groups objectAtIndex:row] objectForKey:@"GROUP_NAME"];
        str_selectedgroupID = (NSString*)[[array_groups objectAtIndex:row] objectForKey:@"GROUP_ID"];
    }
    else if (pickerView == self.class_picker)
    {
        tempDict = [[NSMutableDictionary alloc]init];
        tempDict = [array_course_period_info objectAtIndex:row];
    }
    
    
    
    if (selectcustomerpicker.tag==7) {
        inbox_data =(NSString *)[course_period_title objectAtIndex:row];
        _txt_compose.text=inbox_data;
        term_flag=@"1";
        
    }

    
    
    
}

-(IBAction)action_gonow:(id)sender
{
//    [self action_closeSelect:nil];
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"msg" bundle:[NSBundle mainBundle]];
//    ComposeForClassController *obj = [sb instantiateViewControllerWithIdentifier:@"ComposeForClassController"];
//    
//    obj.mainDict = tempDict;
//    obj.str_To = self.to.text;
//    obj.str_prev_cc = self.txt_cc.text;
//    obj.str_prev_bcc = self.txt_bcc.text;
//    
//    [self.navigationController pushViewController:obj animated:YES];
    
}
- (IBAction)action_closeSelect:(id)sender {
    [self.view_onlongpress setHidden:YES];
    [self.view sendSubviewToBack:self.view_onlongpress];
}

- (IBAction)action_messageMyClass:(UIButton *)sender {
    
    [self.class_picker reloadAllComponents];
    [self.view_sublongpress setAlpha:1.0f];
    [self.view_onlongpress setHidden:NO];
    [self.view bringSubviewToFront:self.view_onlongpress];
    //    [self.view addSubview:self.view_onlongpress];
    [self.class_picker reloadAllComponents];
    
}


- (void)savedataongroups
{
    
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/send_mail.php?staff_id=2&school_id=1&syear=2015&mail_details=
    
    /*
     
     [{
     
     "txtToUser":"allen,smith,dlauth,gharden,hmessier,admin",
     "groups":"",
     "cp_id":"",
     "list_gpa_student":"",
     "list_gpa_parent":"",
     "txtToCCUser":"zsarratt",
     "txtToBCCUser":"os4ed",
     "txtSubj":"Test Subject 1",
     "txtBody":"Test Body 1",
     "attachments":[{"name":"",
     "content":""}]
     }]
     
     */
    
    // NSString *cmt,*point;
    NSMutableArray *mail_detail = [[NSMutableArray alloc]init];
    
    NSMutableArray *attachment = [[NSMutableArray alloc]init];
    NSMutableDictionary *dic_atach = [[NSMutableDictionary alloc]init];
    [dic_atach setObject:@"" forKey:@"name"];
    [dic_atach setObject:@"" forKey:@"content"];
    [attachment addObject:dic_atach];
    
    NSMutableDictionary *dic_maildetail = [[NSMutableDictionary alloc]init];
    
    NSString *str_tousr = [_to.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@" To users string: %@", str_tousr);
    
    
    
    
    
    [dic_maildetail setObject:str_tousr forKey:@"txtToUser"];
    
    
    [dic_maildetail setObject:str_selectedgroupID forKey:@"groups"];
    
    
    //    //[dic_maildetail setObject:cp_id forKey:@"cp_id"];
    //
    //   // [dic_maildetail setObject:list_gpa_teacher forKey:@"list_gpa_teacher"];
    //
    //   // [dic_maildetail setObject:list_gpa_parent forKey:@"list_gpa_parent"];
    //
    NSString *txtToCCUser = [_txt_cc.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [dic_maildetail setObject:txtToCCUser forKey:@"txtToCCUser"];
    
    NSString *txtToBCCUser = [self.txt_bcc.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    [dic_maildetail setObject:txtToBCCUser forKey:@"txtToBCCUser"];
    
    NSString *txtSubj = _from.text;
    
    [dic_maildetail setObject:txtSubj forKey:@"txtSubj"];
    
    NSString *txtBody = _msg_view.text;
    
    [dic_maildetail setObject:txtBody forKey:@"txtBody"];
    
    [dic_maildetail setObject:attachment forKey:@"attachments"];
    
    [mail_detail addObject:dic_maildetail];
    NSLog(@"mail detail----%@",mail_detail);
    NSString * str111;// = [Base64 encode:data];
    str111=[mail_detail JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
    
    // NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    //NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    //NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    
    //    http://107.170.94.176/openSIS_CE6_Mobile/webservice/send_mail.php?staff_id=2&school_id=1&syear=2015&mail_details=
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/student/stu_send_mail.php"];
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,urlStr];
    
    NSLog(@"----%@",url12);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url12]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  patameter image
    // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"student_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[student_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"school_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[s_year_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"syear\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[s_year dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mail_details\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
    
    [self alertmsg:[NSString stringWithFormat:@"%@",[datadic objectForKey:@"msg"]]];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self action_cancel:nil];
    
}



- (IBAction)action_cancel:(id)sender {
    NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:3] animated:YES];
}


-(void)alertmsg:(NSString*)msg
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
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
