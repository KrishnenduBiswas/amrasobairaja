//
//  mapViewController.m
//  openSiS
//
//  Created by os4ed on 4/19/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "mapViewController.h"
#import "mapclass.h"

@interface mapViewController ()

@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadadd];
    // Do any additional setup after loading the view.
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
   mapclass *mapPin1 = [[mapclass alloc]initWithTitle:self.str_name subTitle:self.str_address andCoordinate:loc];
    //mapPin.saveIndex = [NSString stringWithFormat:@"%d",i];
    
    //  mapPin.title=store_name;
    //mapPin.type=@"x";
    
    
    [mapview addAnnotation:mapPin1];
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
