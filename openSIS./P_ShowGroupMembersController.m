//
//  ShowGroupMembersController.m
//  openSiS
//
//  Created by os4ed on 1/5/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "P_ShowGroupMembersController.h"
#import "AppDelegate.h"
#import "P_mailview.h"
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
//#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "ShowGroupMemberCell.h"
#import "P_SearchGroupMemberController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "P_msg1.h"
#import "TeacherDashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"


@interface P_ShowGroupMembersController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lbl_groupname;
@property (strong, nonatomic) IBOutlet UIButton *btn_deleteMembers;
@property (strong, nonatomic) IBOutlet UILabel *lbl_static_nomembersfound;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Description;


@end

@implementation P_ShowGroupMembersController
{
    NSMutableArray *array_members,*cellindex;
    NSString *member_ids;
    
    
    
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    array_members = [[NSMutableArray alloc]init];
    cellindex = [[NSMutableArray alloc]init];
    
    self.tablev.tableFooterView = [[UIView alloc]init];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
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


-(void)loaddata1
{
    // http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=selected_grp_view&grp_id=8
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];

    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_message_group.php?parent_id=%@&student_id=%@&syear=%@&action_type=selected_grp_view&grp_id=%@",parentid,student_id,s_year,self.groupid];
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
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"MEMBER_COUNT"]];
        NSLog(@"str_123-----%@",str_123);
        self.lbl_groupname.text = [dictionary1 objectForKey:@"GROUP_NAME"];
        self.lbl_Description.text = [dictionary1 objectForKey:@"DESCRIPTION"];

        if(![str_123 isEqualToString:@"0"])
        {
            self.btn_deleteMembers.hidden = NO;
            self.tablev.hidden = NO;
            self.lbl_static_nomembersfound.hidden = YES;
            
            array_members=[dictionary1 objectForKey:@"MEMBERS"];
            
            [cellindex removeAllObjects];
            
            [self.tablev reloadData];
            
        }
        else
        {
            self.btn_deleteMembers.hidden = YES;

            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            self.lbl_static_nomembersfound.hidden=NO;
            self.tablev.hidden = YES;
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

-(void)alertmsg:(NSString*)msg
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)syncButtonAction:(UIButton*)sender{
    NSLog(@"kkdkkf");
    
    UIButton *targetButton = (UIButton *)sender;
    NSString *str4=[NSString stringWithFormat:@"%ld",(long)sender.tag];
    NSLog(@"heloooo__%@",str4);
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

- (ShowGroupMemberCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"ShowGroupMemberCell";
    ShowGroupMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = (ShowGroupMemberCell*)[[[NSBundle mainBundle] loadNibNamed:@"ShowGroupMemberCell" owner:nil options:nil] objectAtIndex:0];
//   	}
//    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    // cell.BackgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_green.png"]];
    
    //    if (tableView
    
    //    {
    
    
    
   // cell.text=dateStr;
    
    cell.lbl_name.text=[NSString stringWithFormat:@"%@",[[array_members objectAtIndex:indexPath.row]objectForKey:@"NAME"]];
    
    cell.lbl_profile.text=[NSString stringWithFormat:@"%@",[[array_members objectAtIndex:indexPath.row]objectForKey:@"PROFILE"]];
    
    cell.lbl_username.text = [NSString stringWithFormat:@"%@",[[array_members objectAtIndex:indexPath.row]objectForKey:@"USER_NAME"]];
    
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



- (IBAction)action_addMembers:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"P_msg" bundle:[NSBundle mainBundle]];
    P_SearchGroupMemberController *sgmc = [sb instantiateViewControllerWithIdentifier:@"p_searchmember"];
    sgmc.group_id = self.groupid;
    [self.navigationController pushViewController:sgmc animated:YES];
    
}


- (IBAction)action_DeleteMembers:(id)sender {
   // [self calldelete];
    
    NSLog(@"selected array: %@", cellindex);
    member_ids = @"" ;
    for (int i = 0; i < cellindex.count; ++i) {
        NSInteger k = [[cellindex objectAtIndex:i] integerValue];
        member_ids = [member_ids stringByAppendingString:[[array_members objectAtIndex:k] objectForKey:@"ID"]];
        
        if (i + 1 !=cellindex.count) {
            member_ids = [member_ids stringByAppendingString:@","];
        }
    }
    NSLog(@"memberID list: %@",member_ids);
    
    [self calldelete];
}

- (void)calldelete
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            //[self performSelector:@selector(deletemembers) withObject:nil afterDelay:1.0];
        });
    });

}

-(void)deletemembers
{
    
  // http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=1&syear=2015&action_type=edit_grp_members&grp_id=4&members=41,42,43,44
    
   // http://107.170.94.176/openSIS_CE6_Mobile/webservice/message_group.php?staff_id=2&school_id=2&syear=2015&action_type=edit_grp_members&grp_id=8members=55,57,59
    
    //NSString *str_members = member_ids ;
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/message_group.php?staff_id=%@&school_id=%@&syear=%@&action_type=edit_grp_members&grp_id=%@&members=%@",STAFF_ID_K,school_id,year_id,self.groupid,member_ids];
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
            [self loaddata];
        }
//        else
//        {
//            self.btn_deleteMembers.hidden = YES;
//            
//            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
//            self.lbl_static_nomembersfound.hidden=NO;
//            self.tablev.hidden = YES;
//            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
//            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
//            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            // [alert show];
//            
//            
//            
//        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //transparentView.hidden=NO;
        NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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

- (IBAction)action_back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
