//
//  mapkitViewController.m
//  openSiS
//
//  Created by EjobIndia on 08/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import "mapkitViewController.h"
#import "mapviewAnnotation1.h"
#import "ip_url.h"
#import "AppDelegate.h"
@interface mapkitViewController ()

@end

@implementation mapkitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadadd];
    // Do any additional setup after loading the view.
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(fetchdata)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

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


-(void)loadadd
{

    lbl_name.text=self.str_name;
   
  //  address1 = [address1 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSLog(@"address---%@",self.str_address);
NSString *sensor=@"false";
NSString *str_12=[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=%@&address=%@",sensor,self.str_address];

NSString* urlEncoded = [str_12 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlEncoded]];
NSLog(@"requestaddress---%@",request);


[request setHTTPMethod:@"POST"];

NSError *err;
NSURLResponse *response;
NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
NSString *resSrt = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];

NSLog(@"got response==%@", resSrt);




NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
NSString *lataddr1=[dict objectForKey:@"status"];
CLLocationCoordinate2D loc;
if ([lataddr1 isEqualToString:@"OVER_QUERY_LIMIT"]) {
    
    //    NSString *lataddr12=[dict objectForKey:@"error_message"];
    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:lataddr12 delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    //   [alert show];
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    
}
    
    else if ([lataddr1 isEqualToString:@"ZERO_RESULTS"])
    {
    
    
    }

else
{
    
    //  if([lataddr1 isEqualToString:@"ok"])
    // {
    
    
    NSString *lataddr=[[[[[dict objectForKey:@"results"] objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lat"];
    
    NSString *longaddr=[[[[[dict objectForKey:@"results"] objectAtIndex:0]objectForKey:@"geometry"]objectForKey:@"location"]objectForKey:@"lng"];
    
    
    NSLog(@"The resof latitude=%@", lataddr);
    
    NSLog(@"The resof longitude=%@", longaddr);
    
  
    
    double lat123=[lataddr doubleValue];
    double lon123=[longaddr doubleValue];
    loc.latitude=lat123;
    loc.longitude=lon123;
    
    
    CLLocationCoordinate2D regionCenter;
    regionCenter.latitude =lat123;
    regionCenter.longitude =lon123;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(regionCenter, 10000, 10000);
    [mapview setRegion:region animated:TRUE];
    
    
    NSLog(@"ok");
    //  }
}

mapviewAnnotation1 *mapPin = [[mapviewAnnotation1 alloc]initWithTitle:self.str_name subTitle:self.str_address andCoordinate:loc];
//mapPin.saveIndex = [NSString stringWithFormat:@"%d",i];

//  mapPin.title=store_name;
//mapPin.type=@"x";


[mapview addAnnotation:mapPin];
}

@end
