//
//  GradebookConfigController.h
//  openSiS
//
//  Created by os4ed on 11/5/15.
//  Copyright © 2015 openSiS. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface GradebookConfigController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
    NSMutableArray *ary_assign_title,*ary_assign_value,*ary_sem,*ary_semmmmm,*ary_sem_value;
    NSString *assign_id;
    UIPickerView * selectcustomerpicker;
    
    
    
    
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

}

@end
