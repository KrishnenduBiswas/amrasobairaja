//
//  LoginViewController.m
//  openSiS
//
//  Created by EjobIndia on 10/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//
#import "TeacherDashboardViewController.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import "ip_url.h"
#import "AppDelegate.h"
#import "FrogotLoginnPasswordViewController.h"
#import "SdashboardViewController.h"
#import "pdashboardViewController.h"
//asjahsdhalksdhasdlhhkl
@interface LoginViewController ()

{
    IBOutlet UIView *view1;
    IBOutlet UIView *view2,*view3,*view4;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_osisTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_copyright;
@property (strong, nonatomic) IBOutlet UIButton *btn_login;
@property (strong, nonatomic) IBOutlet UILabel *lbl_selectprofile;
@property (strong, nonatomic) IBOutlet UIButton *btn_forgotuserpass;
@property (strong, nonatomic) IBOutlet UILabel *lbl_note;
@property (strong, nonatomic) IBOutlet UILabel *lbl_note2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_note3;
@property (strong, nonatomic) IBOutlet UILabel *lbl_note4;

@end

@implementation LoginViewController
@synthesize str_txt,pass_data;
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
   
    ip_url *obj=[[ip_url alloc]init];
    ip=[obj ipurl];
    NSLog(@"%@",ip);
    [self selectprofile];
    
    
    view1.layer.borderColor = [UIColor blackColor].CGColor;
    view1.layer.borderWidth = 1.2f;
    [view1.layer setCornerRadius:13.0f];
   view1.clipsToBounds=YES;
    
    
    view2.layer.borderColor = [UIColor blackColor].CGColor;
    view2.layer.borderWidth = 1.2f;
    [view2.layer setCornerRadius:3.5f];
    view2.clipsToBounds=YES;
    
    
    view3.layer.borderColor = [UIColor blackColor].CGColor;
    view3.layer.borderWidth = 1.2f;
    [view3.layer setCornerRadius:3.5f];
    view3.clipsToBounds=YES;
    
    
    view4.layer.borderColor = [UIColor blackColor].CGColor;
    view4.layer.borderWidth = 1.2f;
    [view4.layer setCornerRadius:3.5f];
    view4.clipsToBounds=YES;
    
    transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
   username.attributedPlaceholder = str;
    
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    password.attributedPlaceholder = str1;
    
    
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Select Profile" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    select_profile.attributedPlaceholder = str2;


    // Do any additional setup after loading the view.
}



-(void)selectprofile
{
    
    gea=[[NSMutableArray alloc]initWithObjects:@"Teacher",@"Student",@"Parent",nil];
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker  .delegate = self;
    
    selectcustomerpicker .dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=1;
  select_profile.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
   select_profile.inputAccessoryView = mypickerToolbar;
    
    
    
    
    
    
    
}


-(IBAction)login:(id)sender
{
    

    if ([username.text  length]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter username" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         [alert show];
        //[alert dismissWithClickedButtonIndex:0 animated:YES];
    }
    
    else if ([password.text  length]<1)
        
    {
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         [alert show];
       // [alert dismissWithClickedButtonIndex:0 animated:YES];
        
    
    }
    
    else if ([select_profile.text  length]<1)
        
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Choose select profile" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
         [alert show];
        //[alert dismissWithClickedButtonIndex:0 animated:YES];
        
        
    }
    
    
    else
    {
        
        
       
        


        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[MBProgressHUD hideHUDForView:self.view animated:YES];
                [self performSelector:@selector(logindata) withObject:nil afterDelay:2];
            });
        });
        
        
        
        

    
    }



}

-(void)logindata
{
    [username resignFirstResponder];
    [password resignFirstResponder];
    [select_profile resignFirstResponder];
    
    NSString *str_select_profile=[NSString stringWithFormat:@"%@",select_profile.text];
    NSString *str_select;
    if ([str_select_profile isEqualToString:@"Teacher"]) {
        str_select=@"teacher";
    }
  else  if ([str_select_profile isEqualToString:@"Student"]) {
        str_select=@"student";
    }
  else  {
      str_select=@"parent";
  }
    
    NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
    [df setObject:username.text forKey:@"u"];
    [df setObject:password.text forKey:@"p"];
     [df setObject:str_select forKey:@"pro"];
    
    NSString*str_checklogin=[NSString stringWithFormat:@"/teacher_info.php?username=%@&password=%@&profile=%@",username.text,password.text,str_select];
    
    
    NSLog(@"kkkkkkkkkkk%@",str_checklogin);
    
    NSString *url12=[NSString stringWithFormat:@"%@%@",ip,str_checklogin];
    NSURL *url = [NSURL URLWithString:url12];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"]; // Add korlam bcoz sob content type support korena
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *  sdictionary=[[NSMutableDictionary alloc]init];
        sdictionary = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",sdictionary);
        
        
        NSMutableDictionary *  dictionary1=[[NSMutableDictionary alloc]init];
        dictionary1 = (NSMutableDictionary *)responseObject;
        NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
        //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
        
        //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
        NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
        NSLog(@"str_123-----%@",str_123);
        if([str_123 isEqualToString:@"1"])
        {
            
            //   NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
            
            //  [obj12 setObject:dictionary1 forKey:@"profile_data"];
            
            
            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            //someString = appDelegate.dic;  //..to read
            appDelegate.dic =dictionary1;
            appDelegate.dic_techinfo=dictionary1;
            appDelegate.dic_term =dictionary1;
            appDelegate.dic_year=dictionary1;
            appDelegate.dic_sub=dictionary1;
            appDelegate.dic_course=dictionary1;
            appDelegate.dic_school=dictionary1;

            
            if([str_select isEqualToString:@"teacher"])
            {

            
            
//            UIStoryboard *s=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//            
//            SdashboardViewController *obj12=[s instantiateViewControllerWithIdentifier:@"studentdash"];
//            obj12.dic=dictionary1;
//            obj12.dic_techinfo=dictionary1;
//            [self.navigationController pushViewController:obj12 animated:YES];
            
                NSMutableArray *INFO1=[[NSMutableArray alloc]init];
                INFO1=[dictionary1 objectForKey:@"tech_info"];
                
                NSString *staff_id_value=[NSString stringWithFormat:@"%@",[[INFO1 objectAtIndex:0]objectForKey:@"STAFF_ID" ]];
                
                NSUserDefaults *df=[NSUserDefaults standardUserDefaults];
                
                [df setValue:staff_id_value forKey:@"iphone"];
            UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            TeacherDashboardViewController *obj1=[s instantiateViewControllerWithIdentifier:@"dash"];
            obj1.dic=dictionary1;
            obj1.dic_techinfo=dictionary1;
            [self.navigationController pushViewController:obj1 animated:YES];
//
//
                
            }
            
          else  if([str_select isEqualToString:@"parent"])
            {
                UIStoryboard *s=[UIStoryboard storyboardWithName:@"ParentStoryboard" bundle:nil];
                
               pdashboardViewController *obj1=[s instantiateViewControllerWithIdentifier:@"pdash"];
                obj1.dic=dictionary1;
                obj1.dic_techinfo=dictionary1;
                [self.navigationController pushViewController:obj1 animated:YES];
            }

            else
            {
            
                UIStoryboard *s=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
                
                            SdashboardViewController *obj12=[s instantiateViewControllerWithIdentifier:@"studentdash"];
                            obj12.dic=dictionary1;
                            obj12.dic_techinfo=dictionary1;
                            [self.navigationController pushViewController:obj12 animated:YES];

            
            }
            
        }
       
        
        
        else
        {
            
//            UIStoryboard *s=[UIStoryboard storyboardWithName:@"StudentDashboard" bundle:nil];
//            
//            SdashboardViewController *obj12=[s instantiateViewControllerWithIdentifier:@"studentdash"];
//            obj12.dic=dictionary1;
//            obj12.dic_techinfo=dictionary1;
//            [self.navigationController pushViewController:obj12 animated:YES];
//            

            
            NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg"]];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
            
           //   transparentView.hidden=NO;
            NSLog(@"ok----");
         //   [self.view addSubview:transparentView];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Json"
        //                                                            message:[error localizedDescription]
        //                                                           delegate:nil
        //                                                  cancelButtonTitle:@"Ok"
        //                                                  otherButtonTitles:nil];
        //        [alertView show];
          transparentView.hidden=NO;
        [self.view addSubview:transparentView];
    }];
    
    
    [operation start];
    
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
   


}


-(void)viewWillAppear:(BOOL)animated
{


    NSUserDefaults *p=[NSUserDefaults standardUserDefaults];
    NSString *sd=[p objectForKey:@"tanay"];
   
    NSLog(@"url123------%@",sd);
    url123.text=sd;
  
    username.text=pass_data;
    
       password.text=@"";

}

- (void)viewDidAppear:(BOOL)animated
{
//   username.text = @"teacher";
//    password.text = @"teacher";
    
//    username.text = @"parent";
//    password.text = @"parent";
    
    username.text = @"student";
    password.text = @"student";

    
}

-(IBAction)alertOK:(id)sender
{
    transparentView.hidden = TRUE;
    [transparentView removeFromSuperview];
}


-(void)pickerDoneClicked

{
    NSLog(@"Done Clicked");
    
    [select_profile resignFirstResponder];
  
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 1;
    
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    
    
        return gea.count;
    
  
    
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
     return [gea  objectAtIndex:row];
    
    
    
    
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    
    
        
        select_profile.text=[gea objectAtIndex:[selectcustomerpicker selectedRowInComponent:0]];
  
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
       [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;

}


-(IBAction)back:(id)sender
{

 //  ViewController *parentViewController =[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 1];
 //   parentViewController.str_txt =url123.text;
 //   [self.navigationController popViewControllerAnimated:YES];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"er"];
    
    [self.navigationController pushViewController:vc animated:NO];

}




- (IBAction)forgot_button:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"%@",url123.text];
    FrogotLoginnPasswordViewController *obj = [[FrogotLoginnPasswordViewController alloc]init];
    obj.url_string = url;
    
    
    NSString *storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginnpassword"];
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
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
