//
//  SettingsMenu.h
//  openSiS
//
//  Created by os4ed on 1/11/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsMenu : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
}

-(IBAction)click:(id)sender;


@end
