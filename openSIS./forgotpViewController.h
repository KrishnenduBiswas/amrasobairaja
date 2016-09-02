//
//  forgotstaffViewController.h
//  openSiS
//
//  Created by EjobIndia on 31/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgotpViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *gea;
    UIPickerView *selectcustomerpicker;
    
    IBOutlet UILabel *lbl_name;

}
@property (strong,nonatomic)NSString *initialstr,*select_profile,*pr;

@end
