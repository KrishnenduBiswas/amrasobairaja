//
//  SCHOOLNAMEViewController.h
//  openSiS
//
//  Created by EjobIndia on 08/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface snViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{

    IBOutlet UIView *view_schoolname;
     IBOutlet UITextField *txt_schoolname;
    UIPickerView *selectcustomerpicker;
    NSMutableArray *ary_data,*ary_data_title,*ary_data_id;
    NSString *flag;
    NSString   *inbox_data ;
    BOOL s;
    NSString *school_id;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;

    
    IBOutlet UILabel *sname,*add,*city,*stae,*tel,*zip,*base,*prin,*website,*email;
    
}

@end
