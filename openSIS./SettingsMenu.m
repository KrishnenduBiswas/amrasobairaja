//
//  SettingsMenu.m
//  openSiS
//
//  Created by os4ed on 1/11/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "SettingsMenu.h"
#import "SlideViewController.h"
#import "GradebookConfigController.h"
#import "AppDelegate.h"
#import "GradesTotalViewController.h"
#import "PostfinalgradesController.h"
#import "schoolinfo.h"
#import "snViewController.h"
#import "SettingsMenuCell.h"
#import "MyInformationGeneral.h"
#import "ChangePassword.h"
#import "ABOUT.h"
#import "terms.h"
#import "privacy.h"

#import "SettingsMenu.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"
//#import “MystdInformationGeneral.h”




//#import "Month1ViewController.h"

@interface SettingsMenu ()
{
     NSMutableArray *ary_gradebook, *ary_setup;
    SlideViewController *slide;
    int multiheight;
}
@property (strong, nonatomic) IBOutlet UIView *view_gradebook;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property (strong, nonatomic) IBOutlet UIView *baseView;

@property (strong, nonatomic) IBOutlet UITableView *table_setup;
@property (strong, nonatomic) IBOutlet UIView *view_setup;
@end

@implementation SettingsMenu

@synthesize baseView;


- (void)viewDidLoad {
    [super viewDidLoad];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"gradesmain"];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    
    
//    _view_firstView.layer.borderWidth = 1.0f;
//    _view_firstView.layer.borderColor = [[UIColor colorWithRed:0.808f green:0.808f blue:0.808f alpha:1.00f]CGColor];
//    [_view_firstView.layer setCornerRadius:3.5f];
//    _view_firstView.clipsToBounds = YES;
    
    
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
    
    // Do any additional setup after loading the view.
}



-(void)open
{
    [slide open:self.view];
}
-(void)close
{
    [slide close:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    // eta gradebook view er height set korar jonno
    
    if (self.view.frame.size.height == 568) {
        multiheight = 36;
    }
    else if (self.view.frame.size.height == 667)
    {
        multiheight = 42;
    }
    else if (self.view.frame.size.height == 736)
    {
        multiheight = 48;
    }
    
    int k2 = (int)ary_gradebook.count;
    int totalheight = k2 * multiheight;
    CGRect rec = self.view_gradebook.frame;
    rec.size.height = totalheight;
    [self.view_gradebook setFrame:rec];
//
    int k3 = (int)ary_setup.count;
    int totalheight2 = k3 * multiheight;
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



-(IBAction)click:(id)sender
{
    [self open];
}


#pragma mark - Table Delegate and Datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tablev) {
        NSString *str_data=[ary_gradebook objectAtIndex:indexPath.row];
        if([str_data isEqualToString:@"My Information"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
            MyInformationGeneral *obj = [sb instantiateViewControllerWithIdentifier:@"MyInformationGeneral"];
            
            
            [self.navigationController pushViewController:obj animated:YES];
            
            
        }
        else if ([str_data isEqualToString:@"Change Password"])
        {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
            ChangePassword *obj = [sb instantiateViewControllerWithIdentifier:@"ChangePassword"];
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
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
           ABOUT *obj = [sb instantiateViewControllerWithIdentifier:@"about"];
            [self.navigationController pushViewController:obj animated:YES];
            
        }
  
        else if ([str_data1 isEqualToString:@"Help"])
        {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://support.os4ed.com"]];
            
        }
          else if ([str_data1 isEqualToString:@"Terms of Use"])
          {
          
              UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
              terms *obj = [sb instantiateViewControllerWithIdentifier:@"term"];
              [self.navigationController pushViewController:obj animated:YES];
          }
         
         else
         {
             UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
             privacy*obj = [sb instantiateViewControllerWithIdentifier:@"privacy"];
             [self.navigationController pushViewController:obj animated:YES];

         
         }
  
        
    }
    else
    {
//        NSString *str_data = [ary_setup objectAtIndex:indexPath.row];
//        if ([str_data isEqualToString:@"Gradebook Configuration"]) {
//            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            GradebookConfigController *obj = [[GradebookConfigController alloc]init];
//            obj = [sb instantiateViewControllerWithIdentifier:@"gradebookconfig"];
//            
//            [self.navigationController pushViewController:obj animated:YES];
//        }
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

- (SettingsMenuCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingsMenuCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsMenuCell"];
    
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return multiheight;
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




#pragma mark - Tabbar

#pragma mark---Settings

-(IBAction)settings:(id)sender
{
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
}


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

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}

















@end
