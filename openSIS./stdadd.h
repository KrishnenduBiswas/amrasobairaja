//
//  MyInformationAddress.h
//  openSiS
//
//  Created by os4ed on 1/11/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stdadd : UIViewController
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
@property(strong,nonatomic)NSString *studentID,*studentName;
@end
