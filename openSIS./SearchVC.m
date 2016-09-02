//
//  SearchVC.m
//  openSiS
//
//  Created by os4ed on 4/5/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "SearchVC.h"
#import "CCViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "searchcell.h"
#import "Msg_compose_ViewController.h"
#import "BccViewController.h"
#import "S_addgrpcomposeViewController.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"

@interface SearchVC ()
{

    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;


}


@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewonload];
    // Do any additional setup after loading the view.
}
-(IBAction)report:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    S_ReportViewController * report=[[S_ReportViewController alloc]init];
    report=[sb instantiateViewControllerWithIdentifier:@"rprt"];
    
    //report.sel_mp=period123;
    
    
    [self.navigationController pushViewController:report animated:YES];
    
    
    
}


-(void)viewonload
{
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    //    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
    //    student_id=[DF objectForKey:@"iphone"];
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_compose_mail_view.php?student_id=%@&school_id=%@&syear=%@",student_id,s_year_id,s_year];
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

- (searchcell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    searchcell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    {
        cell = (searchcell*)[[[NSBundle mainBundle] loadNibNamed:@"ser" owner:self options:nil ]objectAtIndex:0];
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = [NSString stringWithFormat:@"%@",[[displayItemsArray  objectAtIndex:indexPath.row]objectForKey:@"username"]];
    
    theSearchBar.text=str;
}





- (void)viewWillAppear:(BOOL)animated
{
    theSearchBar.text = self.str_search;
}
-(IBAction)back:(id)sender
//{
//    if ([theSearchBar.text isEqualToString:@""] || [[theSearchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]  == 0) {
//        theSearchBar.text = @"";
//    }
//    
//    if ([self.str_v isEqualToString:@"1"]) {
////        
////        composeViewController *parentViewController =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
////        
////        parentViewController.stradd1 =theSearchBar.text;
////        parentViewController.userIsEditindToField = @"0";
////        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else if ([self.str_v isEqualToString:@"cc"]) {
//        CCViewController *ccvc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//        
//        if ([self.flag_field isEqualToString:@"to"]) {
//            ccvc.stradd1 =theSearchBar.text;
//            ccvc.str_cc =@"";
//            ccvc.userIsEditindToField = @"0";
//        }
//        else if ([self.flag_field isEqualToString:@"cc"])
//        {
//            ccvc.stradd1 = @"";
//            ccvc.str_cc = theSearchBar.text;
//           ccvc.userIsEditindToField = @"1";
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }
//    else if ([self.str_v isEqualToString:@"bcc"])
//    {
////        Bcc  *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
////        
////        if ([self.flag_field isEqualToString:@"to"]) {
////            parentViewController.stradd1 =theSearchBar.text;
////            parentViewController.str_cc =@"";
////            parentViewController.str_bcc = @"";
////            parentViewController.userIsEditindToField = @"0";
////        }
////        else if ([self.flag_field isEqualToString:@"cc"])
////        {
////            parentViewController.stradd1 = @"";
////            parentViewController.str_bcc = @"";
////            parentViewController.str_cc = theSearchBar.text;
////            parentViewController.userIsEditindToField = @"1";
////        }
////        else if ([self.flag_field isEqualToString:@"bcc"])
////        {
////            parentViewController.stradd1 = @"";
////            parentViewController.str_cc = @"";
////            parentViewController.str_bcc = theSearchBar.text;
////            parentViewController.userIsEditindToField = @"2";
////        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
//        
//        ;
//    }
//    else if ([self.str_v isEqualToString:@"add"])
//    {
//        //        ComposeAddGroup *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//        //
//        //        if ([self.flag_field isEqualToString:@"to"]) {
//        //            parentViewController.stradd1 =theSearchBar.text;
//        //            parentViewController.str_cc =@"";
//        //            parentViewController.str_bcc = @"";
//        //            parentViewController.userIsEditindToField = @"0";
//        //        }
//        //        else if ([self.flag_field isEqualToString:@"cc"])
//        //        {
//        //            parentViewController.stradd1 = @"";
//        //            parentViewController.str_bcc = @"";
//        //            parentViewController.str_cc = theSearchBar.text;
//        //            parentViewController.userIsEditindToField = @"1";
//        //        }
//        //        else if ([self.flag_field isEqualToString:@"bcc"])
//        //        {
//        //            parentViewController.stradd1 = @"";
//        //            parentViewController.str_cc = @"";
//        //            parentViewController.str_bcc = theSearchBar.text;
//        //            parentViewController.userIsEditindToField = @"2";
//        //        }
//        //        
//        //        [self.navigationController popViewControllerAnimated:YES];
//        //
//        //        ;
//    }

{
    if ([theSearchBar.text isEqualToString:@""] || [[theSearchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]  == 0) {
        theSearchBar.text = @"";
    }
    
    if ([self.str_v isEqualToString:@"1"]) {
        
        Msg_compose_ViewController * parentViewController =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        
        parentViewController.stradd1 =theSearchBar.text;
        parentViewController.userIsEditindToField = @"0";
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([self.str_v isEqualToString:@"cc"]) {
        CCViewController *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        
        if ([self.flag_field isEqualToString:@"to"]) {
            parentViewController.stradd1 =theSearchBar.text;
            parentViewController.str_cc =@"";
            parentViewController.userIsEditindToField = @"0";
        }
        else if ([self.flag_field isEqualToString:@"cc"])
        {
            parentViewController.stradd1 = @"";
            parentViewController.str_cc = theSearchBar.text;
            parentViewController.userIsEditindToField = @"1";
        }
    
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if ([self.str_v isEqualToString:@"bcc"])
    {
        BccViewController  *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        
        if ([self.flag_field isEqualToString:@"to"]) {
            parentViewController.stradd1 =theSearchBar.text;
            parentViewController.str_cc =@"";
            parentViewController.str_bcc = @"";
            parentViewController.userIsEditindToField = @"0";
        }
        else if ([self.flag_field isEqualToString:@"cc"])
        {
            parentViewController.stradd1 = @"";
            parentViewController.str_bcc = @"";
            parentViewController.str_cc = theSearchBar.text;
            parentViewController.userIsEditindToField = @"1";
        }
        else if ([self.flag_field isEqualToString:@"bcc"])
        {
            parentViewController.stradd1 = @"";
            parentViewController.str_cc = @"";
            parentViewController.str_bcc = theSearchBar.text;
            parentViewController.userIsEditindToField = @"2";
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }

    else if ([self.str_v isEqualToString:@"add"])
    {
                S_addgrpcomposeViewController *parentViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        
                if ([self.flag_field isEqualToString:@"to"]) {
                    parentViewController.stradd1 =theSearchBar.text;
                    parentViewController.str_cc =@"";
                    parentViewController.str_bcc = @"";
                    parentViewController.userIsEditindToField = @"0";
                }
                else if ([self.flag_field isEqualToString:@"cc"])
                {
                    parentViewController.stradd1 = @"";
                    parentViewController.str_bcc = @"";
                    parentViewController.str_cc = theSearchBar.text;
                    parentViewController.userIsEditindToField = @"1";
                }
                else if ([self.flag_field isEqualToString:@"bcc"])
                {
                    parentViewController.stradd1 = @"";
                    parentViewController.str_cc = @"";
                    parentViewController.str_bcc = theSearchBar.text;
                    parentViewController.userIsEditindToField = @"2";
                }
                
                [self.navigationController popViewControllerAnimated:YES];
        
                ;
    }
    


    
}

-(IBAction)home:(id)sender
{
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SdashboardViewController *home=[[SdashboardViewController alloc]init];
    home=[sb instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:home animated:NO];
    
    
    
    
    
}
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
