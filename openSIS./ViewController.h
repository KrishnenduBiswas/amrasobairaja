//
//  ViewController.h
//  openSiS
//
//  Created by EjobIndia on 10/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

#import "AFNetworking.h"

@interface ViewController : UIViewController

{

    IBOutlet UITextField *TXT1;
    IBOutlet UIButton *btn_submit;
    IBOutlet UIView *view1;
    NSString *ip;
    IBOutlet UIView *transparentview, *alertview;

}
-(IBAction)alertOK:(id)sender;
@property(strong,nonatomic)NSString *str_txt;



@end

