//
//  MyinfoViewController.h
//  openSiS
//
//  Created by os4ed on 4/7/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyinfoViewController : UIViewController<UITextFieldDelegate ,UIGestureRecognizerDelegate>

{


    IBOutlet UILabel *stdname,*stdid,*cname,*dob,*email,*gender,*eth,*lang,*ph,*stdid2,*altid,*grd;
    IBOutlet UIImageView *imgvw;


}



-(IBAction)action_general:(id)sender;
-(IBAction)action_enroll:(id)sender;
-(IBAction)action_address:(id)sender;

@end
