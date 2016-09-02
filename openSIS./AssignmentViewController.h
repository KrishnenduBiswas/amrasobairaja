//
//  AssignmentViewController.h
//  openSiS
//
//  Created by os4ed on 9/25/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSString *cpv_id;
    
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

    
     
}

-(IBAction)click:(id)sender;
- (IBAction)back:(id)sender;
-(void)callgetdata;
-(void)tablereload;
@end
