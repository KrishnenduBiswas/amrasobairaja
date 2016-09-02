//
//  SeenewAssignmentViewController.h
//  openSiS
//
//  Created by os4ed on 11/4/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeenewAssignmentViewController : UIViewController
{

    NSString *ASSIGNMENT_ID;
    
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

    
    
    
    
}
@property (strong, nonatomic) NSMutableDictionary *dict_main;
@end
