//
//  CCViewController.h
//  openSiS
//
//  Created by os4ed on 4/5/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCViewController : UIViewController<UIPickerViewDataSource , UIPickerViewDelegate>
{

    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
    IBOutlet UISearchBar *theSearchBar;
    IBOutlet UITextField *from,*txt_compose;
    IBOutlet UITextView *msg_view , *to,*txt_cc;
    IBOutlet UIView *header_view;
    BOOL flag;
    NSMutableArray *   course_period_title;

    NSString *str_selectedgroupID;
    
 UIPickerView *selectcustomerpicker;

}
@property (strong, nonatomic) NSString *str_To;
@property (strong, nonatomic) NSString *stradd1;
@property (strong, nonatomic) NSString *str_cc;

@property(strong,nonatomic) NSString*userIsEditindToField;

@end
