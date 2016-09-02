//
//  ForgotusernameViewController.h
//  openSiS
//
//  Created by os4ed on 8/11/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "forgotstaffViewController.h"
#import "forgotpViewController.h"

@interface ForgotusernameViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UIView *view1,*view2,*view3,*view4;
    IBOutlet UIButton *btn_cancel,*confirm;
    IBOutlet UITextField *txt1,*txt2,*txt3,*txt4;
    NSMutableArray *gea;
    UIPickerView *selectcustomerpicker;

}
@property(strong,nonatomic)NSString *str_flag,*str_pg_id;
-(IBAction)confirm:(id)sender;
-(IBAction)cancel:(id)sender;
@end
