//
//  Msg_compose_ViewController.m
//  openSiS
//
//  Created by os4ed on 4/4/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "Msg_compose_ViewController.h"

#import "MsgViewController.h"
#import "CCViewController.h"
#import "SearchVC.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "BccViewController.h"
#import "OutboxViewController.h"
#import "S_composeforgroupViewController.h"
#import "S_addgrpcomposeViewController.h"
#import "S_TrashViewController.h"
#import "S_msg_groupViewController.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"





@interface Msg_compose_ViewController ()


{

   UIPickerView *selectcustomerpicker;
    IBOutlet UITextField * courseperiodName;
    
    
    
}

@end

@implementation Msg_compose_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self courseperiod123];
    course_period_title=[[NSMutableArray alloc]initWithObjects:@"Inbox",@"Outbox",@"Groups",@"Trash", nil];
    [self dodesignsforTextViews:to];
    [self dodesignforHeaders:from];
    [self dodesignsforTextViews:msg_view];
     str_selectedgroupID = @"";
    //[self dodesignforHeaders1:header_view];

    
}




-(IBAction)report:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    S_ReportViewController * report=[[S_ReportViewController alloc]init];
    report=[sb instantiateViewControllerWithIdentifier:@"rprt"];
    
    //report.sel_mp=period123;
    
    
    [self.navigationController pushViewController:report animated:YES];
    
    
    
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

-(IBAction)compose_back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
//    MsgViewController *mgc =[[MsgViewController alloc]init];
//    mgc=[sb instantiateViewControllerWithIdentifier:@"msg"];
//    [self.navigationController popToViewController:mgc animated:YES];
//   

}




-(void)viewWillAppear:(BOOL)animated
{
    NSString *str = to.text;
    
    if (str.length > 0 && [self.userIsEditindToField isEqualToString:@"0"]) {
        to.text = [str substringToIndex:str.length-1];
    }
    
    NSString *strpick;
    //NSString *strdel=[NSString stringWithFormat:@"%@",delivery.text];
    strpick=[NSString stringWithFormat:@"%@",self.stradd1];
    //strdel=[NSString stringWithFormat:@"%@",stradd1];
    
    NSLog(@"string got: to: %@ ", strpick);
    
    
    if ([strpick isEqualToString:@"(null)"]  ) {
        to.text=@"";
    }
    else
    {
        if ([to.text isEqualToString:@""]) {
            to.text = strpick;
        }
        else if (strpick.length < 1) {
            NSLog(@"dhuklo1");
            to.text = to.text ;
        }
        else  {
            
            to.text = [to.text stringByAppendingString:[NSString stringWithFormat:@", %@", strpick]];
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
    
    NSString *str_tousr = [to.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@" To users string: %@", str_tousr);
    
    [dic_maildetail setObject:str_tousr forKey:@"txtToUser"];
    
    
    [dic_maildetail setObject:str_selectedgroupID forKey:@"groups"];
    
    
//    //[dic_maildetail setObject:cp_id forKey:@"cp_id"];
//    
//   // [dic_maildetail setObject:list_gpa_teacher forKey:@"list_gpa_teacher"];
//    
//   // [dic_maildetail setObject:list_gpa_parent forKey:@"list_gpa_parent"];
//    
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *str=@"1";
    const char * _char = [text cStringUsingEncoding:NSUTF8StringEncoding];
    int isBackSpace = strcmp(_char, "\b");
    
    //    if (isBackSpace == -8) {
    //        NSLog(@"Backspace was pressed");
    //    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SearchVC * svc = [storyboard instantiateViewControllerWithIdentifier:@"searchh"];
    if (isBackSpace != -8 ) {
        if ( textView== to && ![text isEqualToString:@"\n"]) {
            svc.str_v = str;
            svc.str_search = text;
            svc.flag_field = @"to";
            
            [self.navigationController pushViewController:svc animated:YES];
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
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
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
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
            S_msg_groupViewController *mgc = [sb instantiateViewControllerWithIdentifier:@"groupp"];
            [self.navigationController pushViewController:mgc animated:YES];

            
        }
        
        
    }
    else
    {
        
        
        txt_compose.text=@"Compose";
        
        
        
        
    }
    
    
    
}

-(IBAction)home:(id)sender
{
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SdashboardViewController *home=[[SdashboardViewController alloc]init];
    home=[sb instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:home animated:NO];
    
    
    
    
    
}

-(IBAction)addgrp:(id)sender
{
    
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
    S_addgrpcomposeViewController *mg = [sb instantiateViewControllerWithIdentifier:@"addgroup"];
    [self.navigationController pushViewController:mg animated:YES];
    
    
    
}


-(IBAction)btnsend:(id)sender
{
    
    [self savedataongroups];
    
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

-(IBAction)cc:(id)sender
{

    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    CCViewController *ccv=[[CCViewController alloc]init];
    ccv=[sb instantiateViewControllerWithIdentifier:@"cc"];
    [self.navigationController pushViewController:ccv animated:NO];
    

}

-(IBAction)bcc:(id)sender
{
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    BccViewController *bccv=[[BccViewController alloc]init];
    bccv=[sb instantiateViewControllerWithIdentifier:@"s_bcc"];
    [self.navigationController pushViewController:bccv animated:NO];
    
    
    
    
    
    
    
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
