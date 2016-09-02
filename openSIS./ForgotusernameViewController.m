//
//  ForgotusernameViewController.m
//  openSiS
//
//  Created by os4ed on 8/11/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "ForgotusernameViewController.h"
#import "forgotpViewController.h"
@interface ForgotusernameViewController ()

{

    IBOutlet UIDatePicker *  datePicker1 ;

}

@end

@implementation ForgotusernameViewController
@synthesize str_flag,str_pg_id;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self selectprofile];
    [self design:view1];
    [self design:view2];
    [self design:view3];
    [self design:view4];
    [self changeFontTextField:txt1];
    [self changeFontTextField:txt2];
    [self changeFontTextField:txt3];
    [self changeFontTextField:txt4];
    
    btn_cancel.layer.borderColor =[UIColor blackColor].CGColor;
    btn_cancel.layer.borderWidth = 1.2f;
    [btn_cancel.layer setCornerRadius:3.5f];
    btn_cancel.clipsToBounds = YES;
    
    
    confirm.layer.borderColor =[UIColor redColor].CGColor;
    confirm.layer.borderWidth = 1.2f;
    [confirm.layer setCornerRadius:3.5f];
    confirm.clipsToBounds = YES;
    //view2.clipsToBounds=YES;
    

  
    
    datePicker1 = [[UIDatePicker alloc] init];
    
    datePicker1.datePickerMode =UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    UIToolbar *datePickerToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(120, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar1 setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker:)]; // method to dismiss the picker when the "Done" button is pressed
    [datePickerToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, doneButton1, nil]];
    
    
    
    
    txt4.inputView = datePicker1;
    
    txt4.inputAccessoryView = datePickerToolbar1;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Student ID" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
 txt2.attributedPlaceholder = str;
    
      NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txt3.attributedPlaceholder = str1;
    
    
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Select Profile" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txt1.attributedPlaceholder = str2;
    
    
    NSAttributedString *str23 = [[NSAttributedString alloc] initWithString:@"Date of Birth" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    txt4.attributedPlaceholder = str23;


    // Do any additional setup after loading the view.
}


-(IBAction)dismissPicker:(id)sender{
    [txt4  resignFirstResponder];
    NSLog(@"hi..");
    
    
    
    // [from resignFirstResponder];
}
- (void)datePickerValueChanged:(id)sender{
    
    
    NSDate *selectedDate = datePicker1.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYY-MM-dd"];
    [txt4 setText:[df stringFromDate:selectedDate]];
    
    
}
- (void)design:(UIView *)view
{
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 1.2f;
    [view.layer setCornerRadius:3.5f];
    view.clipsToBounds=YES;
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

-(IBAction)confirm:(id)sender
{
    
    
    if ([txt1.text  length]<1) {
        
        [self alertit:@"Choose select profile"];
    }
    
    else if ([txt2.text  length]<1)
        
    {
        [self alertit:@"Enter student iD"];
        
    }
    
    else if ([txt3.text  length]<1)
        
    {
        [self alertit:@"Enter password"];
        
    }
    else if ([txt4.text  length]<1)
        
    {
        [self alertit:@"Enter date of birth"];
        
    }
    
    else
    {
        
        
        
    }
    
    
    
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




/////////////---------picker view code




-(void)selectprofile
{
    
    gea=[[NSMutableArray alloc]initWithObjects:@"student",@"staff",@"parent",nil];
    
    selectcustomerpicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
   
    selectcustomerpicker.delegate = self;
    
    selectcustomerpicker.dataSource = self;
    
    [ selectcustomerpicker  setShowsSelectionIndicator:YES];
    selectcustomerpicker.tag=1;
    txt1.inputView = selectcustomerpicker  ;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    
    [barItems addObject:doneBtn];
    
    
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    
    
    txt1.inputAccessoryView = mypickerToolbar;
    
    
    
}


-(void)pickerDoneClicked

{
    NSLog(@"Done Clicked");
    
    [txt1 resignFirstResponder];
    
    
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
    
    
    
    txt1.text=[gea objectAtIndex:[selectcustomerpicker selectedRowInComponent:0]];
    
    NSString *str_txt=[NSString stringWithFormat:@"%@",txt1.text];
    if ([str_txt isEqualToString:@"student"]) {
        NSLog(@"ok");
    }
    
    else if ([str_txt isEqualToString:@"staff"])
    {
    
        
        
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        forgotstaffViewController *obj=[s instantiateViewControllerWithIdentifier:@"forgotstaff"];
        
        
        [self.navigationController pushViewController:obj animated:NO];
        
    
    }
    
    else if ([str_txt isEqualToString:@"parent"])
    {
    
       
        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
      forgotpViewController *obj=[s instantiateViewControllerWithIdentifier:@"forgotp"];
      
        [self.navigationController pushViewController:obj animated:NO];
        
    
    }
    
    
    
}








-(void)changeFontTextField:(UITextField*)textField
{
    //textField.font = [UIFont fontWithName:@"OpenSans-regular" size:10];
    UIFont *font = [UIFont fontWithName:@"Open Sans" size:12.0];
    textField.font = font;
}


-(IBAction)cancel:(id)sender
{
    NSArray *viewarray =[self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewarray objectAtIndex:0] animated:YES];
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
