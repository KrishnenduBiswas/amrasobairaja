//
//  composeViewController.h
//  openSiS
//
//  Created by EjobIndia on 06/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_composeViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

{
    IBOutlet UISearchBar *theSearchBar;
    IBOutlet UITextField *from,*txt_compose;
    IBOutlet UITextView *msg_view;
    IBOutlet UIView *header_view;
    BOOL flag;
    NSMutableArray *   course_period_title;
    NSString * inbox_data,*term_flag;
}

@property(strong,nonatomic)NSString *stradd1;
@property (strong, nonatomic) NSString *userIsEditindToField;
@property(strong,nonatomic) IBOutlet UITextView *to;
@end
