//
//  GradesViewController.h
//  openSiS
//
//  Created by os4ed on 9/24/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

}

-(IBAction)click:(id)sender;


@end
