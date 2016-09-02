//
//  S_ReportViewController.m
//  openSiS
//
//  Created by os4ed on 4/28/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "S_ReportViewController.h"
#import "SdashboardViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "SettingViewController.h"
#import "S_ReportTableViewCell.h"
#import "S_slideViewController.h"
#import "MsgViewController.h"
#import "MsgViewController.h"



@interface S_ReportViewController ()<UIGestureRecognizerDelegate>
{
    
     S_slideViewController *slide;
    IBOutlet UITextField * mptext;
    UIPickerView *selectcustomerpicker;
    NSArray * mpary,*dayary;
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*courseperiodnamestr;
    NSDictionary * dic;
    NSString * selectedday_str,*mptitle;
    IBOutlet UIView * mon_btm_vw,*tue_btm_vw,*wed_btm_vw,*thu_btm_vw,*fri_btm_vw,*sat_btm_vw,*sun_btm_vw;
    
    NSMutableArray * schdleary;
    NSString *strC1;
    
}
@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@end

@implementation S_ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    slide = [[S_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"reportstudent"];

    
    [self courseperiod123];
    
   
    
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeleft.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(open)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    swiperight.numberOfTouchesRequired = 1;
    //[baseView addGestureRecognizer:swiperight];
    
    
    
    
    
    
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    
    
    
    
    [self loaddata:mp_id];
    
    
    
    
    
    tbl.tableFooterView=[[UIView alloc]init];
    
    
    
    
    
    
    
    
    
}

#pragma mark-------Getdata
-(NSString *)getCourseperiodtextfielddata
{
    courseperiodnamestr = [NSString stringWithFormat:@"%@",mptext.text];
    return courseperiodnamestr;
}
#pragma mark-------setdata
-(void)setCourseperiodtextfielddata:(NSString*)str
{
    courseperiodnamestr=str;
    mptext.text = courseperiodnamestr;
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


-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
    
    
       
    
}




-(void)courseperiod123{
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker.delegate = self;
    
    selectcustomerpicker.dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    mptext.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    mptext.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
}








-(void)loaddata:(NSString*)mpid
{
    
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    
    NSArray * ary=[appDelegate.dic objectForKey:@"marking_period_list"];
    
    
    NSLog(@"hhhhhh....%@",ary);
    
    
    
    for (int i=0; i<ary.count; i++) {
        if ([mpid isEqual:[NSString stringWithFormat:[[ary objectAtIndex:i]objectForKey:@"id"]]]) {
            
            
            _sel_mp=(NSString*)[[ary objectAtIndex:i]objectForKey:@"id"];
            
            NSLog(@"sel_mp%@",_sel_mp);
            
        }
      
        
    }

    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_schedule_report.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&sel_mp=%@",student_id,s_year_id,s_year,mpid,_sel_mp];
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
//        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary2 objectForKey:@"success"]];
//        NSLog(@"str_123-----%@",str_123);
//        if([str_123 isEqualToString:@"1"])
//            
//            
//            
//        {
//            
        
            
            
            
            
            mpary=[dictionary2 objectForKey:@"mp_data"];
            
            
            NSLog(@"mpary----%@",mpary);
        
        
        
        
        
        
        selectedday_str=(NSString*)[dictionary2 objectForKey:@"selected_day"];
        
        
        NSLog(@"selected day%@",selectedday_str);
        
        
        if ([selectedday_str isEqualToString:@"Monday"]) {
            mon_btm_vw.hidden=NO;
        }
        if ([selectedday_str isEqualToString:@"Tuesday"]) {
            tue_btm_vw.hidden=NO;
        }
        if ([selectedday_str isEqualToString:@"Wednesday"]) {
            wed_btm_vw.hidden=NO;
        }
        if ([selectedday_str isEqualToString:@"Thursday"]) {
            thu_btm_vw.hidden=NO;
        }
        if ([selectedday_str isEqualToString:@"Friday"]) {
            fri_btm_vw.hidden=NO;
        }
        if ([selectedday_str isEqualToString:@"Saturday"]) {
            sat_btm_vw.hidden=NO;
            
            
            
            NSLog(@"yaaaaahhhh");
            
                }
        if ([selectedday_str isEqualToString:@"Sunday"]) {
            sun_btm_vw.hidden=NO;
        }
        
        
        
        
        dayary=[dictionary2 objectForKey:@"schedule_data"];
        NSLog(@"dayary_____%@",dayary);
        
        
        
        
        
        for (int i=0; i<mpary.count; i++) {
            if ([_sel_mp isEqual:[NSString stringWithFormat:[[mpary objectAtIndex:i]objectForKey:@"MARKING_PERIOD_ID"]]]) {
            
                
                mptitle=(NSString*)[[mpary objectAtIndex:i]objectForKey:@"TITLE"];
                
                NSLog(@"mptitle------%@",mptitle);
                
                
            }
            
        }
 
            
        [self selectdate];
            
        [self mptexttitle];
        
        
      //  }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
}


-(void)selectdate
{
    
    for (int i=0; i<dayary.count; i++) {
        
        
        
        
      
        
        if ([selectedday_str isEqual:[[dayary objectAtIndex:i]objectForKey:@"DAY"]]) {
            
            
            
            
            schdleary=[[dayary objectAtIndex:i]objectForKey:@"SCHEDULE"];
            
            
            
            NSLog(@"schdlary-------%@",schdleary);
            if (schdleary.count==0) {
                NSLog(@"NO DATA FOUND");
                
               
                
                //tbl.hidden=YES;
                
                
                
                
                
                
                
                
                
            }
           // else
           // {
               
             
        
           // }
    }
    }

    
    [tbl reloadData];
    
    
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
        return mpary.count;

    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
          return [[mpary objectAtIndex:row]objectForKey:@"TITLE"];

    
    
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    mptext.text=(NSString *)[[mpary objectAtIndex:row]objectForKey:@"TITLE"];
    
    
    strC1 =(NSString *)[[mpary objectAtIndex:row]objectForKey:@"MARKING_PERIOD_ID"];
    
    //NSLog(@"ppppppppiooo%@",strC1);
    
    
    //_sel_mp=strC1;

    
    
    
    
}
-(void)pickerDoneClicked1

{
    NSLog(@"Done Clicked");
    
    [mptext resignFirstResponder];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self loaddata:strC1];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return schdleary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    S_ReportTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"rprtcell"];
    
    //    cell = (RequestTableViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"RequestTableViewCell" owner:self options:nil ]objectAtIndex:0];
    //   // cell.clipsToBounds = YES;
    cell.timetotime.text=[self nullChecker:[NSString stringWithFormat:@"%@ - %@",[[schdleary objectAtIndex:indexPath.row]objectForKey:@"START_TIME"],[[schdleary objectAtIndex:indexPath.row]objectForKey:@"END_TIME"]]];
    
    cell.titlelbl.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[schdleary objectAtIndex:indexPath.row]objectForKey:@"CP_TITLE"]]];
    
    cell.room.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[schdleary objectAtIndex:indexPath.row]objectForKey:@"ROOM"]]];
    
    cell.term.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[schdleary objectAtIndex:indexPath.row]objectForKey:@"TITLE"]]];
    
    
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



-(IBAction)back:(id)sender
{
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
}



-(IBAction)btndate:(UIButton*)sender
{
    
    
    
    switch (sender.tag) {
        case 1:{
            NSLog(@"MON");
            mon_btm_vw.hidden=NO;
            tue_btm_vw.hidden=YES;
            wed_btm_vw.hidden=YES;
            thu_btm_vw.hidden=YES;
            fri_btm_vw.hidden=YES;
            sat_btm_vw.hidden=YES;
            sun_btm_vw.hidden=YES;
            
            selectedday_str=@"Monday";
            [self selectdate];
            
            break;
        }
        case 2:{
            NSLog(@"TUE");
            tue_btm_vw.hidden=NO;
            mon_btm_vw.hidden=YES;
            wed_btm_vw.hidden=YES;
            thu_btm_vw.hidden=YES;
            fri_btm_vw.hidden=YES;
            sat_btm_vw.hidden=YES;
            sun_btm_vw.hidden=YES;
            
            selectedday_str=@"Tuesday";
            [self selectdate];
            
            break;
        }
        case 3:{
            NSLog(@"WED");
            wed_btm_vw.hidden=NO;
            tue_btm_vw.hidden=YES;
            mon_btm_vw.hidden=YES;
            thu_btm_vw.hidden=YES;
            fri_btm_vw.hidden=YES;
            sat_btm_vw.hidden=YES;
            sun_btm_vw.hidden=YES;
            
            selectedday_str=@"Wednesday";
            [self selectdate];
            
            break;
        }
        case 4:{
            NSLog(@"THU");
            thu_btm_vw.hidden=NO;
            tue_btm_vw.hidden=YES;
            wed_btm_vw.hidden=YES;
            mon_btm_vw.hidden=YES;
            fri_btm_vw.hidden=YES;
            sat_btm_vw.hidden=YES;
            sun_btm_vw.hidden=YES;
            
            selectedday_str=@"Thursday";
            [self selectdate];
            
            break;
        }
        case 5:{
            NSLog(@"FRI");
            fri_btm_vw.hidden=NO;
            tue_btm_vw.hidden=YES;
            wed_btm_vw.hidden=YES;
            thu_btm_vw.hidden=YES;
            mon_btm_vw.hidden=YES;
            sat_btm_vw.hidden=YES;
            sun_btm_vw.hidden=YES;
            
            selectedday_str=@"Friday";
            [self selectdate];
            
            break;
        }
        case 6:{
            NSLog(@"SAT");
            sat_btm_vw.hidden=NO;
            tue_btm_vw.hidden=YES;
            wed_btm_vw.hidden=YES;
            thu_btm_vw.hidden=YES;
            fri_btm_vw.hidden=YES;
            mon_btm_vw.hidden=YES;
            sun_btm_vw.hidden=YES;
            
            selectedday_str=@"Saturday";
            [self selectdate];
            
            break;
        }
        case 7:{
            NSLog(@"SUN");
            sun_btm_vw.hidden=NO;
            tue_btm_vw.hidden=YES;
            wed_btm_vw.hidden=YES;
            thu_btm_vw.hidden=YES;
            fri_btm_vw.hidden=YES;
            sat_btm_vw.hidden=YES;
            mon_btm_vw.hidden=YES;
            
            selectedday_str=@"Sunday";
            [self selectdate];
            
            break;
        }
            
        default:
            break;
    }
    

    
}


-(void)mptexttitle
{
    
    
    
    mptext.text=mptitle;
    
    
    
    
}

-(IBAction)msg:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
    MsgViewController *mgc =[[MsgViewController alloc]init];
    mgc=[sb instantiateViewControllerWithIdentifier:@"msg"];
    [self.navigationController pushViewController:mgc animated:NO];

}

-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    [self.navigationController pushViewController:sd animated:NO];
}


-(IBAction)settting:(id)sender
{
    
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SettingViewController * mvc=[[SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
    
    
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
