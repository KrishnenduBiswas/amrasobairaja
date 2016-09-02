//
//  SearchGroupMemberController.h
//  openSiS
//
//  Created by os4ed on 1/6/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchGroupMemberController : UIViewController
{
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;

}
@property (strong) NSString *group_id;

@end
