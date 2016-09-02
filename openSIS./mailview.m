//
//  mailview.m
//  openSiS
//
//  Created by EjobIndia on 22/12/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "mailview.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "att.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

#import "ip_url.h"
#import "AppDelegate.h"

@interface mailview ()<UIActionSheetDelegate>
{

    IBOutlet UILabel *send_msg,*recv_msg,*date1;
    int  incdecheight;
    
    NSMutableArray *arry_attach;
    int multiheight;
    // for setting view size
    int totalheight;
    // for setting setup view size
    int totalheight2;
    NSURLConnection *myConnection;
    IBOutlet UILabel *DATE_TIME;
}

@end

@implementation mailview

- (void)viewDidLoad {
    [super viewDidLoad];
    
    text_visew.frame=CGRectMake(8, 164, 304, 352);
   
    arry_attach=[[NSMutableArray alloc]init];
    if (self.view.frame.size.height == 568) {
        incdecheight = 30;
    }
    else if (self.view.frame.size.height == 667)
    {
        incdecheight = 35;
    }
    else if (self.view.frame.size.height == 736)
    {
        incdecheight = 39;
    }
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    flag=0;
    top_view.hidden=YES;
    
    ppt_view.frame=CGRectMake(-1,
                              110,
                              ppt_view.frame.size.width,
                             ppt_view.frame.size.height);

    [self loaddata];
    // Do any additional setup after loading the view.
    
   
  
  
}


- (void)replymail
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(reply) withObject:nil afterDelay:1.0];
        });
    });
    
}




-(void)trashdata
{
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/trash.php?staff_id=2&school_id=1&syear=2015&view=inbox&mail_ids=10
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/trash.php?staff_id=%@&school_id=%@&syear=%@&view=%@&mail_ids=%@",STAFF_ID_K,school_id1,year_id,self.view_select,self.MAIL_ID];
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
        //  NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        //    NSLog(@"str_123-----%@",str_123);
        //  if([str_123 isEqualToString:@"1"])
        
        
        
        //  {
        //  [self loaddata];
        //  [cellindex removeAllObjects];
        //self.ary_data1=[dictionary1 objectForKey:@"group_info"];
        // [mtable reloadData];
        //   }
        
        
        //  else
        //  {
        //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
        //     lbl_show.hidden=NO;
        //    mtable.hidden=YES;
        //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
        //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
        // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        // [alert show];
        
        
        
        //  }
        
        // [self loaddata];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        // transparentView.hidden=NO;
        //   NSLog(@"ok----");
        // [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}






- (void)calldelete
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(trashdata) withObject:nil afterDelay:1.0];
        });
    });
    
}








-(void)reply
{
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/trash.php?staff_id=2&school_id=1&syear=2015&view=inbox&mail_ids=10
    
    
  //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/compose_mail_view.php?staff_id=2&school_id=1&syear=2015&mp_type=QTR&mp_id=16&action_type=reply&mail_id=1
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
     NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
     NSString *mp_type=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"marking_period_type"]];
  //  UserMP
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/compose_mail_view.php?staff_id=%@&school_id=%@&syear=%@&mp_type=%@&mp_id=%@&action_type=reply&mail_id=%@",STAFF_ID_K,school_id1,year_id,mp_type,mp_id,self.MAIL_ID];
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
        //  NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        //    NSLog(@"str_123-----%@",str_123);
        //  if([str_123 isEqualToString:@"1"])
        
        
        
        //  {
      //  [self loaddata];
      //  [cellindex removeAllObjects];
        //self.ary_data1=[dictionary1 objectForKey:@"group_info"];
       // [mtable reloadData];
        //   }
        
        
        //  else
        //  {
        //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
        //     lbl_show.hidden=NO;
        //    mtable.hidden=YES;
        //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
        //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
        // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        // [alert show];
        
        
        
        //  }
        
        // [self loaddata];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
       // transparentView.hidden=NO;
     //   NSLog(@"ok----");
       // [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}




- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{


    if (buttonIndex==0) {
        NSLog(@"cancel");
        
        
        [self replymail];
    }
    
    else if (buttonIndex==1)
    {
    
        [self calldelete];
    
    }
    
    
    else
    {
    
    
    }

}










-(IBAction)extra:(id)sender
{

    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Reply",@"Delete", nil];
    [action showInView:self.view];

}






-(void)viewWillAppear:(BOOL)animated
{
    // eta gradebook view er height set korar jonno
    
//    if (self.view.frame.size.height == 568) {
//        multiheight = 26;
//    }
//    else if (self.view.frame.size.height == 667)
//    {
//        multiheight = 30;
//    }
//    else if (self.view.frame.size.height == 736)
//    {
//        multiheight = 33;
//    }
//    
//    int k2 = (int)arry_attach.count;
//    totalheight = k2 * multiheight;
//    CGRect rec = ppt_view.frame;
//    rec.size.height = totalheight;
//    [ppt_view setFrame:rec];
//    
    
    
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



-(IBAction)open:(id)sender
{
    
    

    
    if (flag==1) {
        
         top_view.hidden=NO;
        
        
        [UIView animateWithDuration:0.5f animations:^{
        
         
        
                      top_view.frame =
               CGRectMake( top_view.frame.origin.x,
                           top_view.frame.origin.y ,
                           top_view.frame.size.width,
                        top_view.frame.size.height);
        
        
                ppt_view.frame=CGRectMake(0,
                                         177 ,
                                         ppt_view.frame.size.width,
                                         ppt_view.frame.size.height);
           }];
        
    
  text_visew.frame=CGRectMake(8, 235, 304, 250);
        flag=0;
        
    }
    
    else
    {
    
        top_view.hidden=YES;
        [UIView animateWithDuration:0.5f animations:^{
            

        ppt_view.frame=CGRectMake(-1,
                                  110,
                                  ppt_view.frame.size.width,
                                  ppt_view.frame.size.height);
              }];
    
        
          text_visew.frame=CGRectMake(8, 177, 304, 334);
        flag=1;
    
    }



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loaddata
{
   // transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        });
    });
    
    
}
-(void)loaddata1
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];

   // AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
 //   NSString *school_id123456=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/mail_body.php?staff_id=%@&school_id=%@&syear=%@&mail_id=%@",STAFF_ID_K,school_id1,year_id,self
                             .MAIL_ID];
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
            
            
            NSString *str_date_value=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"MAIL_DATETIME"]];
         //   NSString *str_date_value=[NSString stringWithFormat:@"%@",[[self.ary_data1 objectAtIndex:indexPath.row]objectForKey:@"MAIL_DATE"]];
            NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
            [dateformat setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
            NSDate *datefor=[dateformat dateFromString:str_date_value];
            
            NSLog(@"DATEFOR---%@",datefor);
            [dateformat setDateFormat:@"MMM,dd yyyy hh:mm:ss"];
            NSString *dateStr=[dateformat stringFromDate:datefor];

            DATE_TIME.text=dateStr;
            send_msg.text=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"FROM"]];
            recv_msg.text=[NSString stringWithFormat:@"to %@",[dictionary1 objectForKey:@"TO_MULTIPLE_USERS"]];
            
            rece_name.text=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"TO_MULTIPLE_USERS"]];
            lbl_id.text=[self nullChecker:[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"TO_CC_MULTIPLE"]]];
            BCC.text=[self nullChecker:[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"TO_BCC_MULTIPLEE"]]];
             arry_attach=[dictionary1 objectForKey:@"ATTACHMENTS"];
            [self.table_setup reloadData];
            msg_name.text=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"MAIL_SUBJECT"]];
            NSString *HRTML_STRING=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"MAIL_BODY"]];
          //  HRTML_STRING=[self stringByStrippingHTML];
            
          //  NSString *html = @"S.Panchami 01.38<br>Arudra 02.01<br>V.08.54-10.39<br>D.05.02-06.52<br> <font color=red><u>Festival</u></font><br><font color=blue>Shankara Jayanthi<br></font>";
            NSAttributedString *attr = [[NSAttributedString alloc] initWithData:[HRTML_STRING dataUsingEncoding:NSUTF8StringEncoding]
                                                                        options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                  NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)}
                                                             documentAttributes:nil
                                                                          error:nil];
          //  NSLog(@"html: %@", html);
            NSLog(@"attr: %@", attr);
            NSLog(@"string: %@", [attr string]);
            NSString *finalString = [attr string];

            text_visew.text=finalString;
        }
        
        
        else
        {
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
           // lbl_show.hidden=NO;
          //  mtable.hidden=YES;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
   //     transparentView.hidden=NO;
        NSLog(@"ok----");
       // [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}

- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}


-(NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s;// = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}
#pragma mark - Table Delegate and Datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
       str = @"http://107.170.94.176/openSIS_CE6_Mobile/assets/teacher_144895422013Allow%20Teacher%20GradeScale.pptx";
    NSLog(@"str------%@",str);
   // NSURL *myUrl = [NSURL URLWithString:str];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSURLRequest *myRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    myData = [[NSMutableData alloc] initWithLength:0];
    myConnection = [[NSURLConnection alloc] initWithRequest:myRequest delegate:self startImmediately:YES];
    
    
   
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [myData setLength:0];
    
    NSLog(@"-----%@",response);
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [myData appendData:data];

}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Get file from URL failed");
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   NSLog(@"Got file from URL");
    
    NSData *file;
//file = ...
    NSString *path;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 //   path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"SomeDirectoryName"];
   // path = [path stringByAppendingPathComponent:@"SomeFileName"];
    
    [[NSFileManager defaultManager] createFileAtPath:nil
                                            contents:myData
                                          attributes:nil];

    



    //download finished - data is available in myData.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  arry_attach.count;
}

- (att *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
   att *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    {
        cell = (att*)[[[NSBundle mainBundle] loadNibNamed:@"att" owner:self options:nil ]objectAtIndex:0];
      cell.clipsToBounds = YES;
        NSString *str = [NSString stringWithFormat:@"%@",[[arry_attach objectAtIndex:indexPath.row]objectForKey:@"file_path"]];
   
        cell.lbl_txt.text=str;
    }
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 27.0f;
}





-(IBAction)back:(id)sender
{


    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark Tabbar
-(IBAction)home:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
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




@end
