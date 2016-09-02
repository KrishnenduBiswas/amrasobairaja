//
//  MyInformationCertification.h
//  openSiS
//
//  Created by os4ed on 1/11/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  progedit: UIViewController

{
    NSString *STAFF_ID_K;
    IBOutlet UILabel *calendar_name,*rolling;
    IBOutlet UIView *view_upper;
    NSString *edit_flag;
    
    NSString *comment_id;
    IBOutlet UIButton *btn_add,*btn_close;
    
    IBOutlet UIView *view_header;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;

}

@property(strong,nonatomic)NSString *studentID,*studentName;
@property (strong, nonatomic)NSMutableDictionary *dic_prog;
@property (strong, nonatomic)NSString *goal_id,*goal_name;
@property(strong,nonatomic)NSMutableArray *array_prog;
@end
