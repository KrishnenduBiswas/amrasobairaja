//
//  P_LastfinalViewController.m
//  openSiS
//
//  Created by os4ed on 8/4/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "P_LastfinalViewController.h"
#import "MyTableViewCell.h"
#import "TopTableViewCell.h"
#import "AFNetworking.h"
#import "PtdgrdbookTableViewCell.h"
#import "Grade_p_ViewController.h"
#import "P_Grade_detail_ViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "CPdetails.h"
#import "pdashboardViewController.h"
#import "P_msg1.h"
#import "P_SettingViewController.h"
#import "P_FinalTableViewCell.h"

@interface P_LastfinalViewController ()
{
    NSMutableArray * cp_ary;
    NSMutableDictionary *dTmp;
    NSMutableArray*newary;
    
    
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type;
    
    
    NSString    *parentid;

}

@end
int flag=0;
@implementation P_LastfinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    NSDictionary *dTmp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    //    self.arrayOriginal = [dTmp valueForKey:@"Objects"];
    //
    //    self.arForTable = [[NSMutableArray alloc] init];
    //    [self.arForTable addObjectsFromArray:self.arrayOriginal];
    //    self.title=@"Sugartin.info";
    
    
    
    
    
    
    self.tblForCollapse.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
    
    
    
    
    [self loaddata1];
    
    
    
    
    
    
}





-(void)loaddata1
{
    
    
    
    
    
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
//    NSString*str_checklogin=[NSString stringWithFormat:@"/parent/parent_final_grades.php?parent_id=%@&student_id=%@&syear=%@&mp_id=%@",parentid,student_id,s_year,mp_id];
//    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
//    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
//    
//    NSLog(@"----%@",url12);
//    NSURL *url = [NSURL URLWithString:url12];

    
    
    NSString*str_checklogin=[NSString stringWithFormat:@"http://107.170.94.176/openSIS_CE6_Mobile/webservice/parent/parent_final_grades.php?parent_id=2&student_id=1&syear=2015&mp_id=18"];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@",str_checklogin];
    
    NSLog(@"----%@",url12);
    NSURL *url = [NSURL URLWithString:url12];
 
    
    
    
    
 
    
    NSData*data=[NSData dataWithContentsOfURL:url];
    
    
    
    
    NSMutableDictionary*dictionary1=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    
    NSLog(@"............%@",dictionary1);
    
    
    
    NSString *str_succ1=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
    
    if ([str_succ1 isEqualToString:@"1"]) {
        
        
        
        
        
        
        
        
        cp_ary =[[NSMutableArray alloc]init];
        cp_ary=[dictionary1 objectForKey:@"mp_data"];
        
        NSArray *final_grade     = [[NSArray alloc]init];
        final_grade=[dictionary1 objectForKey:@"final_grades"];
        
        newary=[[NSMutableArray alloc]init];
        
        for (int i=0; i<cp_ary.count; i++) {
            
            dTmp = [[NSMutableDictionary alloc]init];
            
            [dTmp setObject:final_grade forKey:@"final_grade"];
            
            NSString*str_title=(NSString*)[[cp_ary objectAtIndex:i]objectForKey:@"TITLE"];
            NSString*str_value=(NSString*)[[cp_ary objectAtIndex:i]objectForKey:@"VALUE"];
            
            [dTmp setObject:str_title forKey:@"TITLE"];
            [dTmp setObject:str_value forKey:@"VALUE"];
            [newary addObject:dTmp];
            
            
        }
        
        
        NSLog(@"newarray...%@",newary);
        
        
    }
    
    
    else
    {
        NSLog(@"not success");
        
    }
    
    
    
    
}


//Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newary count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *CellIdentifier = @"Cell";
    //
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    //
    //
    //    }
    //
    //    cell.textLabel.text=[[newary objectAtIndex:indexPath.row] valueForKey:@"TITLE"];
    
    if (flag==1) {
        
        
        
        MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"A"];
        
        cell = (MyTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil ]objectAtIndex:0];
        
        
        
        
        NSString*str=@"%";
        
        
        cell.lbl1.text=[self nullChecker:[[newary objectAtIndex:indexPath.row] valueForKey:@"COURSE_TITLE"]];
        cell.lbl2.text=[self nullChecker:[[newary objectAtIndex:indexPath.row] valueForKey:@"TEACHER"]];
        cell.lbl3.text=[self nullChecker:[NSString stringWithFormat:@"%@%@",[[newary objectAtIndex:indexPath.row] valueForKey:@"GRADE_PERCENT"],str]];
        //cell.lbl4.text=[self nullChecker:[[newary objectAtIndex:indexPath.row] valueForKey:@"GRADE_TITLE"]];
        cell.grade.text=[self nullChecker:[[newary objectAtIndex:indexPath.row] valueForKey:@"COMMENT"]];
        
        return cell;
    }
    
    
    
    if (flag==0) {
        
        
        
        TopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"B"];
        
        cell = (TopTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"TopTableViewCell" owner:self options:nil ]objectAtIndex:0];
        
        
        
        
        
        
        
        cell.lbl1.text=[[newary objectAtIndex:indexPath.row] valueForKey:@"TITLE"];
        
        
        return cell;
    }
    
    
    
    
    
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *d=[newary objectAtIndex:indexPath.row];
    if([d valueForKey:@"final_grade"]) {
        NSArray *ar=[[NSArray alloc]init];
        ar=[d valueForKey:@"final_grade"];
        
        
        NSLog(@"arrr...%@",ar);
        
        BOOL isAlreadyInserted=NO;
        
        for(NSDictionary *dInner in ar ){
            NSInteger index=[newary indexOfObjectIdenticalTo:dInner];
            isAlreadyInserted=(index>0 && index!=NSIntegerMax);
            flag=1;
            if(isAlreadyInserted)
                break;
            
            
        }
        
        if(isAlreadyInserted) {
            [self miniMizeThisRows:ar];
        } else {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arCells=[NSMutableArray array];
            for(NSDictionary *dInner in ar ) {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [newary insertObject:dInner atIndex:count++];
            }
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    }
}









- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (flag==1) {
        return 60.0f;
    }
    
    
    return 44;
    
    
}









-(void)miniMizeThisRows:(NSArray*)ar{
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[newary indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"final_grade"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        
        if([newary indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [newary removeObjectIdenticalTo:dInner];
            [self.tblForCollapse deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                         [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                         ]
                                       withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}





- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}











-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
