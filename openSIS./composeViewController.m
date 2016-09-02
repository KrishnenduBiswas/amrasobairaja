//
//  composeViewController.m
//  openSiS
//
//  Created by EjobIndia on 06/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "composeViewController.h"
#import "cc.h"
#import  "searchViewController.h"
#import "composeViewController.h"
#import "Bcc.h"
#import "ComposeAddGroup.h"
#import "TeacherDashboardViewController.h"


#import "AppDelegate.h"
#import "ip_url.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "out1.h"
#import "mailview.h"
#import "msg1.h"
#import "trash1.h"
#import "MessageGroupController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface composeViewController ()<UITextViewDelegate>

@end

@implementation composeViewController
{
    UIPickerView *selectcustomerpicker;
    NSMutableArray *array_groups;
    NSString *str_selectedgroupID;
    NSMutableArray *array_course_period_info;
    NSMutableDictionary *tempDict;
    NSString *cp_id;
    NSString *list_gpa_student;
    NSString *list_gpa_parent;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    
    
    return course_period_title.count;
    
    
    
    
    
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return [course_period_title objectAtIndex:row];
    
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    
    
    
    
    inbox_data =(NSString *)[course_period_title objectAtIndex:row];
    
    term_flag=@"1";
    
    
    
    
    
}
-(void)pickerDoneClicked1
{
    
    txt_compose.text=inbox_data;
    [txt_compose resignFirstResponder];
    if ([term_flag isEqualToString:@"1"]) {
        if ([inbox_data isEqualToString:@"Outbox"]) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"msg" bundle:[NSBundle mainBundle]];
            out1 *mgc = [sb instantiateViewControllerWithIdentifier:@"out"];
            [self.navigationController pushViewController:mgc animated:NO];
            
        }
        
        else    if ([inbox_data isEqualToString:@"Inbox"]) {
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"msg" bundle:[NSBundle mainBundle]];
            msg1 *mgc = [sb instantiateViewControllerWithIdentifier:@"msg1"];
            [self.navigationController pushViewController:mgc animated:NO];
            
        }
        
        else  if ([inbox_data isEqualToString:@"Groups"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"msg" bundle:[NSBundle mainBundle]];
            MessageGroupController *mgc = [sb instantiateViewControllerWithIdentifier:@"msggroups"];
            [self.navigationController pushViewController:mgc animated:YES];
        }
        
        else
        {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
            composeViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"compose"];
            // vc.dic=dic;
            
            // vc.dic_techinfo=dic_techinfo;
            
            
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        
    }
    else
    {
    
       
           txt_compose.text=@"Compose";
            
       
        
    
    }
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self courseperiod123];
   // [self dodesignforHeaders:to];
    str_selectedgroupID = @"";
    cp_id = @"";
    list_gpa_student = @"";
    list_gpa_parent = @"";
       course_period_title=[[NSMutableArray alloc]initWithObjects:@"Inbox",@"Outbox",@"Groups",@"Trash", nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    [self dodesignsforTextViews:self.to];
    [self dodesignforHeaders:from];
    [self dodesignsforTextViews:msg_view];
    [self dodesignforHeaders1:header_view];
    
    // Do any additional setup after loading the view.
}
#pragma mark  searchbardelegate
/*- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        [array_studentgrades removeAllObjects];
        [array_studentgrades addObjectsFromArray:allItemsArray];
        
    } else {
        [array_studentgrades removeAllObjects];
        
        
        NSLog(@"----......-----%@",allItemsArray);
        for (NSDictionary *item in allItemsArray) {
            NSString *string = [item objectForKey:@"FULL_NAME"];
            NSRange range = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [array_studentgrades addObject:item];
            }
            
            
            else
            {
                
                NSLog(@"not found");
                
            }
        }
    }
    
    
    [self.tablev reloadData];
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [theSearchBar resignFirstResponder];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [theSearchBar resignFirstResponder];
    [searchBar resignFirstResponder];
    
}*/



-(IBAction)cc:(id)sender
{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
    cc * vc = [storyboard instantiateViewControllerWithIdentifier:@"cc1"];
       vc.str_To = self.to.text;
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}
-(IBAction)bcc:(id)sender
{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
    Bcc * vc = [storyboard instantiateViewControllerWithIdentifier:@"Bcc"];
    // vc.dic=dic;
    vc.str_To = self.to.text;
    // vc.dic_techinfo=dic_techinfo;
    
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}
-(IBAction)addgroup:(id)sender
{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
    ComposeAddGroup * vc = [storyboard instantiateViewControllerWithIdentifier:@"ComposeAddGroup"];
    // vc.dic=dic;
    vc.str_To = self.to.text;
    // vc.dic_techinfo=dic_techinfo;
    
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    
//    if([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    
//    return YES;
//}




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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str=@"1";
    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    //    if (isBackSpace == -8) {
    //        NSLog(@"Backspace was pressed");
    //    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
    searchViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"search"];
    if (isBackSpace != -8 ) {
        if (textView == self.to && ![text isEqualToString:@"\n"]) {
            vc.str_v = str;
            vc.str_search = text;
            vc.flag_field = @"to";
            
            [self.navigationController pushViewController:vc animated:YES];
            //return YES;
        }
//        else if (textView == self.txt_cc && ![text isEqualToString:@"\n"])
//        {
//            
//            // vc.dic_techinfo=dic_techinfo;
//            vc.flag_field = @"cc";
//            vc.str_v = str;
//            vc.str_search = text;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        else if (textView == self.txt_bcc && ![text isEqualToString:@"\n"])
//        {
//            
//            // vc.dic_techinfo=dic_techinfo;
//            vc.flag_field = @"bcc";
//            vc.str_v = str;
//            vc.str_search = text;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        
        
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    txt_compose.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
        txt_compose.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
//    int isBackSpace = strcmp(_char, "\b");
//    
////    if (isBackSpace == -8) {
////        NSLog(@"Backspace was pressed");
////    }
//    
//    if (textView == to && isBackSpace != -8 && ![text isEqualToString:@"\n"]) {
//        NSString *str=@"1";
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
//        searchViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"search"];
//        // vc.dic=dic;
//        
//        // vc.dic_techinfo=dic_techinfo;
//        
//        vc.str_v = str;
//        vc.str_search = text;
//        vc.flag_field = @"to";
//        //to.text = [textView.text stringByPaddingToLength:textView.text.length-1 withString:@"." startingAtIndex:0];
//        to.text = [textView.text substringToIndex:to.text.length];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        //return YES;
//    }
//    if ([text isEqualToString:@"\n"]) {
//          [textView resignFirstResponder];
//        
//        return NO;
//    }
//    
//    return YES;
//}
//

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
  //  NSString *str=@"1";
    if (textView==msg_view) {
        
   
    [self animateTextField1:msg_view up:YES];
    }
    
    if (textView==self.to) {
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
//       searchViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"search"];
//        // vc.dic=dic;
//        
//        // vc.dic_techinfo=dic_techinfo;
//        
//         vc.str_v=str;
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
      if (textView==msg_view) {
    [self animateTextField1:msg_view up:NO];
      }
}
- (IBAction)action_totheSearch:(id)sender {
//     NSString *str=@"1";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
//    searchViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"search"];
//    // vc.dic=dic;
//    
//    // vc.dic_techinfo=dic_techinfo;
//    
//    vc.str_v = str;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *str = self.to.text;

    if (str.length > 0 && [self.userIsEditindToField isEqualToString:@"0"]) {
        self.to.text = [str substringToIndex:str.length-1];
    }
    
    NSString *strpick;
    //NSString *strdel=[NSString stringWithFormat:@"%@",delivery.text];
    strpick=[NSString stringWithFormat:@"%@",self.stradd1];
    //strdel=[NSString stringWithFormat:@"%@",stradd1];
    
   NSLog(@"string got: to: %@ ", strpick);
    
    
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
    
//    if ([self.str_cc isEqualToString:@"(null)"]) {
//        self.txt_cc.text = @"";
//    }
//    
//    else
//    {
//        if ([self.txt_cc.text isEqualToString:@""]) {
//            self.txt_cc.text = self.str_cc;
//        }
//        else if (self.str_cc.length < 1) {
//            NSLog(@"dhuklo2");
//            self.txt_cc.text = self.txt_cc.text;
//        }
//        else  {
//            self.txt_cc.text = [self.txt_cc.text stringByAppendingString:[NSString stringWithFormat:@", %@", self.str_cc]];
//        }
//    }
//    
//    if ([self.str_bcc isEqualToString:@"(null)"]) {
//        self.txt_cc.text = @"";
//    }
//    
//    else
//    {
//        if ([self.txt_bcc.text isEqualToString:@""]) {
//            self.txt_bcc.text = self.str_bcc;
//        }
//        else if (self.str_bcc.length < 1) {
//            NSLog(@"dhuklo3");
//            self.txt_bcc.text = self.txt_bcc.text;
//        }
//        else  {
//            self.txt_bcc.text = [self.txt_bcc.text stringByAppendingString:[NSString stringWithFormat:@", %@", self.str_bcc]];
//        }
//    }
    
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

-(void)alertmsg:(NSString*)msg
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)dodesignforHeaders1:(UIView *)disview
{
    [disview.layer setBorderColor:[[UIColor colorWithRed:0.816f green:0.816f blue:0.816f alpha:1.00f]CGColor]];
    [disview.layer setBorderWidth:1.0f];
    
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
    
    NSString *str_tousr = [self.to.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@" To users string: %@", str_tousr);
    
    [dic_maildetail setObject:str_tousr forKey:@"txtToUser"];
    
    
    [dic_maildetail setObject:str_selectedgroupID forKey:@"groups"];
    
    
    [dic_maildetail setObject:cp_id forKey:@"cp_id"];
    
    [dic_maildetail setObject:list_gpa_student forKey:@"list_gpa_student"];
    
    [dic_maildetail setObject:list_gpa_parent forKey:@"list_gpa_parent"];
    
    NSString *txtToCCUser = @"";
    
    [dic_maildetail setObject:txtToCCUser forKey:@"txtToCCUser"];
    
    NSString *txtToBCCUser = @"";
    
    [dic_maildetail setObject:txtToBCCUser forKey:@"txtToBCCUser"];
    
    NSString *txtSubj = from.text;
    
    [dic_maildetail setObject:txtSubj forKey:@"txtSubj"];
    
    NSString *txtBody = msg_view.text;
    
    [dic_maildetail setObject:txtBody forKey:@"txtBody"];
    
    [dic_maildetail setObject:attachment forKey:@"attachments"];
    
    [mail_detail addObject:dic_maildetail];
    
    NSString * str111;// = [Base64 encode:data];
    str111=[mail_detail JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
    
    // NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    //NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    
    //    http://107.170.94.176/openSIS_CE6_Mobile/webservice/send_mail.php?staff_id=2&school_id=1&syear=2015&mail_details=
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/send_mail.php"];
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
    // school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=
    
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
- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
