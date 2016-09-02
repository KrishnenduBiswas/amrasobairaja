//
//  searchViewController.m
//  openSiS
//
//  Created by EjobIndia on 07/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "P_searchViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "ser.h"
#import "P_composeViewController.h"
//#import "P_cc.h"
//#import "P_Bcc.h"
//#import "P_ComposeAddGroup.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "P_msg1.h"
#import "TeacherDashboardViewController.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_composeViewController.h"
#import "P_SettingViewController.h"

@interface P_searchViewController ()
{
    NSString    * student_id,*s_year,*s_year_id ,*mp_id ,*action_type,*parentid;
}

@end

@implementation P_searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewonload];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    theSearchBar.text = self.str_search;
}

#pragma mark Tabbar
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
    [self.navigationController pushViewController:mvc animated:NO];}
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

-(void)viewonload
{
    
    //http://107.170.94.176/openSIS_CE6_Mobile/webservice/compose_mail_view.php?staff_id=2&school_id=1&syear=2015&mp_type=QTR&mp_id=16&action_type=&mail_id=
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    
    //student_id=[DF objectForKey:@"std_name"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"selected_student"]];
    
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    parentid=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STAFF_ID"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_compose_mail_view.php?parent_id=%@&student_id=%@&syear=%@&action_type=&mail_id=",parentid,student_id,s_year];
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
        NSLog(@"ONLOAD is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        allItemsArray = [[NSMutableArray alloc] init];
        displayItemsArray = [[NSMutableArray alloc] init];
      
        displayItemsArray = [[dictionary1 objectForKey:@"users"]mutableCopy];
        // array_assignment = [dictionary1 objectForKey:@"assignment_types"];
        //    NSMutableDictionary *dic_value=[[NSMutableDictionary alloc]init];
        
        NSLog(@"display item array---%@",displayItemsArray);
       
        [allItemsArray addObjectsFromArray:displayItemsArray];
        NSLog(@"allitem... %@",allItemsArray);
      
        [mtable reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
      //  transparentView.hidden=NO;
      //  NSLog(@"ok----");
       // [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  displayItemsArray.count;
}

- (ser *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ser *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    {
        cell = (ser*)[[[NSBundle mainBundle] loadNibNamed:@"ser" owner:self options:nil ]objectAtIndex:0];
        cell.clipsToBounds = YES;
        NSString *str = [NSString stringWithFormat:@"%@",[[displayItemsArray  objectAtIndex:indexPath.row]objectForKey:@"string"]];
        
        cell.lbl_txt.text=str;
    }
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 27.0f;
}




#pragma mark  searchbardelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        [displayItemsArray removeAllObjects];
        [displayItemsArray addObjectsFromArray:allItemsArray];
        
    } else {
        [displayItemsArray removeAllObjects];
        
        
        NSLog(@"----......-----%@",allItemsArray);
        for (NSDictionary *item in allItemsArray) {
            NSString *string = [item objectForKey:@"string"];
            NSRange range = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [displayItemsArray addObject:item];
            }
            
            
            else
            {
                
                NSLog(@"not found");
                
            }
        }
    }
    
    
    [mtable reloadData];
    
    
}

-(IBAction)next:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     NSString *str = [NSString stringWithFormat:@"%@",[[displayItemsArray  objectAtIndex:indexPath.row]objectForKey:@"username"]];
//    customorderViewController *parentViewController =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//    
//    parentViewController.stradd1 =self.searchDisplayController.searchBar.text;
// 
//    [self.navigationController popViewControllerAnimated:YES];
    theSearchBar.text=str;
}
-(IBAction)back:(id)sender
{
    if ([theSearchBar.text isEqualToString:@""] || [[theSearchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]  == 0) {
        theSearchBar.text = @"";
    }
    
    if ([self.str_v isEqualToString:@"1"]) {
    
       P_composeViewController *parentViewController =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    
        parentViewController.stradd1 =theSearchBar.text;
        parentViewController.userIsEditindToField = @"0";
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([self.str_v isEqualToString:@"cc"]) {
//        P_cc *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//        
//        if ([self.flag_field isEqualToString:@"to"]) {
//            parentViewController.stradd1 =theSearchBar.text;
//            parentViewController.str_cc =@"";
//            parentViewController.userIsEditindToField = @"0";
//        }
//        else if ([self.flag_field isEqualToString:@"cc"])
//        {
//            parentViewController.stradd1 = @"";
//            parentViewController.str_cc = theSearchBar.text;
//            parentViewController.userIsEditindToField = @"1";
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if ([self.str_v isEqualToString:@"bcc"])
    {
//        P_Bcc  *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//        
//        if ([self.flag_field isEqualToString:@"to"]) {
//            parentViewController.stradd1 =theSearchBar.text;
//            parentViewController.str_cc =@"";
//            parentViewController.str_bcc = @"";
//            parentViewController.userIsEditindToField = @"0";
//        }
//        else if ([self.flag_field isEqualToString:@"cc"])
//        {
//            parentViewController.stradd1 = @"";
//            parentViewController.str_bcc = @"";
//            parentViewController.str_cc = theSearchBar.text;
//            parentViewController.userIsEditindToField = @"1";
//        }
//        else if ([self.flag_field isEqualToString:@"bcc"])
//        {
//            parentViewController.stradd1 = @"";
//            parentViewController.str_cc = @"";
//            parentViewController.str_bcc = theSearchBar.text;
//            parentViewController.userIsEditindToField = @"2";
//        }
//
//        [self.navigationController popViewControllerAnimated:YES];
//
//        ;
    }
    else if ([self.str_v isEqualToString:@"add"])
    {
//        ComposeAddGroup *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//        
//        if ([self.flag_field isEqualToString:@"to"]) {
//            parentViewController.stradd1 =theSearchBar.text;
//            parentViewController.str_cc =@"";
//            parentViewController.str_bcc = @"";
//            parentViewController.userIsEditindToField = @"0";
//        }
//        else if ([self.flag_field isEqualToString:@"cc"])
//        {
//            parentViewController.stradd1 = @"";
//            parentViewController.str_bcc = @"";
//            parentViewController.str_cc = theSearchBar.text;
//            parentViewController.userIsEditindToField = @"1";
//        }
//        else if ([self.flag_field isEqualToString:@"bcc"])
//        {
//            parentViewController.stradd1 = @"";
//            parentViewController.str_cc = @"";
//            parentViewController.str_bcc = theSearchBar.text;
//            parentViewController.userIsEditindToField = @"2";
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
//
//        ;
    }

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    [theSearchBar resignFirstResponder];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [theSearchBar resignFirstResponder];
    [searchBar resignFirstResponder];
    
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
