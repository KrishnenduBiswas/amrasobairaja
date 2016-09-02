//
//  LoginViewController.h
//  openSiS
//
//  Created by EjobIndia on 10/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSString   *ip;
    IBOutlet UITextField *url123,*username,*password,*select_profile;
    NSMutableArray *gea;
    UIPickerView *selectcustomerpicker;
    IBOutlet UIView *transparentView;
    
}

@property(strong,nonatomic)NSString *str_txt,*pass_data;
- (IBAction)forgot_button:(id)sender;
-(IBAction)alertOK:(id)sender;
@end
