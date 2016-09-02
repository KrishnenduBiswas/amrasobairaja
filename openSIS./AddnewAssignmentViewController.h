//
//  AddnewAssignmentViewController.h
//  openSiS
//
//  Created by os4ed on 10/30/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddnewAssignmentViewController : UIViewController
{

    NSString *assign_flag,*due_flag;
    NSMutableArray *ARY_PICK_TITLE,*ary_id;
    NSString * pick_id;
    NSString *flag;
    BOOL u;
    NSString *assign_date,*due_date;
    
    
    
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

}

@end
