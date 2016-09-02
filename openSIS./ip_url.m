//
//  ip_url.m
//  openSIS-demo
//
//  Created by Apple on 11/08/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "ip_url.h"

#import "AFNetworking.h"
#import "AppDelegate.h"
@implementation ip_url
@synthesize url,url2,url3,url4;
-(NSString *)ipurl
{
    //107.170.94.176/openSIS_CE6_Mobile/
 // return url=@"http://107.170.94.176/openSIS_CE6_Mobile/webservice";
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
     return url=appDelegate.str_txt_url;
   // return url=@"http://demo.opensis.com/opensis/webservice";
    
//    ip_url *obj=[[ip_url alloc]init];
//    ip=[obj ipurl];
//    NSLog(@"%@",ip);
}
- (void)fetchjson:(NSString *)urlString keyvalue:(NSString *)keyvalue
{

    //---------- AFNetworkinger Kaj
    
    // 1 ------: URL String of Json
    NSLog(@"\nUrl String from user:- %@", urlString);
    
    NSURL *url1 = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    
    
    // 2 ------: AFNetworking connection Start
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    //operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"]; // Add korlam again
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3 -------: Fire functions in this block if Connection is succeded
        
        NSLog(@"\nConnection Success------retiving Data");
        
        //    NSDictionary *dictionary = (NSDictionary *)responseObject;
        //  NSUserDefaults *userDefaultsJsonData = [[NSUserDefaults alloc]init];
        // [userDefaultsJsonData setObject:dictionary forKey:userKey];
        
        
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"Error serializing %@", error);
        }
        NSLog(@"Dictionary %@", dict);
        
        
        
        //NSLog(@"\nResponse Data in Dictionary:----- %@", dictionary);
        //NSLog(@"\nResponse Data in NSUserDefault:----- %@", userDefaultsJsonData);
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4 -------: Fire funtions in this block if Connection Fails
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5  ----------: if this block doesnot work noting will happen
    [operation start];
    


}
@end






