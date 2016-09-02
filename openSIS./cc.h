//
//  composeViewController.h
//  openSiS
//
//  Created by EjobIndia on 06/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cc : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    NSMutableArray * course_period_title;
    NSString *term_flag;
    NSString *inbox_data;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

    
}

@property (strong, nonatomic) NSString *str_To;
@property (strong, nonatomic) NSString *stradd1;
@property (strong, nonatomic) NSString *str_cc;
@property (strong, nonatomic) NSString *userIsEditindToField;

@end
