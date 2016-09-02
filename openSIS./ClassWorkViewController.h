//
//  ClassWorkViewController.h
//  openSiS
//
//  Created by os4ed on 10/28/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassWorkViewController : UIViewController
{

IBOutlet UITextField *lbl_hidden;

IBOutlet UILabel *notofi,*msg_count_tab;
IBOutlet UILabel *msg_count;

}
@property (strong, nonatomic) NSMutableDictionary *dict_main;
@end
