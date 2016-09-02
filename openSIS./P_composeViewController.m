//
//  composeViewController.m
//  openSiS
//
//  Created by EjobIndia on 06/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "P_composeViewController.h"
#import "P_cc.h"
#import "P_searchViewController.h"
#import "P_composeViewController.h"
#import "P_Bcc.h"
//#import "P_ComposeAddGroup.h"
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
//#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "P_out1.h"
//#import "P_mailview.h"
#import "P_msg1.h"
#import "P_trash1.h"
#import "P_MessageGroupController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "P_msg1.h"
#import "TeacherDashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_composeViewController.h"
#import "P_SettingViewController.h"

@interface P_composeViewController ()<UITextViewDelegate>

@end

@implementation P_composeViewController
{
    UIPickerView *selectcustomerpicker;
    NSMutableArray *array_groups;
    NSString *str_selectedgroupID;
    NSMutableArray *array_course_period_info;
    NSMutableDictionary *tempDict;
    NSString *cp_id;
    NSString *list_gpa_student;
    NSString *list_gpa_parent;
    
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    
    
    
    
    
    
    
    
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
    
    
    txt_compose.text=inbox_data;
    
    term_flag=@"1";
    
    
    
    
    
}
-(void)pickerDoneClicked1
{
    
    txt_compose.text=inbox_data;
    [txt_compose resignFirstResponder];
    if ([term_flag isEqualToString:@"1"]) {
        if ([inbox_data isEqualToString:@"Outbox"]) {
            
            UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
            P_out1 * mvc=[[P_out1 alloc]init];
            mvc=[sb instantiateViewControllerWithIdentifier:@"p_out"];
            [self.navigationController pushViewController:mvc animated:NO];
        }
        
        else    if ([inbox_data isEqualToString:@"Inbox"]) {
            
            UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
            P_msg1 * mvc=[[P_msg1 alloc]init];
            mvc=[sb instantiateViewControllerWithIdentifier:@"p_msg1"];
            [self.navigationController pushViewController:mvc animated:NO];

            
        }
        
        else  if ([inbox_data isEqualToString:@"Groups"]) {
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"P_msg" bundle:[NSBundle mainBundle]];
            P_MessageGroupController *mgc = [sb instantiateViewControllerWithIdentifier:@"p_msggroups"];
            [self.navigationController pushViewController:mgc animated:YES];        }
        
        else
        {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"P_msg" bundle: nil];
            P_composeViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"p_compose"];
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
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"P_msg" bundle: nil];
    P_cc * vc = [storyboard instantiateViewControllerWithIdentifier:@"p_cc1"];
       vc.str_To = self.to.text;
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}
-(IBAction)bcc:(id)sender
{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"P_msg" bundle: nil];
    P_Bcc * vc = [storyboard instantiateViewControllerWithIdentifier:@"p_Bcc"];
    // vc.dic=dic;
    vc.str_To = self.to.text;
    // vc.dic_techinfo=dic_techinfo;
    
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
}
-(IBAction)addgroup:(id)sender
{
    
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"msg" bundle: nil];
//    P_ComposeAddGroup * vc = [storyboard instantiateViewControllerWithIdentifier:@"ComposeAddGroup"];
//    // vc.dic=dic;
//    vc.str_To = self.to.text;
//    // vc.dic_techinfo=dic_techinfo;
//    
//    
//    
//    [self.navigationController pushViewController:vc animated:NO];
    
    
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str=@"1";
    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    //    if (isBackSpace == -8) {
    //        NSLog(@"Backspace was pressed");
    //    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"P_msg" bundle: nil];
    P_searchViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"p_search"];
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ParentStoryboard" bundle: nil];
    pdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"pdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
}
-(IBAction)thirdButton:(id)sender
{
    NSLog(@"Third Button");
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_msg" bundle:nil];
    P_msg1 * mvc=[[P_msg1 alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_msg1"];
    [self.navigationController pushViewController:mvc animated:NO];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
    P_SettingViewController * mvc=[[P_SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"p_Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
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
    
    
//    [dic_maildetail setObject:cp_id forKey:@"cp_id"];
//    
//    [dic_maildetail setObject:list_gpa_student forKey:@"list_gpa_student"];
//    
//    [dic_maildetail setObject:list_gpa_parent forKey:@"list_gpa_parent"];
    
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
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];

    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    //    http://107.170.94.176/openSIS_CE6_Mobile/webservice/send_mail.php?staff_id=2&school_id=1&syear=2015&mail_details=
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/parent/parent_send_mail.php"];
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
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"parent_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[parentid dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"student_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[student_id dataUsingEncoding:NSUTF8StringEncoding]];
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
- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
