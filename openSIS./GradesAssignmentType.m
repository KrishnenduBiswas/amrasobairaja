//
//  GradesAssignmentType.m
//  openSiS
//
//  Created by os4ed on 11/17/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "GradesTotalViewController.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "GradesAssignmentType.h"
#import "TeacherDashboardViewController.h"
#import "SlideViewController.h"
#import "Gradest.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"


@interface GradesAssignmentType ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    IBOutlet UIView *baseView;
     NSMutableArray *allItemsArray,*displayItemsArray;
       IBOutlet UISearchBar *theSearchBar;
    NSString *assign_change,*str_assignmentType_id ;
    UIPickerView *  selectcustomerpicker;
    NSMutableArray *assign_types,*assign_by_type;
}

@property (strong, nonatomic) IBOutlet UIView *view_topline;
@property (strong, nonatomic) IBOutlet UIView *view_topBar;
@property (strong, nonatomic) IBOutlet UIView *view_topbar_2;

@property (strong, nonatomic) IBOutlet UIView *view_total;

- (IBAction)action_click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *text_totals;

//@property (strong, nonatomic) IBOutlet UIView *view_inactiveswitch;
@property (strong, nonatomic) IBOutlet UIView *view_info;
@property (strong, nonatomic) IBOutlet UIScrollView *view_scroll;

@property (strong, nonatomic) IBOutlet UIView *view_assignmenttype;
@property (strong, nonatomic) IBOutlet UITextField *text_assignmenttype;

@end

@implementation GradesAssignmentType

{
    SlideViewController *slide;
    int  flag,k,change,incdecheight,scroller;
    float z;
    
    int multiheight;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(IBAction)savealldata:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(savedata) withObject:nil afterDelay:0];
        });
    });


}

-(void)savedata
{
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/assignments.php?type=add_submit&staff_id=2&school_id=1&syear=2015&mp_id=16&cpv_id=1&assignment_details=[{"TITLE":"test Assignment title New","POINTS":"3","APPLY_TO_ALL":"Y","DESCRIPTION":"fgfgfg","DUE_DATE":"2015-11-22","ASSIGNED_DATE":"2015-10-23","ASSIGNMENT_TYPE_ID":"2"}]
    NSString *cmt,*point;
    
    
    NSMutableArray *arrData=[[NSMutableArray alloc]init];
    
    for(int i=0;i<[array_studentgrades count];i++)
    {
        NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
        
        NSString *str_id=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i] objectForKey:@"STUDENT_ID"]];
        cmt=[ary_com objectAtIndex:i];
        point=[array_points_value  objectAtIndex:i];
        //   NSString *str_id1=[NSString stringWithFormat:@"%@",[array_studentgrades objectAtIndex:i]];
        
        [dic3 setObject:point  forKey:@"POINTS"];
        [dic3 setObject:cmt  forKey:@"COMMENT"];
        
        [dic2 setObject:dic3 forKey:assignment_id];
        //
        [dic1 setObject:dic2 forKey:str_id];
        [arrData addObject:dic1];
    }
    
    //   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    NSString * str111;// = [Base64 encode:data];
    str111=[arrData JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
    



NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];


AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];


NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];


NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
// [AFJSONResponseSerializer serializer];
NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];





ip_url *obj123=[[ip_url alloc]init];
NSString *str123=[obj123 ipurl];

NSString *urlStr = [NSString stringWithFormat:@"/grades.php"];
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
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"assignment_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[assignment_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];


// delivery_type=%@&delivery_date=%@&delivery_time=%@&description=%@&gofor_cut=%@&distance_amout=%@",uid,pa_amt,SCH_TYPE,date,time,DES,go_cut,d_amount];

[body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"values\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];

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
    
    
    
}

else
{
    
    NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
   // [self alertmsg:msg];
    
    //UIAlertView
    
}
[MBProgressHUD hideHUDForView:self.view animated:YES];

///   UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ClassWorkViewController *obj = [sb instantiateViewControllerWithIdentifier:@"classwork"];
//
//    [self.navigationController pushViewController:obj animated:YES];






}



- (void)viewDidLoad {
    [super viewDidLoad];
     view_hidden.hidden=YES;
    search_view.hidden=YES;
    
    txtview_comment.layer.borderWidth=1.0;
    txtview_comment.layer.borderColor=[[UIColor lightGrayColor]CGColor ];
    
   str_s=@"N";
    assign_types=[[NSMutableArray alloc]init];
    assign_by_type=[[NSMutableArray alloc]init];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
  //  self.text_totals.text=[NSString stringWithFormat:@"%@",self.assign_type_name];
  //  NSLog(@"--------%@",self.assign_type_id);
    [slide setparentobject:self parentname:@"gradesassignment"];
    [self loaddata];
    [self pickerfortop];
    [self pickerfordown];
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    
    
    flag =0;k=0;z=0;change =0;
    
    
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
    
    [self dodesign];
    lbl_nodatafound.hidden = YES;
    
    
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
 
    
    
    
    
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.view.frame.size.height == 568) {
        multiheight = 32;
    }
    else if (self.view.frame.size.height == 667)
    {
        multiheight = 37;
    }
    else if (self.view.frame.size.height == 736)
    {
        multiheight = 41;
    }
    
     self.tablev.tableFooterView = [[UIView alloc]init];
    
}



-(void)open
{
    [slide open:self.view];
}
-(void)close
{
    [slide close:nil];
}

#pragma mark - Designs


-(void)dodesign
{
    [_view_total.layer setCornerRadius:1.0f];
    _view_total.clipsToBounds = YES;
    [_view_total.layer setBorderWidth:1.0f];
    _view_total.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
    [_view_assignmenttype.layer setCornerRadius:1.0f];
    _view_assignmenttype.clipsToBounds = YES;
    [_view_assignmenttype.layer setBorderWidth:1.0f];
  _view_assignmenttype.layer.borderColor = [[UIColor colorWithRed:0.200f green:0.600f blue:0.851f alpha:1.00f]CGColor];
    
    self.tablev.backgroundColor = [UIColor whiteColor];
    
    
    
}

#pragma mark - TopViewAnimation

-(IBAction)goup:(id)sender
{
    
    if (flag == 0) {
        [UIView animateWithDuration:0.5f animations:^{
            _view_topBar.frame =
            CGRectMake(_view_topBar.frame.origin.x,
                       _view_topBar.frame.origin.y - incdecheight,
                       _view_topBar.frame.size.width,
                       _view_topBar.frame.size.height);
            _view_topline.frame =
            CGRectMake(_view_topline.frame.origin.x,
                       _view_topline.frame.origin.y - incdecheight,
                       _view_topline.frame.size.width,
                       _view_topline.frame.size.height);
        
                _tablev.frame =
                CGRectMake(_tablev.frame.origin.x,
                           _tablev.frame.origin.y - multiheight,
                           _tablev.frame.size.width,
                           _tablev.frame.size.height+multiheight);
                
          
            _view_inactiveswitch.frame =
            CGRectMake(_view_inactiveswitch.frame.origin.x,
                       _view_inactiveswitch.frame.origin.y - incdecheight,
                       _view_inactiveswitch.frame.size.width,
                       _view_inactiveswitch.frame.size.height);

            _view_info.frame =
            CGRectMake(_view_info.frame.origin.x,
                       _view_info.frame.origin.y - incdecheight,
                       _view_info.frame.size.width,
                       _view_info.frame.size.height);
        }];
        flag = 1;
        
    }
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











- (IBAction)action_switch_inactive:(id)sender {
    
    if ([self.switch_inactive_students isOn]) {
      switch_flag=@"1";
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(PICKERVALUEchangeassign_type_id) withObject:nil afterDelay:2];
            });
        });
    }
    
    else
    {
        
   switch_flag=@"0";
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(SWITCHOFF) withObject:nil afterDelay:2];
            });
        });
        
    }
    
    
    
}

-(IBAction)tablengreyviewup:(id)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        
        _view_topline.frame =
        CGRectMake(_view_topline.frame.origin.x,
                   _view_topbar_2.frame.size.height,
                   _view_topline.frame.size.width,
                   _view_topline.frame.size.height);
        
        _view_inactiveswitch.frame =
        CGRectMake(_view_inactiveswitch.frame.origin.x,
                   _view_topbar_2.frame.size.height,
                   _view_inactiveswitch.frame.size.width,
                   _view_inactiveswitch.frame.size.height);
        
        _tablev.frame =
        CGRectMake(_tablev.frame.origin.x,
                   _view_topbar_2.frame.size.height + _view_inactiveswitch.frame.size.height + _view_info.frame.size.height,
                   _tablev.frame.size.width,
                   _tablev.frame.size.height+multiheight);
        
        _view_info.frame =
        CGRectMake(_view_info.frame.origin.x,
                   _view_topbar_2.frame.size.height + _view_inactiveswitch.frame.size.height,
                   _view_info.frame.size.width,
                   _view_info.frame.size.height);
        
    }];

}
-(IBAction)tablengreyviewdown:(id)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        
        _view_topline.frame =
        CGRectMake(_view_topline.frame.origin.x,
                   _view_topBar.frame.size.height,
                   _view_topline.frame.size.width,
                   _view_topline.frame.size.height);
        
        _view_inactiveswitch.frame =
        CGRectMake(_view_inactiveswitch.frame.origin.x,
                   _view_topBar.frame.size.height,
                   _view_inactiveswitch.frame.size.width,
                   _view_inactiveswitch.frame.size.height);
        
        _tablev.frame =
        CGRectMake(_tablev.frame.origin.x,
                   _view_topBar.frame.size.height + _view_inactiveswitch.frame.size.height + _view_info.frame.size.height,
                   _tablev.frame.size.width,
                   _tablev.frame.size.height-multiheight);
        
        _view_info.frame =
        CGRectMake(_view_info.frame.origin.x,
                   _view_topBar.frame.size.height + _view_inactiveswitch.frame.size.height,
                   _view_info.frame.size.width,
                   _view_info.frame.size.height);
        
    }];
    
}


-(IBAction)godown:(id)sender
{
    if (flag == 1) {
        [UIView animateWithDuration:0.5f animations:^{
            _view_topBar.frame =
            CGRectMake(_view_topBar.frame.origin.x,
                       _view_topBar.frame.origin.y + incdecheight,
                       _view_topBar.frame.size.width,
                       _view_topBar.frame.size.height);
            _view_topline.frame =
            CGRectMake(_view_topline.frame.origin.x,
                       _view_topline.frame.origin.y + incdecheight,
                       _view_topline.frame.size.width,
                       _view_topline.frame.size.height);
            
            _view_inactiveswitch.frame =
            CGRectMake(_view_inactiveswitch.frame.origin.x,
                       _view_inactiveswitch.frame.origin.y + incdecheight,
                       _view_inactiveswitch.frame.size.width,
                       _view_inactiveswitch.frame.size.height);

            _tablev.frame =
            CGRectMake(_tablev.frame.origin.x,
                       _tablev.frame.origin.y + multiheight,
                       _tablev.frame.size.width,
                       _tablev.frame.size.height-multiheight);
            
            _view_info.frame =
            CGRectMake(_view_info.frame.origin.x,
                       _view_info.frame.origin.y + incdecheight,
                       _view_info.frame.size.width,
                       _view_info.frame.size.height);
            
        }];
        flag = 0;
        
    }
    
}
-(void)setoffforscroll:(float)y
{
    if (y > z && z == 0) {
        k = 1;
        z = y;
    }
    else if ( y > z && change == 0 )
    {
        k=0;
        z = y;
    }
    else if ( y > z && change == 1 )
    {
        k=1;
        z = y;
    }
    else if (y < z )
    {
        change = 1;
        k = -1;
        z = y;
    }
    else if ( y < z)
    {
        k = 0;
        z = y;
    }
    
    //    else if (y == 0) {
    //        k = -1;
    //        z = y;
    //    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    
    [self setoffforscroll:scrollView.contentOffset.y];
    
    
    
    
    if (k == 1) {
        [self goup:nil];
        
    }
    else if ( k == -1 ){
        [self godown:nil];
        
    }
    
    //NSLog(@"x offset:  %f", scrollView.contentOffset.x);
    //NSLog(@"y offset:  %f", scrollView.contentOffset.y);
}


-(void)uptable
{
    
    [UIView animateWithDuration:0.5f animations:^{
        _view_info.frame =
        CGRectMake(_view_info.frame.origin.x,
                   _view_info.frame.origin.y,
                   _view_info.frame.size.width,
                   _view_info.frame.size.height - multiheight);
        
    }];
    
    [UIView animateWithDuration:0.5f animations:^{
        _tablev.frame =
        CGRectMake(_tablev.frame.origin.x,
                   _tablev.frame.origin.y - multiheight,
                   _tablev.frame.size.width,
                   _tablev.frame.size.height+multiheight);
        
    }];
    
    
}

#pragma MARK--------PICKERVIEW

-(void)pickerfortop
{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=1;
    self.text_totals.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_totals.inputAccessoryView = mypickerToolbar;
    
    
    
}

-(void)pickerfordown
{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=2;
    self.text_assignmenttype.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked2)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.text_assignmenttype.inputAccessoryView = mypickerToolbar;
    
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
 //   assign_by_typ
    if (pickerView.tag==1) {
        return [assign_types count];
    }
    
    else if (pickerView.tag==2)
    {
    
         return [assign_by_type count];
    
    }
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    
    
    if (pickerView.tag==1) {
        return [[assign_types objectAtIndex:row] objectForKey:@"TITLE"];
    }
    
    else if (pickerView.tag==2)
    {
        
        return [[assign_by_type objectAtIndex:row] objectForKey:@"TITLE"];
        
    }
    
    return 0;
    

   
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    if (pickerView.tag==1) {
        
  
    self.text_totals.text=(NSString *)[[assign_types objectAtIndex:row] objectForKey:@"TITLE"];
    self.assign_type_id = [[assign_types objectAtIndex:row] objectForKey:@"ASSIGNMENT_TYPE_ID"];
    
    NSLog(@"assign_id-----%@",str_assignmentType_id);
    assign_change=@"1";
       
    }
    
    else if (pickerView.tag==2)
    {
    
        self.text_assignmenttype.text=(NSString *)[[assign_by_type objectAtIndex:row] objectForKey:@"TITLE"];
        assignment_id = [[assign_by_type objectAtIndex:row] objectForKey:@"ASSIGNMENT_ID"];
        
        NSLog(@"assign_type_id-----%@",assignment_id);
        assign_change_id=@"1";

        
    }
}

-(void)pickerDoneClicked2

{
    NSLog(@"Done Clicked");
    [self.text_assignmenttype resignFirstResponder];
    // gradesassignment
    
  
    if ([assign_change_id isEqualToString:@"1"]) {
        
        
        self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"TITLE"]];
        assignment_id=[NSString stringWithFormat:@"%@",[[assign_by_type  objectAtIndex:0]objectForKey:@"ASSIGNMENT_ID"]];
        if ([switch_flag isEqualToString:@"1"]) {
            [self loaddown];
        }
        else
        {
            [self SWITCHOFF];
            
        }

        
    }
    
    else
    {
        
       
//        
//        self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"TITLE"]];
//       assignment_id=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"ASSIGNMENT_ID"]];
//        if ([switch_flag isEqualToString:@"1"]) {
//           [self loaddown];
//        }
//        else
//        {
//            [self SWITCHOFF];
//        
//        }
        
    }
  
   
    
    
}
-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    [self.text_totals resignFirstResponder];
    // gradesassignment
    NSString *te=self.text_totals.text;
   // gradestotal
    if ([te isEqualToString:@"Totals"]) {
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GradesTotalViewController *obj=[s instantiateViewControllerWithIdentifier:@"gradestotal"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else
    {
    if ([assign_change isEqualToString:@"1"]) {
        
        
        
    }
    
    else
    {
        
        
        
        self.text_totals.text=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"TITLE"]];
        str_assignmentType_id=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"ASSIGNMENT_TYPE_ID"]];
        
        
    }
        
    
    [array_studentgrades removeAllObjects];
    [lt_grade removeAllObjects];
    [self loaddata];
    }
    
}




#pragma mark--loaddata
-(void)loadata1
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&&include_inactive=%@&assignment_type_id=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s,self.assign_type_id];
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
        NSLog(@"value is-------%@",dictionary1);
    //    array_assignment = [[NSMutableArray alloc]init];
        allItemsArray = [[NSMutableArray alloc] init];
        displayItemsArray = [[NSMutableArray alloc] init];
        array_studentgrades = [[NSMutableArray alloc]init];
        array_points_value=[[NSMutableArray alloc]init];
        displayItemsArray = [[dictionary1 objectForKey:@"student_grades"]mutableCopy];
       // array_assignment = [dictionary1 objectForKey:@"assignment_types"];
    //    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
        
     
        lt_grade=[[NSMutableArray alloc]init];
        [allItemsArray addObjectsFromArray:displayItemsArray];
        NSLog(@"allitem... %@",allItemsArray);
        [array_studentgrades addObjectsFromArray:allItemsArray];
     //   NSLog(@"ii============%@",array_studentgrades);
        
        assign_types=[dictionary1 objectForKey:@"assignment_types"];
        assign_by_type=[dictionary1 objectForKey:@"assignment_by_type"];
        
        
        
        self.assign_type_id =[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_assignment_type_id"]];
        assignment_id =[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_assignment_id"]];
        NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dic17=[[NSMutableDictionary alloc]init];
        
        for (int i=0; i<[assign_types count]; i++) {
            
            
            if ([self.assign_type_id isEqual:[[assign_types objectAtIndex:i]objectForKey:@"ASSIGNMENT_TYPE_ID"]]) {
                dic16=[assign_types objectAtIndex:i];
                
                a=true;
                break;
                
            }
            
            else
            {
                
              //  a=false;
                //break;
                
            }
            
            
            
            
        }
        
        
        if (a==true) {
            
            self.text_totals.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"TITLE"]];
            str_assignmentType_id=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"ASSIGNMENT_TYPE_ID"]];
            
            
            
        }
        
        else
        {
          //  self.text_totals.text=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"TITLE"]];
          //  str_assignmentType_id=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"ASSIGNMENT_TYPE_ID"]];
            
        }
        
        if ([assign_by_type count]>0) {
            
       
        
        for (int i=0; i<[assign_by_type count]; i++) {
            
            
            if ([assignment_id isEqual:[[assign_by_type objectAtIndex:i]objectForKey:@"ASSIGNMENT_ID"]]) {
                dic17=[assign_by_type objectAtIndex:i];
                
                b=true;
                break;
                
            }
            
            else
            {
               // b=false;
               // break;
                
            }
            
        }
            
            
            if (b==true) {
                
                self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[dic17 objectForKey:@"TITLE"]];
                assignment_id=[NSString stringWithFormat:@"%@",[dic17 objectForKey:@"ASSIGNMENT_ID"]];
                
                
                
            }
            
            else
            {
                //self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"TITLE"]];
                // assignment_id=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"ASSIGNMENT_ID"]];
                
            }
            NSString *str_blank=[NSString stringWithFormat:@"%@",self.text_assignmenttype.text];
            if ([str_blank isEqualToString:@"(null)"]) {
                NSLog(@"ok");
//                self.text_assignmenttype.hidden=YES;
//                self.view_assignmenttype.hidden=YES;
                [self tablengreyviewup:nil];
                
            }
            
            else
            {
                
//                self.text_assignmenttype.hidden=NO;
//                self.view_assignmenttype.hidden=NO;
                [self tablengreyviewdown:nil];
                
            }
            
        
        
        }
        
        else
        {
//            self.text_assignmenttype.hidden=YES;
//            self.view_assignmenttype.hidden=YES;
            [self tablengreyviewup:nil];
            NSLog(@"no list");
        
        }
        
        // }
        
        
        
   
        

        if ([array_studentgrades count]>0) {
            [self.tablev setHidden:NO];
            lbl_nodatafound.hidden = YES;
      
        lt_grade=[[NSMutableArray alloc]init];
        ary_com=[[NSMutableArray alloc]init];
        for (int i=0; i<array_studentgrades.count; i++) {
            NSMutableString *str=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"POINTS"]];
            NSMutableString *str1=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"COMMENT"]];
            
            NSRange    copyRange = [str rangeOfString:@"/"];
            NSString *shortString1 = [str substringToIndex:copyRange.location];
            if ([shortString1 isEqualToString:@""]) {
                shortString1=@"0";
            }
            else
            {
            
            }
            
            [array_points_value addObject:shortString1];
            [ary_com addObject:str1];
            NSString *l_g=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"LETTER_GRADE"]];
            [lt_grade addObject:l_g];
        }
        
        NSLog(@"points value----%@",array_points_value);
           
          
            
            
//        assign_types=[dictionary1 objectForKey:@"assignment_types"];
//        assign_by_type=[dictionary1 objectForKey:@"assignment_by_type"];
//        
//       
//        
//      self.assign_type_id =[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_assignment_type_id"]];
//        assignment_id =[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_assignment_id"]];
//        NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
//          NSMutableDictionary *dic17=[[NSMutableDictionary alloc]init];
//   
//        for (int i=0; i<[assign_types count]; i++) {
//            
//            
//            if ([self.assign_type_id isEqual:[[assign_types objectAtIndex:i]objectForKey:@"ASSIGNMENT_TYPE_ID"]]) {
//                dic16=[assign_types objectAtIndex:i];
//                
//                a=true;
//                break;
//                
//            }
//            
//            else
//            {
//                
//                a=false;
//                break;
//                
//            }
//            
//            
//            
//            
//        }
//        
//        
//                if (a==true) {
//            
//            self.text_totals.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"TITLE"]];
//           str_assignmentType_id=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"ASSIGNMENT_TYPE_ID"]];
//          
//            
//            
//        }
//        
//        else
//        {
//              self.text_totals.text=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"TITLE"]];
//               str_assignmentType_id=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"ASSIGNMENT_TYPE_ID"]];
//          
//        }
//        
//        for (int i=0; i<[assign_by_type count]; i++) {
//            
//            
//            if ([assignment_id isEqual:[[assign_by_type objectAtIndex:i]objectForKey:@"ASSIGNMENT_ID"]]) {
//                dic17=[assign_by_type objectAtIndex:i];
//                
//               b=true;
//                break;
//                
//            }
//            
//            else
//            {
//                b=false;
//                break;
//                
//            }
//                
//            }
//            
//            
//            
//            
//       // }
//        
//        
//        if (b==true) {
//            
//            self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[dic17 objectForKey:@"TITLE"]];
//            assignment_id=[NSString stringWithFormat:@"%@",[dic17 objectForKey:@"ASSIGNMENT_ID"]];
//            
//            
//            
//        }
//        
//        else
//        {
//            self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"TITLE"]];
//           assignment_id=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"ASSIGNMENT_ID"]];
//            
//        }
//        
//        
//        NSString *str_blank=[NSString stringWithFormat:@"%@",self.text_assignmenttype.text];
//        if ([str_blank isEqualToString:@"(null)"]) {
//            NSLog(@"ok");
//              self.text_assignmenttype.hidden=YES;
//            self.view_assignmenttype.hidden=YES;
////            [UIView animateWithDuration:0.3f animations:^{
////               
////                self.view_topBar.bounds = CGRectMake(self.view_topBar.bounds.origin.x, self.view_topBar.bounds.origin.y, self.view_topBar.bounds.size.width, self.view_total.bounds.size.height + self.view_total.bounds.origin.y + 3);
////                
////                self.view_topline.bounds = CGRectMake(self.view_topline.bounds.origin.x, self.view_total.bounds.size.height + self.view_total.bounds.origin.y + 3,self.view_topline.bounds.size.width, self.view_topline.bounds.size.height);
////
////                
////            }];
//            
//        }
//        
//        else
//        {
//        
//            self.text_assignmenttype.hidden=NO;
//            self.view_assignmenttype.hidden=NO;
//            
//        }
//        
//        
        
        [self.tablev reloadData];
            
        }
        
        else
        {
        // student_grades
            
            self.tablev.hidden=YES;
           lbl_nodatafound.hidden = NO;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tablev setHidden:YES];
        lbl_nodatafound.hidden = NO;
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
    
}

-(void)loaddown
{
    
    
    // str_s=@"N";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(PICKERVALUEchangeassign_type_id) withObject:nil afterDelay:0];
        });
    });
    
    
    
}


-(void)PICKERVALUEchangeassign_type_id
{
      str_s=@"Y";
   // http://107.170.94.176/openSIS_CE6_Mobile/webservice/grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=1&mp_id=16&assignment_id=33&include_inactive=N
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&&include_inactive=%@&assignment_id=%@&assignment_type_id=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s,assignment_id,self.assign_type_id];
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
        NSLog(@"value is-------%@",dictionary1);
        //    array_assignment = [[NSMutableArray alloc]init];
        allItemsArray = [[NSMutableArray alloc] init];
        displayItemsArray = [[NSMutableArray alloc] init];
        array_studentgrades = [[NSMutableArray alloc]init];
        array_points_value=[[NSMutableArray alloc]init];
        displayItemsArray = [[dictionary1 objectForKey:@"student_grades"]mutableCopy];
        // array_assignment = [dictionary1 objectForKey:@"assignment_types"];
        //    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
        
        
        
        
        [allItemsArray addObjectsFromArray:displayItemsArray];
        NSLog(@"allitem... %@",allItemsArray);
        [array_studentgrades addObjectsFromArray:allItemsArray];
        NSLog(@"ii============%@",array_studentgrades);
        ary_com=[[NSMutableArray alloc]init];
        
        lt_grade=[[NSMutableArray alloc]init];
        for (int i=0; i<array_studentgrades.count; i++) {
            NSMutableString *str=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"POINTS"]];
            NSMutableString *str1=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"COMMENT"]];
            
            NSRange    copyRange = [str rangeOfString:@"/"];
            NSString *shortString1 = [str substringToIndex:copyRange.location];
            
            [array_points_value addObject:shortString1];
            [ary_com addObject:str1];
           NSString *l_g=[[array_studentgrades objectAtIndex:i] objectForKey:@"LETTER_GRADE"];
            [lt_grade addObject:l_g];
        }
        
        NSLog(@"points value--%@",array_points_value);
        
       // assign_types=[dictionary1 objectForKey:@"assignment_types"];
       // assign_by_type=[dictionary1 objectForKey:@"assignment_by_type"];
      
       // switch_flag=@"1";
        [self.tablev reloadData];
        // student_grades
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        lbl_nodatafound.hidden = NO;
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
    
}
-(void)SWITCHOFF
{
      str_s=@"N";
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=1&mp_id=16&assignment_id=33&include_inactive=N
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&&include_inactive=%@&assignment_id=%@&assignment_type_id=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s,assignment_id,self.assign_type_id];
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
        NSLog(@"value is-------%@",dictionary1);
        //    array_assignment = [[NSMutableArray alloc]init];
        allItemsArray = [[NSMutableArray alloc] init];
        displayItemsArray = [[NSMutableArray alloc] init];
        array_studentgrades = [[NSMutableArray alloc]init];
        array_points_value=[[NSMutableArray alloc]init];
        displayItemsArray = [[dictionary1 objectForKey:@"student_grades"]mutableCopy];
        // array_assignment = [dictionary1 objectForKey:@"assignment_types"];
        //    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
        
        
        
        
        [allItemsArray addObjectsFromArray:displayItemsArray];
        NSLog(@"allitem... %@",allItemsArray);
        [array_studentgrades addObjectsFromArray:allItemsArray];
        NSLog(@"ii============%@",array_studentgrades);
        ary_com=[[NSMutableArray alloc]init];
        
        lt_grade=[[NSMutableArray alloc]init];
        for (int i=0; i<array_studentgrades.count; i++) {
            NSMutableString *str=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"POINTS"]];
            NSMutableString *str1=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"COMMENT"]];
            
            NSRange    copyRange = [str rangeOfString:@"/"];
            NSString *shortString1 = [str substringToIndex:copyRange.location];
            
            [array_points_value addObject:shortString1];
            [ary_com addObject:str1];
            NSString *l_g=[[array_studentgrades objectAtIndex:i] objectForKey:@"LETTER_GRADE"];
            [lt_grade addObject:l_g];
        }
        
        NSLog(@"points value--%@",array_points_value);
        
        // assign_types=[dictionary1 objectForKey:@"assignment_types"];
        // assign_by_type=[dictionary1 objectForKey:@"assignment_by_type"];
        
     //   switch_flag=@"0";
        [self.tablev reloadData];
        // student_grades
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        lbl_nodatafound.hidden = NO;
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
    
}

#pragma mark  searchbardelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
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
    
}
-(void)loaddata
{
    
    
   // str_s=@"N";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loadata1) withObject:nil afterDelay:0];
        });
    });
    
    
    
}
- (IBAction)dhongsho:(id)sender {
    
    
    [self uptable];
}


#pragma mark - Actions


- (IBAction)action_click:(id)sender {
    [self open];
}

-(IBAction)clickm:(UIButton*)sender
{
     selectedIndexpath =sender.tag;
    NSString *marks_value=[NSString stringWithFormat:@"%@",[array_points_value objectAtIndex:sender.tag]];
    NSLog(@"marks value---%@",marks_value);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter the points" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 5;
    [alert show];


}
-(IBAction)commentsave:(UIButton*)sender
{
     selectedIndexpath =sender.tag;
    view_hidden.hidden=YES;
    NSString *name=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:sender.tag]objectForKey:@"FULL_NAME"]];
      NSLog(@"marks value---%@",name);
     [ary_com replaceObjectAtIndex:selectedIndexpath withObject:txtview_comment.text];
    
    txtview_comment.text=@"";
    NSLog(@"------%@",ary_com);

}

-(IBAction)noteclick:(UIButton*)sender
{
    selectedIndexpath =sender.tag;
  NSString *marks_value=[NSString stringWithFormat:@"%@",[ary_com objectAtIndex:sender.tag]];
    NSString *name=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:sender.tag]objectForKey:@"FULL_NAME"]];
  //  NSLog(@"marks value---%@",marks_value);
    btn.tag=sender.tag;
    [btn addTarget:self action:@selector(commentsave:) forControlEvents:UIControlEventTouchUpInside];
    name123.text=name;
    if ([marks_value isEqualToString:@"null    "]) {
        txtview_comment.text=@"";
    }
    
   // <null>
    
 else   if ([marks_value isEqualToString:@"<null>"]) {
        txtview_comment.text=@"";
    }
    else
    {
    
        txtview_comment.text=marks_value;
    
    }
    view_hidden.hidden=NO;
  
    
  
    
  
    
    
}
#pragma mark - Alert Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    
    
    
    if(alertView.tag == 5){
        if([[alertView textFieldAtIndex:0].text isEqualToString:@""]){
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        else
        {
            
            [array_points_value replaceObjectAtIndex:selectedIndexpath withObject:[alertView textFieldAtIndex:0].text];
            
            [self.tablev reloadData];
        }
        
    }
    
    
    
}

#pragma mark - TableView Delegate and Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array_studentgrades.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Gradest*cell = (Gradest*)[tableView dequeueReusableCellWithIdentifier:@"Gradest"];
    cell.lbl_name.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"FULL_NAME"];
  //  cell.lbl_points.text = [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"POINTS"];
    NSString *string = [NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"POINTS"]];
    NSString *str_gradestr1 = [[string componentsSeparatedByString:@"/"] objectAtIndex:1];
    
    NSString *str_gradechar1 = str_gradestr1;
    cell.marks.tag=indexPath.row;
    [cell.marks addTarget:self action:@selector(clickm:) forControlEvents:UIControlEventTouchUpInside];
    cell.note.tag=indexPath.row;
    [cell.note addTarget:self action:@selector(noteclick:) forControlEvents:UIControlEventTouchUpInside];
    cell.txt_value.text=[NSString stringWithFormat:@"%@",[array_points_value objectAtIndex:indexPath.row]];
    
    

    cell.lbl_points.text=[NSString stringWithFormat:@"/%@",str_gradechar1];
  
    
    cell.lbl_id.text =  [[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"STUDENT_ID"];
    
 NSString *lg=[lt_grade objectAtIndex:indexPath.row];
    
    NSLog(@"ltgrade-------%@",lt_grade);
    if ([switch_flag isEqualToString:@"1"]) {
        NSString *school_status_active=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"ACTIVE"]];
        NSString *course_status_active=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"ACTIVE_SCHEDULE"]];
        cell.lbl_st.hidden=NO;
        cell.lbl_ca.hidden=NO;
        cell.lbl_sa.hidden=NO;
        cell.lbl_cs.hidden=NO;
        cell.lbl_st.text=school_status_active;
        cell.lbl_ca.text=course_status_active;
        
        
    }
    
    else
    {
        cell.lbl_sa.hidden=YES;
        cell.lbl_cs.hidden=YES;
        cell.lbl_st.hidden=YES;
        cell.lbl_ca.hidden=YES;
        
        
    }

  //  cell.lbl_char_grade.hidden=YES;
   // cell.lbl_grades.hidden=YES;
   // cell.letter_grade.text=[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"LETTER_GRADE"];
//[lg isEqualToString:@"Not Graded"]
    NSRange rr = [lg rangeOfString:@"%"];
   if ( rr.length  == 0) {
       cell.lbl_grades.hidden = YES;
       cell.lbl_char_grade.hidden=YES;
       cell.letter_grade.hidden=NO;//Not Graded
       [cell.letter_grade setNumberOfLines:3];
       cell.letter_grade.text =[NSString stringWithFormat:@"%@", lg];
       [cell.letter_grade setLineBreakMode:NSLineBreakByWordWrapping];
       // cell.lbl_grades.text=@"Graded";
       [cell bringSubviewToFront:cell.letter_grade];
        // cell.letter_grade.hidden=NO;
    }
//   else if ([lg isEqualToString:@""])
//   {
//       
//       
//       cell.lbl_grades.hidden=YES;
//       cell.lbl_char_grade.hidden=YES;
//          cell.letter_grade.hidden=YES;
//       
//   }
    
//    if ( rr.length  == 1) {
//        cell.lbl_grades.hidden = YES;
//        cell.lbl_char_grade.hidden=YES;
//        cell.letter_grade.hidden=NO;//Not Graded
//        [cell.letter_grade setNumberOfLines:3];
//        cell.letter_grade.text =[NSStri
//                                 ng stringWithFormat:@"%@", lg];
//        [cell.letter_grade setLineBreakMode:NSLineBreakByWordWrapping];
//        // cell.lbl_grades.text=@"Graded";
//        [cell bringSubviewToFront:cell.letter_grade];
//        // cell.letter_grade.hidden=NO;
//    }

    
    else
    {
        cell.lbl_grades.hidden=NO;
        cell.lbl_char_grade.hidden=NO;
        cell.letter_grade.hidden=YES;
        NSString *str_grades_all = [lt_grade objectAtIndex:indexPath.row];//[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"LETTER_GRADE"];
    NSArray *array_str = [[NSArray alloc]initWithArray:[str_grades_all componentsSeparatedByString:@"%"]];
    NSString *str_gradepoints = [array_str objectAtIndex:0];
   
    cell.lbl_grades.text =[NSString stringWithFormat:@"%@%%", [[str_gradepoints componentsSeparatedByString:@"%"] objectAtIndex:0]];
    NSString *str_gradestr = [[str_grades_all componentsSeparatedByString:@"%"] objectAtIndex:1];
      NSLog(@"iiiiiii------ %@", str_gradestr);
        NSString *str_gradechar;
        if (str_gradestr.length > 0) {
            str_gradechar = [str_gradestr substringToIndex:1];
        }
    
    cell.lbl_char_grade.text = str_gradechar;
        
    }
   // [cell.imageview_profile sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row]objectForKey:@"PHOTO"]]]];
    NSString *cmnt = [NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:indexPath.row] objectForKey:@"COMMENT"] ];
    if (cmnt) {
        if ([cmnt isEqualToString:@""] || [cmnt isEqualToString:@"(null)"] || [cmnt isEqualToString:@" "]) {
            cell.imageview_comment.image = [UIImage imageNamed:@"grey-Comment"];
        }
        else{
            cell.imageview_comment.image = [UIImage imageNamed:@"comment"];
        }
    }
    else
    {
        cell.imageview_comment.image = [UIImage imageNamed:@"grey-Comment"];
    }

    
    return cell;
    
}
-(IBAction)search:(id)sender
{
//    search_view.hidden=NO;
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //[MBProgressHUD hideHUDForView:self.view animated:YES];
//            [self performSelector:@selector(searchdata) withObject:nil afterDelay:0];
//        });
//    });

    search_view.hidden = NO;

}


-(void)searchdata
{
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=1&mp_id=16&assignment_type_id=2&include_inactive=N&search=daniel

    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/grades.php?school_id=%@&syear=%@&staff_id=%@&cpv_id=%@&mp_id=%@&&include_inactive=%@&assignment_type_id=%@&search=%@",school_id,year_id,STAFF_ID_K,cpv_id1,mp_id,str_s,self.assign_type_id,txt_search.text];
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
        NSLog(@"value is-------%@",dictionary1);
        //    array_assignment = [[NSMutableArray alloc]init];
        allItemsArray = [[NSMutableArray alloc] init];
        displayItemsArray = [[NSMutableArray alloc] init];
        array_studentgrades = [[NSMutableArray alloc]init];
        array_points_value=[[NSMutableArray alloc]init];
        displayItemsArray = [[dictionary1 objectForKey:@"student_grades"]mutableCopy];
        // array_assignment = [dictionary1 objectForKey:@"assignment_types"];
        //    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
        
        
        lt_grade=[[NSMutableArray alloc]init];
        [allItemsArray addObjectsFromArray:displayItemsArray];
        NSLog(@"allitem... %@",allItemsArray);
        [array_studentgrades addObjectsFromArray:allItemsArray];
        NSLog(@"ii============%@",array_studentgrades);
        if ([array_studentgrades count]>0) {
            [self.tablev setHidden:NO];
            lbl_nodatafound.hidden = YES;
            
            lt_grade=[[NSMutableArray alloc]init];
            ary_com=[[NSMutableArray alloc]init];
            for (int i=0; i<array_studentgrades.count; i++) {
                NSMutableString *str=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"POINTS"]];
                NSMutableString *str1=[NSMutableString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"COMMENT"]];
                
                NSRange    copyRange = [str rangeOfString:@"/"];
                NSString *shortString1 = [str substringToIndex:copyRange.location];
                
                [array_points_value addObject:shortString1];
                [ary_com addObject:str1];
                NSString *l_g=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i]objectForKey:@"LETTER_GRADE"]];
                [lt_grade addObject:l_g];
            }
            
            NSLog(@"points value----%@",array_points_value);
            
            
            
            assign_types=[dictionary1 objectForKey:@"assignment_types"];
            assign_by_type=[dictionary1 objectForKey:@"assignment_by_type"];
            
            
            
            self.assign_type_id =[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_assignment_type_id"]];
            assignment_id =[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"selected_assignment_id"]];
            NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
            NSMutableDictionary *dic17=[[NSMutableDictionary alloc]init];
            
            for (int i=0; i<[assign_types count]; i++) {
                
                
                if ([self.assign_type_id isEqual:[[assign_types objectAtIndex:i]objectForKey:@"ASSIGNMENT_TYPE_ID"]]) {
                    dic16=[assign_types objectAtIndex:i];
                    
                    a=true;
                    break;
                    
                }
                
                else
                {
                    
                    
                    
                }
                
                
                
                
            }
            
            
            if (a==true) {
                
                self.text_totals.text=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"TITLE"]];
                str_assignmentType_id=[NSString stringWithFormat:@"%@",[dic16 objectForKey:@"ASSIGNMENT_TYPE_ID"]];
                
                
                
            }
            
            else
            {
                self.text_totals.text=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"TITLE"]];
                str_assignmentType_id=[NSString stringWithFormat:@"%@",[[assign_types objectAtIndex:0]objectForKey:@"ASSIGNMENT_TYPE_ID"]];
                
            }
            
            for (int i=0; i<[assign_by_type count]; i++) {
                
                
                if ([assignment_id isEqual:[[assign_by_type objectAtIndex:i]objectForKey:@"ASSIGNMENT_ID"]]) {
                    dic17=[assign_by_type objectAtIndex:i];
                    
                    b=true;
                    break;
                    
                }
                
                else
                {
                    
                    
                    
                }
                
                
                
                
            }
            
            
            if (b==true) {
                
                self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[dic17 objectForKey:@"TITLE"]];
                assignment_id=[NSString stringWithFormat:@"%@",[dic17 objectForKey:@"ASSIGNMENT_ID"]];
                
                
                
            }
            
            else
            {
                self.text_assignmenttype.text=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"TITLE"]];
                assignment_id=[NSString stringWithFormat:@"%@",[[assign_by_type objectAtIndex:0]objectForKey:@"ASSIGNMENT_ID"]];
                
            }
            
            
            NSString *str_blank=[NSString stringWithFormat:@"%@",self.text_assignmenttype.text];
            if ([str_blank isEqualToString:@"(null)"]) {
                NSLog(@"ok");
                self.text_assignmenttype.hidden=YES;
                self.view_assignmenttype.hidden=YES;
                //            [UIView animateWithDuration:0.3f animations:^{
                //
                //                self.view_topBar.bounds = CGRectMake(self.view_topBar.bounds.origin.x, self.view_topBar.bounds.origin.y, self.view_topBar.bounds.size.width, self.view_total.bounds.size.height + self.view_total.bounds.origin.y + 3);
                //
                //                self.view_topline.bounds = CGRectMake(self.view_topline.bounds.origin.x, self.view_total.bounds.size.height + self.view_total.bounds.origin.y + 3,self.view_topline.bounds.size.width, self.view_topline.bounds.size.height);
                //
                //
                //            }];
                
            }
            
            else
            {
                
                self.text_assignmenttype.hidden=NO;
                self.view_assignmenttype.hidden=NO;
                
            }
            
            [self.tablev reloadData];
            
        }
        
        else
        {
            // student_grades
            
            self.tablev.hidden=YES;
            lbl_nodatafound.hidden = NO;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.tablev setHidden:YES];
        lbl_nodatafound.hidden = NO;
        
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    

    
    
    
}
-(IBAction)searchback:(id)sender
{
    
    search_view.hidden=YES;
    txt_search.text=@"";
    
    
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    search_view.hidden=YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(searchdata) withObject:nil afterDelay:0];
        });
    });
    
    

    
    return YES;
}


@end
