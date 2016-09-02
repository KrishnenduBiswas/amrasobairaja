//
//  MyinfoViewController.h
//  openSiS
//
//  Created by os4ed on 4/7/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface geninfo : UIViewController<UITextFieldDelegate ,UIGestureRecognizerDelegate>

{


    IBOutlet UILabel *name,*pid,*email,*disabl,*h_ph,*c_ph,*w_ph,*lst,*usrprof;
    IBOutlet UIImageView *imgvw;


}



-(IBAction)action_general:(id)sender;
-(IBAction)action_enroll:(id)sender;
-(IBAction)action_address:(id)sender;

@end
