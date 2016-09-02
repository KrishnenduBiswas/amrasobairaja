//
//  ForgotpparentViewController.h
//  openSiS
//
//  Created by os4ed on 9/7/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotpparentViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *gea;
    UIPickerView *selectcustomerpicker;
    
    IBOutlet UILabel *lbl_name;
    IBOutlet UIView *transparentView;
}
@property (strong,nonatomic)NSString *initialstr,*select_profile,*pr;
-(IBAction)alertOK:(id)sender;


@end
