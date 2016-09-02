//
//  SCHOOLNAMEViewController.m
//  openSiS
//
//  Created by EjobIndia on 08/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "snViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import <MapKit/MapKit.h>
#import "mapkitViewController.h"

#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface snViewController ()
{

    IBOutlet UIView *VIEW_MAP;

}

@end

@implementation snViewController

-(IBAction)back:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}

-(IBAction)OPENMAP:(id)sender
{
    
    
    NSString *str_address=[NSString stringWithFormat:@"%@ %@ %@ %@",add.text,city.text,stae.text,zip.text];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo" bundle:nil];
    mapkitViewController *obj = [sb instantiateViewControllerWithIdentifier:@"map"];
    obj.str_address=str_address;
    obj.str_name=sname.text;
    [self.navigationController pushViewController:obj animated:YES];

    NSLog(@"HELLOW");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loaddata];
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
    
    
    UITapGestureRecognizer *mising= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OPENMAP:)];
    mising.numberOfTapsRequired = 1;
    
    //[self.view addGestureRecognizer:tapmainview];
    [VIEW_MAP addGestureRecognizer:mising];
    view_schoolname.layer.borderWidth = 1.0f;
    view_schoolname.layer.backgroundColor=[[UIColor whiteColor]CGColor ];
    view_schoolname.clipsToBounds = YES;
    [self courseperiod123];
    ary_data=[[NSMutableArray alloc]init ];
    ary_data_title=[[NSMutableArray alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ary_data=[appDelegate.dic objectForKey:@"School_list"];
    NSLog(@"ary data---%@",ary_data);
    
    
    NSMutableDictionary *dic16q=[[NSMutableDictionary alloc]init];
    NSString *strtq=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
    
  
    for (int i=0; i<[ary_data count]; i++) {
        
        
        if ([strtq isEqual:[[ary_data objectAtIndex:i]objectForKey:@"id"]]) {
            dic16q=[ary_data objectAtIndex:i];
            
            NSLog(@"dic16---%@",dic16q);
          
            
            s=true;
            break;
        }
        
        else
        {
//            txt_schoolname.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"title" ]];
//             school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"id"]];
        }
        
    }
    
    if (s==true) {
        txt_schoolname.text=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"title"]];
        
        school_id=[NSString stringWithFormat:@"%@",[dic16q objectForKey:@"id"]];
        
    }
    else
    {
        
        txt_schoolname.text=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"title" ]];
        school_id=[NSString stringWithFormat:@"%@",[[ary_data objectAtIndex:0]objectForKey:@"id"]];

        
    }
    
    
    
   // school_year=[[dic objectForKey:@"Schoolyear_list"]mutableCopy];
    
    if ([ary_data count]>0) {
      ary_data_title = [[NSMutableArray alloc] init];
        ary_data_id= [[NSMutableArray alloc] init];
        for (int i = 0; i<[ary_data count]; i++) {
            NSDictionary *dic15 = [ary_data objectAtIndex:i];
            [ary_data_title  addObject:[dic15 objectForKey:@"title"]];
            [ary_data_id addObject:[dic15 objectForKey:@"id"]];
            
        }
        
    }
    else {
        NSLog(@"No  list");
    }
    
    

    // Do any additional setup after loading the view.
}

-(void)courseperiod123{
    
    
    
    
    
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=6;
    txt_schoolname.inputView = selectcustomerpicker;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked1)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
   txt_schoolname.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
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





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
    
    
    return ary_data_title.count;
    
    
    
    
    
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    
    return [ary_data_title objectAtIndex:row];
    
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
    
    
    
    if (pickerView.tag==6) {
        
        
        
        
        
     inbox_data =(NSString *)[ary_data_title objectAtIndex:row];
        NSString *strC =(NSString *)[ary_data_title objectAtIndex:row];
          school_id= [ary_data_id objectAtIndex:[ary_data_title indexOfObjectIdenticalTo:strC]];
        flag=@"1";
        
       
}


}

-(void)loaddata1
{
    // NSString *inbox=@"inbox";
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //   NSString *cpv_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"UserCoursePeriodVar"]];
    NSUserDefaults *DF=[NSUserDefaults standardUserDefaults];
//    NSString *STAFF_ID_K=[DF objectForKey:@"iphone"];
//    NSString *school_id1=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SCHOOL_ID"]];
//    NSString *year_id=[NSString stringWithFormat:@"%@",[appDelegate.dic objectForKey:@"SYEAR"]];
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/school_info.php?school_id=%@",school_id];
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
        NSLog(@"value is-------%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
            
            
            
        {
           
            
      NSDictionary  *sinfo=[dictionary1 objectForKey:@"school_data"];
            NSLog(@"sinfo----%@",sinfo);
            sname.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"TITLE"]];
           add.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"ADDRESS"]];
            city.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"CITY"]];
            stae.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"STATE"]];
          tel.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"PHONE"]];
            website.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"WWW_ADDRESS"]];
            email.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"E_MAIL"]];
             prin.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"PRINCIPAL"]];
            zip.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"ZIPCODE"]];
            base.text=[NSString stringWithFormat:@"%@",[sinfo objectForKey:@"REPORTING_GP_SCALE"]];

            
          
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
            [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
        });
    });


}


-(void)pickerDoneClicked1
{
    
    if ([flag isEqualToString:@"1"]) {
        
        txt_schoolname.text=inbox_data;
        NSLog(@"school id-----%@",school_id);
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(loaddata1) withObject:nil afterDelay:1.0];
            });
        });

      
        
    }
    else
    {
    
    }
    
    [txt_schoolname resignFirstResponder];
}
-(IBAction)home:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    TeacherDashboardViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dash"];
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
#pragma mark—Settings
-(IBAction)settings:(id)sender{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Settings"bundle:nil];
    SettingsMenu *obj = [sb instantiateViewControllerWithIdentifier:@"SettingsMenu"];
    [self.navigationController pushViewController:obj animated:YES];
}

#pragma mark -- calendar
-(IBAction)calendar:(id)sender
{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"schoolinfo"bundle:nil];
    Month1ViewController *obj = [sb instantiateViewControllerWithIdentifier:@"month1"];
    [self.navigationController pushViewController:obj animated:YES];
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
