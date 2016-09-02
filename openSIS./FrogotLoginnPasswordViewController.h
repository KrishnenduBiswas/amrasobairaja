//
//  FrogotLoginnPasswordViewController.h
//  openSiS
//
//  Created by os4ed on 8/11/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrogotLoginnPasswordViewController : UIViewController<UITextFieldDelegate>

{
    IBOutlet UIView *view1,*view2;
    IBOutlet UIButton *btn_cancel;
    IBOutlet UITextField *url_view;
    
}
- (IBAction)cancel_button:(id)sender;
@property (strong,nonatomic) NSString *url_string;

@end
