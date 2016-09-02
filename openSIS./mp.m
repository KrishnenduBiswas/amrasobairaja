//
//  TeacherDashboardViewController.m
//  openSiS
//
//  Created by EjobIndia on 17/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//
#import "AppDelegate.h"
#import "TeacherDashboardViewController.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
#import "attendence.h"
#import "GradesViewController.h"
#import "AFNetworking.h"
#import "schoolinfo.h"
#import "ip_url.h"
#import "MBProgressHUD.h"
#import "ScheduleHomeController.h"
#import "msg1.h"
#import "SettingsMenu.h"
#import "Month1ViewController.h"
#import "stdsearch.h"
#import "SettingsMenu.h"
#import "AppDelegate.h"
#import "mp.h"
#import "semister_details.h"
@interface mp ()
{
    SlideViewController *slide;
    NSString *courseperiodnamestr;
    
    IBOutlet UIView *external_view;
}

@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;

@end

@implementation mp
@synthesize dic,img_profile,profile;

@synthesize  school_id,school_year1,str_term1,str_sub1,str_cou1,str_cp1,dic_techinfo;


-(void)showdata1
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loadata) withObject:nil afterDelay:3.0];
        });
    });

    


}


#pragma mark---Settings
-(void)loadata
{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
       NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
     NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/marking_periods.php?staff_id=%@&school_id=%@&syear=%@",STAFF_ID_K,school_id1,year_id];
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url12=[NSString stringWithFormat:@"%@%@",str123,str_checklogin];
    
    NSLog(@"----%@",url12);

 //   NSString *url12=[NSString stringWithFormat:@"http://107.170.94.176/openSIS_CE6_Mobile/webservice/marking_periods.php?staff_id=2&school_id=1&syear=2015"];
    // NSLog(@"url12---%@",url12);
    // NSString *url12=[NSString stringWithFormat:@"%@%@",ip,str_checklogin];
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        // NSLog(@"-----%@",dictionary1);
        
        marking_period =[[NSMutableArray alloc]init];
        
        self.ary_title=[[NSMutableArray alloc]init];
        
        
        //        for (NSMutableDictionary *dic in marking_period) {
        //            self.tabarry=marking_period;
        //            NSLog(@"%@",[[self.tabarry objectAtIndex:0]objectForKey:@"TITLE"]);
        //        }
        //
        
        
        self.ary_title=[[dictionary1 objectForKey:@"marking_periods"]mutableCopy ];
        
        
        NSLog(@"markingperiod data---------%@",self.ary_title);
        
        for (int i=0; i<[marking_period count]; i++) {
            
            
            [self.ary_title addObject:[[marking_period objectAtIndex:i]objectForKey:@"TITLE"]];
            
        }
        
        NSLog(@"------------%@",self.ary_title);
        //NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        //        for (int i=0; i<[self.ary_title count]; i++) {
        //
        //
        //        NSDictionary *d=[self.ary_title objectAtIndex:i];
        //        if([d objectForKey:@"semester"]) {
        //            NSArray *ar=[d objectForKey:@"semester"];
        //
        //            BOOL isAlreadyInserted=NO;
        //
        //            for(NSDictionary *dInner in ar ){
        //                NSInteger index=[self.ary_title indexOfObjectIdenticalTo:dInner];
        //                isAlreadyInserted=(index>0 && index!=NSIntegerMax);
        //                if(isAlreadyInserted) break;
        //            }
        //
        //            if(isAlreadyInserted) {
        //                [self miniMizeThisRows:ar];
        //            } else {
        //                NSUInteger count=i+1;
        //                NSMutableArray *arCells=[NSMutableArray array];
        //                for(NSDictionary *dInner in ar ) {
        //                    [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
        //                    [self.ary_title insertObject:dInner atIndex:count++];
        //                }
        //
        //
        //                [self.tblForCollapse insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
        //            }
        //        }
        //        }
        
        [self.tblForCollapse reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [operation start];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ary_title count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.0f;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        //  NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"cell1" owner:self options:nil];
        //  cell=[nib objectAtIndex:0];
        for (int x=0; x<[self.ary_title count]; x++) {
            
            cell.indentationLevel=x;
            
        }
        
    }
    //    static NSString *CellIdentifier = @"Cell";
    //    cell1*c= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (c == nil) {
    //        c = (cell1*)[[[NSBundle mainBundle] loadNibNamed:@"cell1" owner:nil options:nil] objectAtIndex:0];
    //   	}
    
    // c.lbl_cell.text=[[self.ary_title objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    cell.textLabel.textColor=[UIColor  colorWithRed:60.0/255 green:137.0/255 blue:189.0/255 alpha:1.0];
    
    cell.textLabel.text=[[self.ary_title objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    cell.detailTextLabel.textColor=[UIColor lightGrayColor];
    
    NSString *b_date1=[[self.ary_title objectAtIndex:indexPath.row]objectForKey:@"START_DATE"];
    NSString *e_date1=[[self.ary_title objectAtIndex:indexPath.row]objectForKey:@"END_DATE"];
    NSString *b_date=[self nullChecker:b_date1];
     NSString *e_date=[self nullChecker:e_date1];
    //POST_END_DATE
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [df dateFromString:b_date];
    [df setDateFormat:@"MMM dd, yyyy"];
   NSString *str1=[df stringFromDate:date];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    [df1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [df1 dateFromString:e_date];
    [df1 setDateFormat:@"MMM dd, yyyy"];
    NSString *str2=[df1 stringFromDate:date1];
    
     cell.detailTextLabel.text=[NSString stringWithFormat:@"Begins :%@ - Ends :%@",str1,str2];
    //    NSUInteger indentLevel = 1;
    
    //  c.indentationLevel=j;
    
    // }
    
    
    //cell.indentationLevel=indexPath.row % 2 -2;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    //    if (clickedIndex == 0)
    //    {
    //        clickedIndex++;
    //        [button setImage:[UIImage imageNamed:@"minus.png"] forState:UIControlStateNormal];
    //    }
    //
    //    else
    //    {
    //        clickedIndex  = 0;
    //        [button setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    //
    //    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    NSLog(@"----------------------%@",[self.ary_title objectAtIndex:indexPath.row]);
    NSDictionary *d=[self.ary_title objectAtIndex:indexPath.row];
    if([d objectForKey:@"semester"]) {
        NSArray *ar=[d objectForKey:@"semester"];
        
        BOOL isAlreadyInserted=NO;
        
        for(NSDictionary *dInner in ar ){
            
            NSInteger index=[self.ary_title indexOfObjectIdenticalTo:dInner];
            isAlreadyInserted=(index>0 && index!=NSIntegerMax);
            if(isAlreadyInserted) break;
        }
        
        if(isAlreadyInserted) {
            
            [self miniMizeThisRows:ar];
        } else {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arCells=[NSMutableArray array];
            for(NSDictionary *dInner in ar ) {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.ary_title insertObject:dInner atIndex:count++];
            }
            
            
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    
    
    
    if([d objectForKey:@"quarter"]) {
        NSArray *ar=[d objectForKey:@"quarter"];
        
        BOOL isAlreadyInserted=NO;
     //   cell.textLabel.textColor=[UIColor greenColor];
        for(NSDictionary *dInner in ar ){
            NSInteger index=[self.ary_title indexOfObjectIdenticalTo:dInner];
            isAlreadyInserted=(index>0 && index!=NSIntegerMax);
            if(isAlreadyInserted) break;
        }
        
        if(isAlreadyInserted) {
            [self miniMizeThisRows:ar];
        } else {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arCells=[NSMutableArray array];
            for(NSDictionary *dInner in ar ) {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.ary_title insertObject:dInner atIndex:count++];
            }
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    }
    
    if([d objectForKey:@"progress_periods"]) {
        NSArray *ar=[d objectForKey:@"progress_periods"];
        
        BOOL isAlreadyInserted=NO;
        
        for(NSDictionary *dInner in ar ){
            NSInteger index=[self.ary_title indexOfObjectIdenticalTo:dInner];
            isAlreadyInserted=(index>0 && index!=NSIntegerMax);
            if(isAlreadyInserted) break;
        }
        
        if(isAlreadyInserted) {
            [self miniMizeThisRows:ar];
        } else {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arCells=[NSMutableArray array];
            for(NSDictionary *dInner in ar ) {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.ary_title insertObject:dInner atIndex:count++];
            }
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
            
        }
    }
    
  //  Summer Semester
    //progress_periods
    
    
}

- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}

-(void)miniMizeThisRows:(NSArray*)ar{
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[self.ary_title indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner objectForKey:@"semester"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        
        if([self.ary_title indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [self.ary_title removeObjectIdenticalTo:dInner];
            [self.tblForCollapse deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                         [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                         ]
                                       withRowAnimation:UITableViewRowAnimationRight];
        }
    }
    
    
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[self.ary_title indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner objectForKey:@"quarter"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        
        if([self.ary_title indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [self.ary_title removeObjectIdenticalTo:dInner];
            [self.tblForCollapse deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                         [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                         ]
                                       withRowAnimation:UITableViewRowAnimationRight];
        }
    }
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[self.ary_title indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner objectForKey:@"progress_periods"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        
        if([self.ary_title indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [self.ary_title removeObjectIdenticalTo:dInner];
            [self.tblForCollapse deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                         [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                         ]
                                       withRowAnimation:UITableViewRowAnimationRight];
        }
    }
    
}

-(IBAction)settings:(id)sender
{
    
UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings" bundle:nil];
SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
[self.navigationController pushViewController:obj animated:YES];

    
}

-(IBAction)back:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark-------Getdata
-(NSString *)getCourseperiodtextfielddata
{
   courseperiodnamestr = [NSString stringWithFormat:@"%@",courseperiodName.text];
    return courseperiodnamestr;
}
#pragma mark-------setdata
-(void)setCourseperiodtextfielddata:(NSString*)str
{
    courseperiodnamestr=str;
    NSLog(@"value tar nume -------------%@",courseperiodnamestr);
    courseperiodName.text = courseperiodnamestr;
}



#pragma mark-------viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showdata1];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
   
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressed:)];
    longpress.minimumPressDuration = 1.5;
    longpress.delegate = self;
    [self.tblForCollapse addGestureRecognizer:longpress];
  //  [self showdata];
    slide = [[SlideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"mpperiod"];
   
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];

    [self droptable];
    
    ca_cp_id=[[NSMutableArray alloc]init];
   course_period_ary=[[NSMutableArray alloc]init];
    [self alldata];
    //[self alldata];
  [self courseperiod123];
  //  [self alldata];
//    [self courseperiodname];
    [self tabledata];
    
    //*currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName
    
    UITapGestureRecognizer *mising= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(m_attendence:)];
    mising.numberOfTapsRequired = 1;
  
    //[self.view addGestureRecognizer:tapmainview];
    [view_missing_attendence addGestureRecognizer:mising];
    
    
  
    
    
//    newView.frame=CGRectMake(0, 0, self.view.frame.size.width - 50, self.view.frame.size.height);
//    int x = newView.frame.size.width;
//    slidewidth = x / 2;
//    int y1 = newView.frame.size.height;
//    
//    slideheight = y1 / 2;
    //[Xbutton setFrame:CGRectMake(213, 0, 46, 30)];
    
    //[newView addSubview:Xbutton];
    // Do any additional setup after loading the view.
    /*UITapGestureRecognizer *tapmainview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    tapmainview.numberOfTapsRequired = 1;
    tapmainview.delegate = self;
    //[self.view addGestureRecognizer:tapmainview];
    [baseView addGestureRecognizer:tapmainview];*/
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    [baseView addGestureRecognizer:swiperight];
    mtable.userInteractionEnabled=YES;
    //table.userInteractionEnabled = YES;
    //[table addGestureRecognizer:tapmainview];
    //newView.userInteractionEnabled = NO;
    
    flag =0;k=0;
    [labelView setFrame:CGRectMake(labelView.frame.origin.x, labelView.frame.origin.y, self.view.frame.size.width, 0)];
    labelView.backgroundColor = [UIColor redColor];
    

}
- (void)pressed:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:self.tblForCollapse];
    
    NSIndexPath *indexPath = [self.tblForCollapse indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
       NSLog(@"----------ki kore hobe------------%@",[self.ary_title objectAtIndex:indexPath.row]);
        
       
        
        
        NSDictionary *d=[self.ary_title objectAtIndex:indexPath.row];
       // NSMutableArray *sem_arry=[[NSMutableArray alloc]init];
       // sem_arry=[ d objectForKey:@"semester"];
        
        
     

        
        
        

        
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
        semister_details *obj = [sb instantiateViewControllerWithIdentifier:@"semdetail"];
        obj.dictionary1=[self.ary_title objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:obj animated:NO];
       
    } else {
        NSLog(@"gestureRecognizer.state = %ld", (long)gestureRecognizer.state);
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    [self fetchdata];
    [self setcourseperiodonthisobj];
  //  [self showdata];
}


-(IBAction)m_attendence:(id)sender
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    attendence* vc = [storyboard instantiateViewControllerWithIdentifier:@"atten"];
    vc.dic=dic;
    vc.dic_techinfo=dic_techinfo;
    vc.school_name=currentSchool.text;
    vc.school_year_name=schoolYear.text;
    vc.school_term=term.text;
    vc.school_sub=subject.text;
    vc.school_course=course.text;
    vc.school_courseperiod=coursePeriod.text;
    vc.school_courseperiodname=courseperiodName.text;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    




}
- (void)setcourseperiodonthisobj
{
    

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableArray * course_period_title_2,* course_period_id_2;
    if (appDelegate.dic) {
        
        NSMutableArray * course_temp_arr = [[NSMutableArray alloc]init];
        course_temp_arr = [[appDelegate.dic objectForKey:@"School_list"]mutableCopy];
        
        if ([course_temp_arr count]>0) {
            course_period_title_2= [[NSMutableArray alloc] init];
            course_period_id_2 = [[NSMutableArray alloc] init];
            for (int i = 0; i<[course_temp_arr count]; i++) {
                NSDictionary *dic15 = [course_temp_arr objectAtIndex:i];
                [course_period_title_2  addObject:[dic15 objectForKey:@"title"]];
                [course_period_id_2 addObject:[dic15 objectForKey:@"id"]];
            }
            
            NSLog(@"222222222222222 %@",course_period_title);
            //[selectcustomerpicker reloadAllComponents];
            
        }
        else {
            NSLog(@"No  list");
        }
        
        NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
        NSInteger indexofcpv = [course_period_id_2 indexOfObject:cpv_id1];
        //[self setCourseperiodtextfielddata:[NSString stringWithFormat:@"%@",[course_period_title objectAtIndex:indexofcpv]]];
        courseperiodName.text = [NSString stringWithFormat:@"%@",[course_period_title_2 objectAtIndex:indexofcpv]];
        
    }
    
}


-(void)showdata
{
  AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  //  dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    NSLog(@"slide--value------%@",appDelegate.cp_value);
    // NSLog(@"dic===========%@",dic);
    course_period_ary=[[dic objectForKey:@"course_period_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"cpv_id"]];
            
        }
        
    }
    else {
        // NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"UserCoursePeriod"]];
    
    
    //  NSLog(@"course ary----%@",course_period_ary);
    for (int i=0; i<[course_period_ary count]; i++) {
        
        
        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"cp_id"]]) {
            dic177=[course_period_ary objectAtIndex:i];
            
            c_ap=true;
            break;
            
        }
        
        
        else
        {
            
            
            
        }
        
    }
    
    if (c_ap==true) {
        coursePeriod.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"cpv_id"]];
    }
    
    else
    {
        
        
        coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
        
        
    }
    
    [self courseperiod123];

}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == courseperiodName) {
        [courseperiodName resignFirstResponder];
        
    }
    
    return YES;
}
-(void)droptable{
    
   // [msg_count sizeToFit];
  //  [notofi sizeToFit];
  //  [msg_count_tab sizeToFit];
    
//   lbl_hidden.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"missing_attendance_count"]];
//    notofi.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"notification_count"]];
//    NSString *str_count=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
//    if ([str_count isEqualToString:@"0"]) {
//        msg_count_tab.hidden=YES;
//         msg_count.hidden=YES;
//    }
//    else
//    {
//        msg_count_tab.hidden=NO;
//        msg_count.hidden=NO;
//
//     msg_count_tab.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
//       msg_count.text=[NSString stringWithFormat:@"%@",[dic_techinfo objectForKey:@"message_count"]];
//    }
//    NSLog(@"lbl___---%@",lbl_hidden.text);
   // lbl_lvlview_drop.text =[NSString stringWithFormat:@"You have %@ mising attendence",[dic_techinfo objectForKey:@"missing_attendance_count"]];
    if (![lbl_hidden.text isEqual:@"0"] && flag == 0) {
        
        
        [UIView animateWithDuration:0.5f animations:^{
            labelView.frame =
            CGRectMake(labelView.frame.origin.x,
                       labelView.frame.origin.y,
                       labelView.frame.size.width,
                       labelView.frame.size.height + 40);
            
        }];
        [UIView animateWithDuration:0.5f animations:^{
            table.frame =
            CGRectMake(table.frame.origin.x,
                       table.frame.origin.y + 40,
                       table.frame.size.width,
                       table.frame.size.height);
            
        }];
        
        flag = 1;
        k = 1;
        
    }
    else if([lbl_hidden.text isEqual:@"0"] && k == 1)
    {
        [UIView animateWithDuration:0.5f animations:^{
            labelView.frame =
            CGRectMake(labelView.frame.origin.x,
                       labelView.frame.origin.y,
                       labelView.frame.size.width,
                       labelView.frame.size.height - 40);
            
        }];
        
        [UIView animateWithDuration:0.5f animations:^{
            table.frame =
            CGRectMake(table.frame.origin.x,
                       table.frame.origin.y - 40,
                       table.frame.size.width,
                       table.frame.size.height);
            
        }];
        
        flag = 0;
        k =0;
        
    }

}

-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
   courseperiodName.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    courseperiodName.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}

-(void)labelborderset:(UILabel*)lbl1
{
    lbl1.layer.borderWidth=4.0f;
    lbl1.layer.borderColor=[UIColor clearColor].CGColor;
    lbl1.layer.cornerRadius=2.0f;
    lbl1.clipsToBounds=YES;
}

-(void)alldata
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //someString = appDelegate.dic;  //..to read
    //  appDelegate.dic =dic;     //..to write
    // appDelegate.dic_techinfo=dic_techinfo;
    
    
    dic_techinfo=appDelegate.dic_techinfo;
    dic=appDelegate.dic;
    NSLog(@"dic===========%@",dic);
    course_period_ary=[[dic objectForKey:@"School_list"]mutableCopy];
    
    if ([course_period_ary count]>0) {
        course_period_title= [[NSMutableArray alloc] init];
        course_period_id = [[NSMutableArray alloc] init];
        for (int i = 0; i<[course_period_ary count]; i++) {
            NSDictionary *dic15 = [course_period_ary objectAtIndex:i];
            [course_period_title  addObject:[dic15 objectForKey:@"title"]];
            [course_period_id addObject:[dic15 objectForKey:@"id"]];
            // [ca_cp_id addObject:[dic15 objectForKey:@"cp_id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    
    NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
    NSString *strt_c=[NSString stringWithFormat:@"%@",[dic objectForKey:@"SCHOOL_ID"]];
    
    
   // NSLog(@"course ary----%@",course_period_ary);
    if ([course_period_ary count] > 0) {
          for (int i=0; i<[course_period_ary count]; i++) {
        
        
        if ([strt_c isEqual:[[course_period_ary objectAtIndex:i]objectForKey:@"id"]]) {
            dic177=[course_period_ary objectAtIndex:i];
           
            c_ap=true;
            break;
            
        }
        
        
        else
        {
            
            
            
        }
        
    }
    }
    else
    {
    
        NSLog(@"No Data Found");
    }
    
    if (c_ap==true) {
        coursePeriod.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        courseperiodName.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
        str_cp1=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"id"]];
    }
    
    else
    {
        
        
       // coursePeriod.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
       // courseperiodName.text=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"title"]];
      //  str_cp1=[NSString stringWithFormat:@"%@",[[course_period_ary objectAtIndex:0]objectForKey:@"cpv_id"]];
        
        
    }
    
    
    
    
}


-(void)courseperiodname
{

    
  
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    courseperiodName.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
   courseperiodName.inputAccessoryView = mypickerToolbar;
    

}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView.tag==1) {
     
      return c_school_title.count;
  }
else if (pickerView.tag==2)
  {
      
      return school_year_title.count;
    }
    
else if (pickerView.tag==3)
{
    
    return marking_period_title.count;
}
else if (pickerView.tag==4)
{
    
    return subject_title.count;
}
else if (pickerView.tag==5)
{
    
    return course_title.count;
}
    
else if (pickerView.tag==6)
{
    
    return course_period_title.count;
}
else if (pickerView.tag==60)
{
    
    return course_period_title.count;
}
    
  return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
  if (pickerView.tag==1) {
        
        
        return [c_school_title objectAtIndex:row];
   }
    else if (pickerView.tag==2)
   {
      return [school_year_title objectAtIndex:row];
 }
    
    else if (pickerView.tag==3)
    {
        return [marking_period_title objectAtIndex:row];
    }
    
    
    else if (pickerView.tag==4)
    {
        return [subject_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==5)
    {
        return [course_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==6)
    {
        return [course_period_title objectAtIndex:row];
    }
    
    else if (pickerView.tag==60)
    {
        return [course_period_title objectAtIndex:row];
    }

//
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{

    
      
      if (pickerView.tag==60) {
      
      
          
      
      courseperiodName.text=(NSString *)[course_period_title objectAtIndex:row];
      // coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
  //    NSString *strC1 =(NSString *)[course_period_title objectAtIndex:row];
      //  coperiod=[ca_cp_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
    //  str_cp1=[course_period_id objectAtIndex:[course_period_title indexOfObjectIdenticalTo:strC1]];
          NSString *strkk =(NSString *)[course_period_id objectAtIndex:row];
          AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
          NSMutableDictionary *dic_8 = [[[NSMutableDictionary alloc]init]mutableCopy];
          dic_8 = [appDelegate.dic mutableCopy];
          [dic_8 setObject:strkk forKey:@"SCHOOL_ID"];
          appDelegate.dic = [dic_8 mutableCopy];
          [self.ary_title removeAllObjects];
         
        //  NSLog(@"course period id1111------%@",course_period_ary);
          
       //   NSLog(@"-------%@",coperiod);
          
          cp_flag=@"1";
  }
    
}

-(void)tabledata
{

    ary_data=[[NSMutableArray alloc]initWithObjects:@"Attendance",@"Gradebook",@"My Students",@"Schedule",@"Extra Curricular",@"School Information", nil];
    img_ary=[[NSMutableArray alloc]initWithObjects:@"attendence",@"grade",@"mystudent",@"sch",@"e_cur",@"schoolinfo",nil];

    
    table.tableFooterView=[[UIView alloc]init];
    




}


   


-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    
    if ([cp_flag isEqualToString:@"1"]) {
      //  AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
       /// [dic setObject:coperiod forKey:@"UserCoursePeriod"];
      //  appDelegate.dic=dic;
        [self showdata1];

        
        
        
    }
    [currentSchool resignFirstResponder];
     [schoolYear resignFirstResponder];
    [term resignFirstResponder];
    [subject resignFirstResponder];
     [course resignFirstResponder];
    [coursePeriod resignFirstResponder];
    [courseperiodName resignFirstResponder];
    
}
-(IBAction)click:(id)sender
{

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
   // [self fetchdata];
    //[self showdata];

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

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
}



@end
