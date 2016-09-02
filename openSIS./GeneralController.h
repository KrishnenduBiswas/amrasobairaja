//
//  GeneralController.h
//  openSiS
//
//  Created by os4ed on 11/5/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralController : UIViewController
{
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

}


@property (strong, nonatomic) NSMutableDictionary *dict_main;
@property (strong, nonatomic) NSMutableArray *array_picker;

@end
