//
//  forgotstaffViewController.m
//  openSiS
//
//  Created by EjobIndia on 31/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//
#import "reset.h"
#import "forgotstaffViewController.h"
#import "ForgotusernameViewController.h"
#import "FrogotLoginnPasswordViewController.h"
#import "ip_url.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ForgotpasswordViewController.h"
#import "ForgotusernameViewController.h"
@interface reset()
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UITextField *txt_usertype;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UIButton *btn_confirm;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
- (IBAction)cancel:(id)sender;
- (IBAction)confirm:(id)sender;

@end

@implementation reset
@synthesize pr,user_info;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self selectprofile];
      transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    NSLog(@"select_profile----%@",pr);
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    self.txt_password.attributedPlaceholder = str;
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Re-enter password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    self.txt_email.attributedPlaceholder = str1;
    
    
    
    
    // Do any additional setup after loading the view.
}
- (void)design:(UIView *)view
{
    //CGSize size = CGSizeMake(275.0f, 28.0f);
    //[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, 275, 28)];
    
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 1.2f;
    [view.layer setCornerRadius:3.5f];
    view.clipsToBounds=YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self design:self.view1];
    [self design:self.view2];
    [self design:self.view3];
    self.btn_cancel.layer.borderColor =[UIColor blackColor].CGColor;
    self.btn_cancel.layer.borderWidth = 1.2f;
    [self.btn_cancel.layer setCornerRadius:3.5f];
    self.btn_cancel.clipsToBounds = YES;
    
    
    self.btn_confirm.layer.borderColor =[UIColor redColor].CGColor;
    self.btn_confirm.layer.borderWidth = 1.2f;
    [self.btn_confirm.layer setCornerRadius:3.5f];
    self.btn_confirm.clipsToBounds = YES;
    

}

-(void)viewDidAppear:(BOOL)animated
{
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
-(IBAction)dismissPicker:(id)sender{
    [self.txt_usertype  resignFirstResponder];
    NSLog(@"hi..");
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) alertit:(NSString*)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    //  [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)cancel:(id)sender {
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginnpassword"];
    
    [self.navigationController pushViewController:vc animated:NO];
}
- (BOOL)passwordIsValid:(NSString *)password {
    
    
    
    unsigned long int len = password.length;
    int flag = 0;
    // 1. Upper case.
    for (int i = 0; i < len; ++i) {
        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[password characterAtIndex:i]])
            ++flag;
    }
    if (flag == 0)
        return NO;    // 2. Length.
    if ([password length] < 8)
        return NO;
    
    // 3. Special characters.
    // Change the specialCharacters string to whatever matches your requirements.
    NSString *specialCharacters = @"!#€%&@/()[]=?$§*'";
    if ([[password componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:specialCharacters]] count] < 2)
        return NO;
    
    // 4. Numbers.
    if ([[password componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]] count] < 2)
        return NO;
    
    return YES;
}

- (IBAction)confirm:(id)sender {
    
    
     
    
    if ([self.txt_password.text length ]<1) {
        
        [self alertit:@"Enter password"];
    }

  else if ([self passwordIsValid:self.txt_password.text]==NO)
        
    {
        [self alertit:@"Password must be minimum 8 characters long with at least one capital, one numeric and one special character"];
        
    }
    
  else  if ([self.txt_email.text length ]<1) {
        [self alertit:@"Re-enter password"];
    }
    
    
      else
    {
    
           [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[MBProgressHUD hideHUDForView:self.view animated:YES];
            [self performSelector:@selector(resetpass:) withObject:nil afterDelay:2];
        });
    });



}
    
    
    
    
}

-(IBAction)resetpass:(id)sender
{
//http://107.170.94.176/openSIS_CE6_Mobile/webservice/forgot_pwd.php?user_info=2,2,teacher&new_pass=teacher&ver_pass=teacher
   
    [self.txt_email resignFirstResponder];
    [self.txt_password resignFirstResponder];
   // username
 //   uname_staff
   
    ip_url *obj123=[[ip_url alloc]init];
    NSString *str123=[obj123 ipurl];
    NSString*str_checklogin=[NSString stringWithFormat:@"/forgot_pwd.php?user_info=%@&new_pass=%@&ver_pass=%@",user_info,self.txt_password.text,self.txt_email.text];
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
            NSLog(@"%@",dictionary1); // ei khanei nslog korle dekhache, blocker baire dekhache na
            //    NSUserDefaults *obj12=[NSUserDefaults standardUserDefaults];
            
            //  [obj12  setValue:dictionary1  forKey:@"profile_data"];
            NSString *str_123=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"success"]];
            NSLog(@"str_123-----%@",str_123);
            if([str_123 isEqualToString:@"1"])
            {
               NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"conf_msg"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:str_msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                

                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
            
                
                [self.navigationController pushViewController:vc animated:NO];
                
            }
            
            
            else
            {
               // NSString *str_msg=[NSString stringWithFormat:@"%@",[dictionary1 objectForKey:@"err_msg_mod"]];
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password mismatch" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                
                
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
         
            transparentView.hidden=NO;
            NSLog(@"ok----");
            [self.view addSubview:transparentView];
        }];
        
        
        [operation start];
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        
        
        
   
    


}

-(IBAction)alertOK:(id)sender
{
    transparentView.hidden = TRUE;
    [transparentView removeFromSuperview];
    
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


/////////picker


-(void)selectprofile
{
    
    gea=[[NSMutableArray alloc]initWithObjects:@"student",@"staff",@"parent",nil];
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    selectcustomerpicker.delegate = self;
    
    selectcustomerpicker.dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=1;
    self.txt_usertype.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    self.txt_usertype.inputAccessoryView = mypickerToolbar;
    
    
    
}


-(void)pickerDoneClicked

{
    NSLog(@"Done Clicked");
    
    [self.txt_usertype resignFirstResponder];
    
    NSString *str_txt=[NSString stringWithFormat:@"%@",self.txt_usertype.text];

    //    else
//    {
//
//        if ([_initialstr isEqualToString:@"3"]) {
//            
//            _initialstr=@"3";
//            UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            forgotstaffViewController *obj=[s instantiateViewControllerWithIdentifier:@"forgotstaff"];
//            obj.initialstr = _initialstr;
//            obj.pr=pr;
//            
//            [self presentViewController:obj animated:NO completion:nil];
//        }
//        
//        
//        else
//        {
//            _initialstr=@"4";
//            UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            forgotstaffViewController *obj=[s instantiateViewControllerWithIdentifier:@"forgotstaff"];
//            obj.initialstr = _initialstr;
//            obj.pr=pr;
//            [self presentViewController:obj animated:NO completion:nil];
//            
//        }
//        
//    }
//    

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
    
    
 self.txt_usertype.text=(NSString *)[gea objectAtIndex:row];
    
    NSString *str_txt=[NSString stringWithFormat:@"%@",self.txt_usertype.text];
    if ([str_txt isEqualToString:@"parent"]) {
        NSLog(@"ok");
    }
    
    else if ([str_txt isEqualToString:@"staff"])
    {
        
        
        
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        forgotstaffViewController *obj=[s instantiateViewControllerWithIdentifier:@"forgotstaff"];
        
        
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    
    else if ([str_txt isEqualToString:@"student"])
    {
        
        
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ForgotusernameViewController *obj=[s instantiateViewControllerWithIdentifier:@"forgotusername"];
        
        [self.navigationController pushViewController:obj animated:NO];
        
        
    }
    

      
}





@end
