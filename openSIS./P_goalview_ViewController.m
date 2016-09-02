//
//  P_goalview_ViewController.m
//  openSiS
//
//  Created by os4ed on 6/30/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_goalview_ViewController.h"
#import "EnrollinfoViewController.h"
#import "AddressViewController.h"
#import "SettingViewController.h"

#import "AFNetworking.h"
#import "ip_url.h"
#import "AppDelegate.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "MsgViewController.h"
#import "SdashboardViewController.h"
#import "P_EnrollinfoViewController.h"
#import "P_AddressViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"
#import "P_goalcellTableViewCell.h"
#import "P_CommentViewController.h"
#import "P_gv1TableViewCell.h"
#import "P_goalview2_ViewController.h"


@interface P_goalview_ViewController ()
{
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
    NSArray  *sinfo;
    
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment_menu;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll_viewforSegment;

@end

@implementation P_goalview_ViewController

- (IBAction)action_segment:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        //        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]];
        //        MyInformationGeneral *mia = [storyBoard instantiateViewControllerWithIdentifier:@"MyInformationGeneral"];
        //        [self.navigationController pushViewController:mia animated:YES];
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_EnrollinfoViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_enroll1"];
        
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        
        
        
        [self.navigationController pushViewController:mia animated:NO];
    }
    else if (sender.selectedSegmentIndex == 2)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_AddressViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_address1"];
        
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        
        
        
        [self.navigationController pushViewController:mia animated:NO];
    }
    else if (sender.selectedSegmentIndex == 3)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
        P_CommentViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"p_comments"];
        
        mia.st_id=self.st_id;
        
        
        
        mia.schoolid=self.schoolid;
        
        
        
        mia.ssssyr=self.ssssyr;
        
        
        [self.navigationController pushViewController:mia animated:NO];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    _segment_menu.selectedSegmentIndex=4;
    
    
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    //[self loaddata];
    
    
    tbl.tableFooterView=[[UIView alloc]init];
    
    
    [self.scroll_viewforSegment setContentSize:CGSizeMake(self.segment_menu.frame.size.width, self.scroll_viewforSegment.frame.size.height)];
    
    
    
    sinfo=[[NSArray alloc]init];
    
    
    
    sinfo=[self.dict objectForKey:@"PROGRESS_DATA"];
    
    
    
    NSLog(@"pppp----%@",sinfo);
    
    
    main_title.text=[self.dict objectForKey:@"GOAL_TITLE"];
    
    
    
    [tbl reloadData];
    
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sinfo.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    P_gv1TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"pgv1"];
    
    
    cell.ptitle.text = [[sinfo objectAtIndex:indexPath.row]objectForKey:@"PROGRESS_NAME"];
    
    
    self.prog_title=cell.ptitle.text;
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957f green:0.957f blue:0.957f alpha:1.00f];
        
    }
    
}

- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"P_Student" bundle:[NSBundle mainBundle]];
    P_goalview2_ViewController *mia = [storyBoard instantiateViewControllerWithIdentifier:@"gv2"];
    
    
    mia.dict=[sinfo objectAtIndex:indexPath.row];
    
    
    mia.goaltitle=[_dict objectForKey:@"GOAL_TITLE"];
    
    
    mia.progress_title=self.prog_title;
    
    
    [self.navigationController pushViewController:mia animated:NO];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



-(IBAction)mainback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}












-(IBAction)back:(id)sender
{
    
    NSArray *ary = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[ary objectAtIndex:3] animated:YES];
    
}



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



@end
