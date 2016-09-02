//
//  ResultGroupMemberController.h
//  openSiS
//
//  Created by os4ed on 1/6/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultGroupMemberController : UIViewController
{
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;

}
@property (strong) NSString *group_id;
@property (strong) NSString *str_last;
@property (strong) NSString *str_first;
@property (strong) NSString *str_usr;
@property (strong) NSString *str_profile;
@property (strong) NSString *str_disusr;
@property (strong) NSString *str_allsch;
@end
