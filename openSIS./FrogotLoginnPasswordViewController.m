//
//  FrogotLoginnPasswordViewController.m
//  openSiS
//
//  Created by os4ed on 8/11/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "FrogotLoginnPasswordViewController.h"

@interface FrogotLoginnPasswordViewController ()

@end

@implementation FrogotLoginnPasswordViewController
@synthesize url_string;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    view1.layer.borderColor = [UIColor blackColor].CGColor;
    view1.layer.borderWidth = 1.2f;
    [view1.layer setCornerRadius:13.0f];
    view1.clipsToBounds=YES;
    
    view2.layer.borderColor = [UIColor blackColor].CGColor;
    view2.layer.borderWidth = 1.2f;
    [view2.layer setCornerRadius:3.5f];
    view2.clipsToBounds=YES;
    
    btn_cancel.layer.borderColor =[UIColor blackColor].CGColor;
    btn_cancel.layer.borderWidth = 1.2f;
    [btn_cancel.layer setCornerRadius:3.5f];
    //view2.clipsToBounds=YES;
   
    
    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
    
    url_view.text =[obj12 objectForKey:@"url123"];


}

-(IBAction)backdata:(id)sender
{


    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"er"];
    
    [self.navigationController pushViewController:vc animated:NO];


}



#pragma cancel

- (IBAction)cancel_button:(id)sender
{
//    NSString *storyboardName = @"Main";
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginnpassword"];
    //[self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
