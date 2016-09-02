//
//  FgradViewController.m
//  openSiS
//
//  Created by os4ed on 3/16/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "FgradViewController.h"
#import "Final_grade_TableViewCell.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "AFNetworking.h"
#import "S_slideViewController.h"
#import "SdashboardViewController.h"


@interface FgradViewController ()<UIPickerViewDataSource , UIPickerViewDelegate>
{
    
    
    S_slideViewController * slide;
    
    
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type ,*mpid ,*mpstr ,*strt_c;
    
    NSMutableArray * array;
    
    NSMutableArray *mp_title ,*mp_data_id;
    
    UIPickerView * selectcustomerpicker;
    NSMutableArray *mp_ary;
    BOOL t;
    
}

@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@property (strong, nonatomic) IBOutlet UITextField *mp_text;

@end

@implementation FgradViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    array=[[NSMutableArray alloc]init];
    
    [self loadmp];
    [self loaddata];
    [self courseperiod123];
    
    
    
    slide = [[S_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"finalgradestudent"];
    
    
    tblfinalgrd.tableFooterView=[[UIView alloc]init];
    

    
    
    
    
    
}
- (IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES ];
    
    
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
    //[self showdata];
    
}


-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=60;
    _mp_text.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    _mp_text.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if (pickerView.tag==60)
    {
        
        return mp_title.count;
    }
    
    return 0;
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    if (pickerView.tag==60)
    {
        return [mp_title objectAtIndex:row];
    }
    
    //
    return 0;
    
    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    if (pickerView.tag==60) {
        
        _mp_text.text=(NSString *)[mp_title objectAtIndex:row];
        
        
        NSString *strC1 =(NSString *)[mp_title objectAtIndex:row];
        mpid=[mp_data_id objectAtIndex:[mp_title indexOfObjectIdenticalTo:strC1]];
        
        NSLog(@"je data ta select korbe eta ter id..%@",mpid);
        
        
        
        // coursePeriod.text=(NSString *)[course_period_title objectAtIndex:row];
        //NSString *strC1 =(NSString *)[mp_ary objectAtIndex:row];
        
    }
    
}
-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    [_mp_text resignFirstResponder];
    
    // NSString * strmp= _mp_text.text;
    
    if ([mpid isEqual:strt_c]) {
        
        [self loaddata];
        
//        _nodata_lbl.hidden=YES;
//        _view_border.hidden=NO;
        
    }
    else
    {
        
//        _view_border.hidden=YES;
//        _nodata_lbl.hidden=NO;
//        
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
}





-(void)loadmp
{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_final_grades.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@",student_id,s_year_id,s_year,mp_id];
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
        
        NSMutableDictionary *  dictionary2=[[NSMutableDictionary alloc]init];
        dictionary2 = (NSMutableDictionary *)responseObject;
        NSLog(@"value is-------%@",dictionary2);
        
        
        
        
        // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary2 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
            
            
            
            
            mp_ary=[dictionary2 objectForKey:@"mp_data"];
            
            
            NSLog(@"mp_array----%@",mp_ary);
            
            
            
            
            
            mp_title= [[NSMutableArray alloc] init];
            mp_data_id = [[NSMutableArray alloc] init];
            for (int i = 0; i<[mp_ary count]; i++) {
                
                
                //                    mp_title=[[mp_ary objectAtIndex:i] objectForKey:@"title"];
                //                     mp_data_id=[[mp_ary objectAtIndex:i] objectForKey:@"id"];
                
                
                
                
                NSDictionary *dic15 =[[NSDictionary alloc]init];
                dic15=[mp_ary objectAtIndex:i];
                
                [mp_title  addObject:[dic15 objectForKey:@"TITLE"]];
                [mp_data_id  addObject:[dic15 objectForKey:@"VALUE"]];
                
            }
            
            
            
            
            
            NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
            strt_c=[NSString stringWithFormat:@"%@",[dictionary2 objectForKey:@"selected_mp"]];
            
            if ([mp_ary count] > 0) {
                for (int i=0; i<[mp_ary count]; i++) {
                    
                    
                    if ([strt_c isEqual:[[mp_ary objectAtIndex:i]objectForKey:@"VALUE"]]) {
                        dic177=[mp_ary objectAtIndex:i];
                        t=true;
                        //[self loaddata];
                        
                        //NSLog(@" id print hbe    %@",dic177);
                        break;
                        
                    }
                    
                    
                }
                if (t==true) {
                    
                    _mp_text.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"TITLE"]];
                    mpstr=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"VALUE"]];
                    
                    
                }
                
                else
                {
                    
                    //                       schoolYear.text=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"TITLE"]];
                    //                       school_year1=[NSString stringWithFormat:@"%@",[[school_year objectAtIndex:0]objectForKey:@"VALUE"]];
                    //                       NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                    //                       [df setObject:school_year1 forKey:@"school_year"];
                }
                
                
                
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
}


-(void)loaddata
{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_final_grades.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@",student_id,s_year_id,s_year,mp_id];
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
        
        
        
        
        // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
       
            
        {
            
            
            array=[dictionary1 objectForKey:@"final_grades"];
            
            
            NSLog(@"sinfo----%@",array);
            
 
        }
        
        
        [tblfinalgrd reloadData];
        
        
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    [operation start];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Final_grade_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"final"];
    
    cell = (Final_grade_TableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"Final_grade_TableViewCell" owner:self options:nil ]objectAtIndex:0];
    
    cell.c_title.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row]objectForKey:@"COURSE_TITLE"]];
    cell.grdrange.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row]objectForKey:@"GRADE_PERCENT"]];
    cell.grdtitle.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row]objectForKey:@"GRADE_TITLE"]];
    cell.teacher.text=[NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row]objectForKey:@"TEACHER"]];
    
    
    NSString *cmnt = [NSString stringWithFormat:@"%@",[[array objectAtIndex:indexPath.row] objectForKey:@"COMMENT"] ];
    if (cmnt) {
        if ([cmnt isEqualToString:@""] || [cmnt isEqualToString:@"(null)"] || [cmnt isEqualToString:@" "]) {
            cell.btn_comment.image = [UIImage imageNamed:@"grey-Comment"];
        }
        else{
            cell.btn_comment.image = [UIImage imageNamed:@"comment"];
        }
    }
    else
    {
        cell.btn_comment.image = [UIImage imageNamed:@"grey-Comment"];
    }

    
    
    
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}



-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
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
