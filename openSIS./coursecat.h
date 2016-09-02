//
//  StudentScheduleViewController.h
//  openSiS
//
//  Created by os4ed on 12/10/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  coursecat : UIViewController
{
    
    BOOL a,b,c;
    IBOutlet UILabel *label_nodata;
    IBOutlet UILabel *label_titleforthisPage;
    
    IBOutlet UIView *view_cal,*view_assign,*view_period;
    IBOutlet UITextField *txt_cal,*txt_assign,*txt_period;
    NSString *sub_id,*cou_id,*mp_id;
    NSString *show_title,*sub1_title,*per_title;
 
    NSMutableArray *array_title,*array_id,*sub_title,*sub_id1,*period_title,*period_id,*sub,*period;
    NSString *flag,*flag1,*flag2;
    IBOutlet UIView *view1,*view2,*view3;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
}

@property (strong) NSString *studentName;
@property (strong) NSString *studentID;

@end
