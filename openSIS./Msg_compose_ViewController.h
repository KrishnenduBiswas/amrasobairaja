//
//  Msg_compose_ViewController.h
//  openSiS
//
//  Created by os4ed on 4/4/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Msg_compose_ViewController : UIViewController<UIPickerViewDataSource , UIPickerViewDelegate>


{

    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
    IBOutlet UISearchBar *theSearchBar;
    IBOutlet UITextField *from,*txt_compose;
    IBOutlet UITextView *msg_view , *to;
    IBOutlet UIView *header_view;
    BOOL flag;
    NSMutableArray *   course_period_title;
    NSString *str_selectedgroupID;
    NSString *cp_id;
    NSString *list_gpa_teacher;
    NSString *list_gpa_parent;

}


@property(strong,nonatomic) NSString*stradd1,*userIsEditindToField;

-(IBAction)compose_back:(id)sender;
-(IBAction)cc:(id)sender;

@end
