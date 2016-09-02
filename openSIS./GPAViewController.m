//
//  GPAViewController.m
//  openSiS
//
//  Created by os4ed on 4/19/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "GPAViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
#import "UIImageView+PhotoFrame.h"
#import "S_slideViewController.h"
#import "SdashboardViewController.h"
#import "S_ReportViewController.h"
#import "MsgViewController.h"
#import "SettingViewController.h"

@interface GPAViewController ()<UIPickerViewDataSource ,UIPickerViewDelegate>
{

    
    
    S_slideViewController *slide;

    NSString    * student_id,*view_select,*s_year,*s_year_id ,*mp_id ,*action_type ,*mpid ,*mpstr ,*strt_c;
    
    NSMutableArray *mp_title ,*mp_data_id;
    
    UIPickerView * selectcustomerpicker;
    NSMutableArray *mp_ary;
    BOOL t;

}
@property (strong,nonatomic) IBOutlet UIView *view_coursePeriodName;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *stdid;
@property (strong, nonatomic) IBOutlet UILabel *rank;
@property (strong, nonatomic) IBOutlet UILabel *rank_position;
@property (strong, nonatomic) IBOutlet UILabel *outof;
@property (strong, nonatomic) IBOutlet UITextField *mp_text;
@property (strong, nonatomic) IBOutlet UILabel *gpa;
@property (strong, nonatomic) IBOutlet UILabel *wgpa;
@property (strong, nonatomic) IBOutlet UILabel *unwgpa;
@property (strong, nonatomic) IBOutlet UIView *view_border;
@property (strong, nonatomic) IBOutlet UILabel *grade;
@property (strong, nonatomic) IBOutlet UIImageView *imageviw;
@property (strong, nonatomic) IBOutlet UIButton *back;

@property (strong, nonatomic) IBOutlet UILabel *nodata_lbl;

- (IBAction)back:(id)sender;

@end

@implementation GPAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loaddata];
    
    [self courseperiod123];
    _nodata_lbl.hidden=YES;
    
    [self loadmp];
    
    
    
    slide = [[S_slideViewController alloc]init];
    [slide setrect:self.view];
    [slide setparentobject:self parentname:@"GPAstudent"];
    

    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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








- (IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES ];


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
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_gpa_ranklist.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&view_type=list",student_id,s_year_id,s_year,mp_id];
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
                    
                    [mp_title  addObject:[dic15 objectForKey:@"title"]];
                    [mp_data_id  addObject:[dic15 objectForKey:@"id"]];
                    
                }
                
            
        
        
           
            NSMutableDictionary *dic177=[[NSMutableDictionary alloc]init];
           strt_c=[NSString stringWithFormat:@"%@",[dictionary2 objectForKey:@"selected_mp"]];
            
               if ([mp_ary count] > 0) {
                for (int i=0; i<[mp_ary count]; i++) {
                    
                    
                    if ([strt_c isEqual:[[mp_ary objectAtIndex:i]objectForKey:@"id"]]) {
                        dic177=[mp_ary objectAtIndex:i];
                        t=true;
                    //[self loaddata];
                        
                        //NSLog(@" id print hbe    %@",dic177);
                        break;
                        
                    }
                    
                    
                }
                   if (t==true) {
                       
                       _mp_text.text=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"title"]];
                       mpstr=[NSString stringWithFormat:@"%@",[dic177 objectForKey:@"id"]];
                      
                      
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
       
        _nodata_lbl.hidden=YES;
        _view_border.hidden=NO;

    }
    else
    {
    
        _view_border.hidden=YES;
        _nodata_lbl.hidden=NO;
    
    }
    
}



-(void)loaddata2222222
{
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    student_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"STUDENT_ID"]];
    s_year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    s_year=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    
    mp_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserMP"]];
    
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/student/stu_gpa_ranklist.php?student_id=%@&school_id=%@&syear=%@&mp_id=%@&view_type=list",student_id,s_year_id,s_year,mp_id];
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
            
            
            
            
            NSMutableArray *sinfo=[dictionary1 objectForKey:@"student_data"];
            
            
            NSLog(@"sinfo----%@",sinfo);
            
            for (int i=0; i<sinfo.count; i++) {
                
                _name.text= [self nullChecker:[NSString stringWithFormat:@"%@ %@",[[sinfo objectAtIndex:i] objectForKey:@"FIRST_NAME"],[[sinfo objectAtIndex:0] objectForKey:@"LAST_NAME"]]];
                
                _stdid.text=[self nullChecker:[NSString stringWithFormat:@"Student id:%@",[[sinfo objectAtIndex:i] objectForKey:@"STUDENT_ID"]]];
                
                _rank.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"CLASS_RANK"]]];
                
                _rank_position.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"RANK_SUFFIX"]]];
                
                _unwgpa.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"UNWEIGHTED_GPA"]]];
                
               _grade.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"GRADE_ID"]]];
                
                 _gpa.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"GPA"]]];
                
                _wgpa.text=[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"WEIGHTED_GPA"]]];
                
                
                NSURL *url = [NSURL URLWithString:[self nullChecker:[NSString stringWithFormat:@"%@",[[sinfo objectAtIndex:i] objectForKey:@"PHOTO"]]]];
                NSData *imgData = [NSData dataWithContentsOfURL:url];
                _imageviw.image = [UIImage imageWithData:imgData];
                
                
                _imageviw.layer.cornerRadius = _imageviw.frame.size.width / 2;
                _imageviw.clipsToBounds = YES;
                _imageviw.layer.borderWidth = 5.0f;
                _imageviw.layer.borderColor = [UIColor greenColor].CGColor;
                
              //  [_imageviw applyPhotoFrame];
               
                
                
            }
            
           
         
            
            
            
        }
        
        
        else
        {
            //   NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //   lbl_show.hidden=NO;
            //    mtable.hidden=YES;
            //  NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"error_msg"]];
            //  lbl_show.text=[NSString stringWithFormat:@"%@",str_msg];
            // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            // [alert show];
            
            _nodata_lbl.hidden=NO;
            _view_border.hidden=YES;
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        //  transparentView.hidden=NO;
        //  NSLog(@"ok----");
        //[self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
    
    
    
    
    
    
    
}

-(void)loaddata
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        
               
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(loaddata2222222) withObject:nil afterDelay:1.0];
        });
    });
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [_view_coursePeriodName.layer setCornerRadius:2.0f];
    _view_coursePeriodName.layer.borderWidth = 1.0f;
    _view_coursePeriodName.clipsToBounds = YES;
    _view_coursePeriodName.layer.borderColor = [[UIColor colorWithRed:0.259f green:0.608f blue:0.831f alpha:1.00f]CGColor];
}


- (NSString *)nullChecker:(NSString *)strToCheck
{
    if ([strToCheck isEqualToString:@"(null)"] || [strToCheck isEqualToString:@"<null>"] || [strToCheck isEqualToString:@"null"]) {
        return @" ";
    }
    return strToCheck;
}

-(IBAction)home:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    SdashboardViewController * sd = [storyboard instantiateViewControllerWithIdentifier:@"studentdash"];
    
    [self.navigationController pushViewController:sd animated:NO];
    
    
    
}


-(IBAction)thirdButton:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle: nil];
    S_ReportViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"rprt"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark---Msg
-(IBAction)msg:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StudentDashboard" bundle:[NSBundle mainBundle]];
    MsgViewController *mgc =[[MsgViewController alloc]init];
    mgc=[sb instantiateViewControllerWithIdentifier:@"msg"];
    [self.navigationController pushViewController:mgc animated:NO];
}
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard * sb=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
    SettingViewController * mvc=[[SettingViewController alloc]init];
    mvc=[sb instantiateViewControllerWithIdentifier:@"Setting"];
    [self.navigationController pushViewController:mvc animated:NO];
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
