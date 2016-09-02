//
//  ResultGroupMemberController.m
//  openSiS
//
//  Created by os4ed on 1/6/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "ResultGroupMemberController.h"
#import "ResultGroupMemberCell.h"
#import "AppDelegate.h"
#import "mailview.h"
#import "takeattendance.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "CellTableViewCell1.h"
#import "attendencedetail.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"

#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface ResultGroupMemberController ()

@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIButton *btn_selectAll;
@property (strong, nonatomic) IBOutlet UILabel *lbl_nodata;

@end

@implementation ResultGroupMemberController
{
    NSMutableArray *cellindex,*array_members;
    BOOL isSelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cellindex = [[NSMutableArray alloc]init];
    
    isSelected = NO;
    
    
    
    
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    
    
    if (![self.str_allsch isEqualToString:@"Y"]) {
        self.str_allsch = @"";
    }
    
    if (![self.str_disusr isEqualToString:@"Y"]) {
        self.str_disusr = @"";
    }
    
    [self.btn_selectAll.layer setCornerRadius:3.0f];
    [self.btn_selectAll.layer setBorderWidth:3.0f];
    [self.btn_selectAll.layer setBorderColor:[[UIColor blackColor] CGColor]];
    self.btn_selectAll.clipsToBounds = YES;
    
    // Do any additional setup after loading the view.
    [self loaddata];
}
-(void)loaddata
{
    //  transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        });
    });
    
    
}

- (IBAction)action_selectAll:(UIButton *)sender {
    
    if (!isSelected && array_members.count != 0) {
        [self.btn_selectAll setBackgroundImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        isSelected = YES;
        for (int i = 0; i < array_members.count; ++i) {
            [cellindex addObject:[NSString stringWithFormat:@"%d",i]];
        }

    }
    else
    {
        
       [self.btn_selectAll setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        isSelected = NO;
        [cellindex removeAllObjects];
    }
    
    
    
    
    [self.tablev reloadData];
    
}

-(void)loaddata1
{
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=selected_grp_view&grp_id=8
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=add_grp_member_view&grp_id=4&last=&first=&username=&profile=&_dis_user=&_search_all_schools=
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/message_group.php?staff_id=%@&school_id=%@&syear=%@&action_type=add_grp_member_view&grp_id=%@&last=%@&first=%@&username=%@&profile=%@&_dis_user=%@&_search_all_schools=%@",STAFF_ID_K,school_id,year_id,self.group_id,self.str_last,self.str_first,self.str_usr,self.str_profile,self.str_disusr,self.str_allsch];
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
                       self.tablev.hidden = NO;
            self.lbl_nodata.hidden = YES;
        //    self.lbl_static_nomembersfound.hidden = YES;
            
            array_members=[dictionary1 objectForKey:@"member_list"];
            
            [cellindex removeAllObjects];
            [self.tablev reloadData];
            
        }
        else
        {
           // self.btn_deleteMembers.hidden = YES;
            
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //self.lbl_static_nomembersfound.hidden=NO;
            self.tablev.hidden = YES;
             self.lbl_nodata.hidden = NO;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //transparentView.hidden=NO;
        NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


-(void)syncButtonAction:(UIButton*)sender   {
    
    NSLog(@"kkdkkf");
    UIButton *targetButton = (UIButton *)sender;
    NSString *str4=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSLog(@"heloooo__%@",str4);
    isSelected = NO;
    [self.btn_selectAll setBackgroundImage:[UIImage imageNamed:@""]
                                  forState:UIControlStateNormal];
    if([cellindex containsObject:str4]){
        [targetButton setSelected:NO];
        
        //        [arry_total removeObject:[mdcnary objectAtIndex:sender.tag]];
        //        [arry_total1 removeObject:[genrcary objectAtIndex:sender.tag]];
        //        [arry_total2 removeObject:[descrptnary objectAtIndex:sender.tag]];
        
        [cellindex removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        NSLog(@"Count of arr selected %@",cellindex);
        
        [sender setBackgroundImage:[UIImage imageNamed:@"uncheckbox"]
                          forState:UIControlStateNormal];
    }
    else{
        [targetButton setSelected:YES];
        NSLog(@"caslllllaaaa %ld",(long)sender.tag);
        //strw=[NSString stringWithFormat:@"%d",sender.tag];
        //        [arry_total addObject:[mdcnary objectAtIndex:sender.tag]];
        //        [arry_total1 addObject:[genrcary objectAtIndex:sender.tag]];
        //        [arry_total2 addObject:[descrptnary objectAtIndex:sender.tag]];
        
        [cellindex addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        NSLog(@"Count of arr unselect %@",cellindex);
        [sender setBackgroundImage:[UIImage imageNamed:@"checkbox"]
                          forState:UIControlStateNormal];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array_members.count;
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




- (ResultGroupMemberCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"ResultGroupMemberCell";
    ResultGroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        cell = (ShowGroupMemberCell*)[[[NSBundle mainBundle] loadNibNamed:@"ShowGroupMemberCell" owner:nil options:nil] objectAtIndex:0];
    //   	}
    //    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    // cell.BackgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_green.png"]];
    
    //    if (tableView
    
    //    {
    
    
    
    // cell.text=dateStr;
    
    cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[array_members objectAtIndex:indexPath.row]objectForKey:@"FIRST_NAME"]];
    
    cell.lbl_profile.text=[NSString stringWithFormat:@"%@",[[array_members objectAtIndex:indexPath.row]objectForKey:@"PROFILE_ID"]];
    
    cell.lbl_username.text = [NSString stringWithFormat:@"%@",[[array_members objectAtIndex:indexPath.row]objectForKey:@"USERNAME"]];
    
    //cell.show.tag = indexPath.row;
    //[button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
    // UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
    // [cell.show setBackgroundImage:[UIImage imageNamed:@"checkbox.png"]
    // forState:UIControlStateHighlighted];
    
    UIButton *show1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    show1.frame = CGRectMake(25.0f, 8.0f, 26.0f, 26.0f);
    [show1 setBackgroundImage:[UIImage imageNamed:@"unchecked_checkbox.png"]
                     forState:UIControlStateNormal];
    [show1 setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateSelected];
    
    
    show1.tag = indexPath.row;
    [show1 addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.contentView addSubview:show1];
    
    NSString *str4=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"heloooo__%@",str4);
    if([cellindex containsObject:str4])
        
        
    {
        NSLog(@"checkkk");
        [show1 setBackgroundImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    }
    else {
        NSLog(@"uncheckkk");
        [show1 setBackgroundImage:[UIImage imageNamed:@"uncheckbox"] forState:UIControlStateNormal];
        //}
        
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        // [cell.show addTarget:self action:@selector(syncButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
    
}

- (IBAction)action_save:(id)sender {
    
   // http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=member_insert&grp_id=4&members=[{"id":"50","profile":"parent"}]
    
    [self savedataongroups];
    
}


- (void)savedataongroups
{
   // NSString *cmt,*point;
    NSMutableArray *array_selectedmembers = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < cellindex.count; ++i) {
        
       // [array_selectedmembers addObject:[array_members objectAtIndex:[[cellindex objectAtIndex:i] integerValue]]];
        
        NSMutableDictionary *diction = [[NSMutableDictionary alloc]init];
        
        [diction setObject:[[array_members objectAtIndex:[[cellindex objectAtIndex:i] integerValue]] objectForKey:@"USER_ID"] forKey:@"id"];
        [diction setObject:[[array_members objectAtIndex:[[cellindex objectAtIndex:i] integerValue]] objectForKey:@"PROFILE_ID"] forKey:@"profile"];
        
        [array_selectedmembers addObject:diction];
        
    }
    NSLog(@"selected member array: %@", array_selectedmembers);
    
//    for(int i=0;i<[array_studentgrades count];i++)
//    {
//        // NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
//        NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
//        NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
//        
//        NSString *str_id=[NSString stringWithFormat:@"%@",[[array_studentgrades objectAtIndex:i] objectForKey:@"STUDENT_ID"]];
//        cmt=[[array_studentgrades objectAtIndex:i] objectForKey:@"COMMENT"];
//        point=[[array_studentgrades  objectAtIndex:i] objectForKey:@"GRADE_PERCENT"];
//        //   NSString *str_id1=[NSString stringWithFormat:@"%@",[array_studentgrades objectAtIndex:i]];
//        
//        [dic3 setObject:point  forKey:@"percent"];
//        [dic3 setObject:cmt  forKey:@"comment"];
//        
//        [dic2 setObject:dic3 forKey:str_id];
//        //
//        //[dic1 setObject:dic2 forKey:str_id];
//        [arrData addObject:dic2];
//    }
    
    //   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrData];
    NSString * str111;// = [Base64 encode:data];
    str111=[array_selectedmembers JSONRepresentation];
    
    NSLog(@"----String To Post To Server ---%@",str111);
    
    
    //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/post_final_grades.php?school_id=1&syear=2015&staff_id=2&cpv_id=24&mp_id=16&values=[{"13":{"percent":"65%","comment":"test"},"2":{"percent":"35%","comment":"test%201"},"3":{"percent":"45%","comment":"test%202"},"15":{"percent":"15%","comment":"test%203"},"7":{"percent":"55%","comment":"test%204"}}]
    
   //  http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=member_insert&grp_id=4&members=[{"id":"50","profile":"parent"}]
    
    // NSMutableDictionary    *dict=[[NSMutableDictionary alloc]init];
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    //NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    
    
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    // [AFJSONResponseSerializer serializer];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    //NSString *mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    
    
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    
    NSString *urlStr = [NSString stringWithFormat:@"/message_group.php"];
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
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"action_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"member_insert" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"grp_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[self.group_id dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"members\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
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
        
        [self loaddata];
        
    }
    
    else
    {
        
        //   NSString *msg=[NSString stringWithFormat:@"%@",[datadic objectForKey:@"err_msg"]];
        // [self alertmsg:msg];
        
        //UIAlertView
        
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}




- (IBAction)action_cancel:(id)sender {
    NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:5] animated:YES];
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

#pragma mark - Tabbar

-(IBAction)home:(id)sender
{
    
    //AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    // NSLog(@"dic===========%@",dic);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
    
    
    [self.navigationController pushViewController:vc animated:NO];
    
    
    
}

- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
