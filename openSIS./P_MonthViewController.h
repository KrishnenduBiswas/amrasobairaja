//
//  S_MonthViewController.h
//  openSiS
//
//  Created by Krishnendu Biswas on 14/05/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_MonthViewController : UIViewController
{
    
    NSString *flag_i;
    IBOutlet UILabel *label_nodata;
    IBOutlet UIView *view1;
    IBOutlet UILabel *label_titleforthisPage;
    NSString *date_value;
    
    IBOutlet UIView *view_cal,*view_assign;
    IBOutlet UITextField *txt_cal,*txt_assign;
    NSMutableArray *ary_data,*ary_data_title,*ary_data_id,*ary_assign;
    UIPickerView *  selectcustomerpicker;
    NSString *flag,*school_id;
    NSString *inbox_data;
    int flag1;
    NSString *assignment_data,*calendar_id;
    NSMutableArray *ary_stdname,*ary_stdid,* ary_stdlist;
    NSString *str_name;
    
    BOOL s_name;

    
}
@property (strong) NSString *studentName;
@property (strong) NSString *studentID;


@end
