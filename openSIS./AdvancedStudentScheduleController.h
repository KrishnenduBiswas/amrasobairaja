//
//  AdvancedStudentScheduleController.h
//  openSiS
//
//  Created by os4ed on 12/7/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedStudentScheduleController : UIViewController
{
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
}

@property (strong, nonatomic) NSString *senderString;
@end
