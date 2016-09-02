//
//  ViewController.m
//  openSiS
//
//  Created by EjobIndia on 10/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ip_url.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lbl_osisTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_or;
@property (strong, nonatomic) IBOutlet UIButton *btn_scanQR;
@property (strong, nonatomic) IBOutlet UILabel *lbl_QR;
@property (strong, nonatomic) IBOutlet UILabel *lbl_copyright;
@property (strong, nonatomic) IBOutlet UILabel *lbl_typeschoolURL;


@end

@implementation ViewController
@synthesize str_txt;
- (void)viewDidLoad {
    [super viewDidLoad];
    
//   TXT1.layer.borderColor = [UIColor blackColor].CGColor;
//    TXT1.layer.borderWidth = 2.0f;
//     [TXT1.layer setCornerRadius:5.0];
    view1.layer.borderColor = [UIColor blackColor].CGColor;
    view1.layer.borderWidth = 1.2f;
    [view1.layer setCornerRadius:3.5f];
    view1.clipsToBounds =YES;
  btn_submit.layer.borderColor = [UIColor clearColor].CGColor;
   btn_submit.layer.borderWidth = 1.0f;
    
    
 [btn_submit.layer setCornerRadius:1.2f];
    
    
    
    
    transparentview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{

  //  NSLog(@"strtxt------%@",str_txt);

  //  TXT1.text=str_txt;
    
   [MBProgressHUD hideHUDForView:self.view animated:YES];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
  
    return YES;
    
}

-(IBAction)submit:(id)sender
{
    
    if ([TXT1.text  length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please type your school's openSIS web address" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         [alert show];
        
        [TXT1 resignFirstResponder];
       // [alert dismissWithClickedButtonIndex:0 animated:YES];
        
       
    }
    
    
    else
    {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(submit12) withObject:nil afterDelay:2];
        });
    });
    
    }
    
  


}

-(void)submit12
{
    [TXT1 resignFirstResponder];
    
//    NSURL *url = [NSURL URLWithString:@"ip/check_login.php?url="];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
  NSString *  str23=[NSString stringWithFormat:@"%@",TXT1.text];
    NSString *u_str;
    
    if ([str23 containsString:@"http://"]) {
        
        
        NSString* str =[NSString stringWithFormat:@"%@",TXT1.text];
        
        NSRange replaceRange = [str rangeOfString:@"http://"];
        
        if (replaceRange.location != NSNotFound){
            
         //   NSString* result = [str stringByReplacingCharactersInRange:replaceRange withString:@""];
        }
       
        u_str=[NSString stringWithFormat:@"%@",str];
        NSLog(@"http dia search korlam");
        
    }
    else
    {
        NSLog(@"http dilam na");
       u_str=[NSString stringWithFormat:@"http://%@",TXT1.text];
        
        
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.str_txt_url=[NSString stringWithFormat:@"%@/webservice",u_str];
    ip_url *obj=[[ip_url alloc]init];
    ip=[obj ipurl];
    NSLog(@"%@",ip);
    NSLog(@"url1-------%@",appDelegate.str_txt_url);
  
    NSString*str_checklogin=[NSString stringWithFormat:@"/check_login.php?url=%@", u_str];
  //  NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    NSString *url1=[NSString stringWithFormat:@"%@%@",ip,str_checklogin];
    NSLog(@"hjjhjg%@",url1);
    NSURL *url = [NSURL URLWithString:url1];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
 NSMutableDictionary   *dictionary1 = (NSMutableDictionary *)responseObject;
      //(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
                           if([str_123 isEqualToString:@"1"])
                           {
                             
                               NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
                               
                               [obj12 setObject:TXT1.text forKey:@"url123"];
        
           UIStoryboard *obj1=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *obj=[obj1 instantiateViewControllerWithIdentifier:@"login"];
        
                               NSUserDefaults *p=[NSUserDefaults standardUserDefaults];
                               [p setObject:TXT1.text forKey:@"tanay"];
                               
                               obj.str_txt=TXT1.text;
        
        [self.navigationController pushViewController:obj animated:YES];

                           }
                           
                           
                           else
                           {
                           
                               
                               transparentview.hidden=NO;
                               NSLog(@"ok----");
                               [self.view addSubview:transparentview];
                           
                           }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Json"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        transparentview.hidden=NO;
        [self.view addSubview:transparentview];
    }];
    
  
    [operation start];
    

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
   

}

-(IBAction)alertOK:(id)sender
{
    transparentview.hidden = TRUE;
    [transparentview removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
