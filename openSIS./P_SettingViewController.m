//
//  SettingViewController.m
//  openSiS
//
//  Created by os4ed on 4/6/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_SettingViewController.h"

#import "SettingTableViewCell.h"
#import "P_ChangeViewController.h"

#import "pdashboardViewController.h"
#import "P_PrivacyViewController.h"
#import "P_AboutViewController.h"
#import "P_TermsViewController.h"
#import "MyinfoViewController.h"
#import "P_slideViewController.h"
#import "S_ReportViewController.h"
#import "SettingViewController.h"
#import "pdashboardViewController.h"
#import "geninfo.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"


@interface P_SettingViewController ()
{
    NSMutableArray *ary_gradebook, *ary_setup;
    
    P_slideViewController *slide;
    
    
    int multiheight1;
}
@property (strong, nonatomic) IBOutlet UIView *view_gradebook;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *baseView;

@property (strong, nonatomic) IBOutlet UITableView *table_setup;
@property (strong, nonatomic) IBOutlet UIView *view_setup;

@end

@implementation P_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    slide = [[P_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"settingsparent"];
    
//    [NSTimer scheduledTimerWithTimeInterval:2.0
//                                     target:self
//                                   selector:@selector(fetchdata)
//                                   userInfo:nil
//                                    repeats:YES];
//    
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swiperight];
    
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
    _view_gradebook.layer.borderWidth =  1.0f;
    _view_gradebook.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_gradebook.layer setCornerRadius:3.5f];
    _view_gradebook.clipsToBounds = YES;
    
    
    _view_setup.layer.borderWidth =  1.0f;
    _view_setup.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
    [_view_setup.layer setCornerRadius:3.5f];
    _view_setup.clipsToBounds = YES;
    
    
    NSArray *ary = [[NSArray alloc]initWithObjects:@"My Information",@"Change Password", nil];
    NSArray *ary2 =[[NSArray alloc]initWithObjects:@"Help",@"About",@"Terms of Use",@"Privacy Policy", nil];
    
    ary_setup = [[NSMutableArray alloc]init];
    [ary_setup addObjectsFromArray:ary2];
    ary_gradebook = [[NSMutableArray alloc]init];
    
    [ary_gradebook addObjectsFromArray:ary];
    NSLog(@"arrrr %@", ary_gradebook);
}


-(IBAction)settting:(id)sender
{
    
//    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//    SettingViewController * mvc=[[SettingViewController alloc]init];
//    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
//    [self.navigationController pushViewController:mvc animated:NO];
    
    
}



-(IBAction)click:(id)sender
{
    NSLog(@"slid open");
    [self open];
}

#pragma mark SideBarOpenFunction

-(void)open
{
    [slide open:self.view];
    
}
-(void)close
{
    [slide close:nil];
    //[self fetchdata];
   // [self showdata];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    // eta gradebook view er height set korar jonno
    
    if (self.view.frame.size.height == 568) {
        multiheight1 = 36;
    }
    else if (self.view.frame.size.height == 667)
    {
   multiheight1 = 42;
    }
    else if (self.view.frame.size.height == 736)
    {
        multiheight1 = 48;
    }
    
    int k2 = (int)ary_gradebook.count;
    int totalheight = k2 * multiheight1;
    CGRect rec = self.view_gradebook.frame;
    rec.size.height = totalheight;
    [self.view_gradebook setFrame:rec];
    //
    int k3 = (int)ary_setup.count;
    int totalheight2 = k3 * multiheight1;
    CGRect rec2 = self.view_setup.frame;
    rec2.size.height = totalheight2;
    [self.view_setup setFrame:rec2];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0   inSection:0];
    [self.tablev scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self.table_setup scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tablev) {
        NSString *str_data=[ary_gradebook objectAtIndex:indexPath.row];
        if([str_data isEqualToString:@"My Information"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
            geninfo *obj = [sb instantiateViewControllerWithIdentifier:@"p_myinfo"];
            
            
            [self.navigationController pushViewController:obj animated:YES];
            
            
        }
        else if ([str_data isEqualToString:@"Change Password"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
            P_ChangeViewController *obj = [sb instantiateViewControllerWithIdentifier:@"p_change"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        //  Terms of Use",@"Privacy Policy
        else
        {
            
        }
    }
    if (tableView == _table_setup)
    {
        NSString *str_data1=[ary_setup objectAtIndex:indexPath.row];
        if ([str_data1 isEqualToString:@"About"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
            P_AboutViewController *obj = [sb instantiateViewControllerWithIdentifier:@"p_abt"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
        
        else if ([str_data1 isEqualToString:@"Help"])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://support.os4ed.com"]];
            
        }
        else if ([str_data1 isEqualToString:@"Terms of Use"])
        {
            
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
            P_TermsViewController *obj = [sb instantiateViewControllerWithIdentifier:@"p_term"];
            [self.navigationController pushViewController:obj animated:YES];
        }
        
        else
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"P_Settings" bundle:nil];
            P_PrivacyViewController*obj = [sb instantiateViewControllerWithIdentifier:@"p_privacy"];
            [self.navigationController pushViewController:obj animated:YES];
            
            
        }
        
        
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tablev) {
        return ary_gradebook.count;
    }
    else{
        return ary_setup.count;
    }
    
    return ary_setup.count;
}

- (SettingTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    
    if (tableView == self.tablev) {
        
        
        // cell = (SettingsMenuCell*)[tableView dequeueReusableCellWithIdentifier:@"SettingsMenuCell"];
        cell.clipsToBounds = YES;
        cell.lbl_txt.text = [NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]];
        NSLog(@"eta table %@",[NSString stringWithFormat:@"%@",[ary_gradebook objectAtIndex:indexPath.row]]);
    }
    else
    {
        // cell = (sTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"sTableViewCell" owner:self options:nil ]objectAtIndex:0];
        cell.clipsToBounds = YES;
        NSString *str = [NSString stringWithFormat:@"%@",[ary_setup objectAtIndex:indexPath.row]];
        cell.lbl_txt.text = NSLocalizedString( str, @"")  ;
        NSLog(@"eta table setup %@",[NSString stringWithFormat:@"%@",[ary_setup objectAtIndex:indexPath.row]]);
    }
    
    
    
    return cell;
    
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return multiheight1;
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
