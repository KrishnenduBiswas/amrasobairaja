//
//  S_attendenceViewController.h
//  openSiS
//
//  Created by os4ed on 4/28/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface S_attendenceViewController : UIViewController
{
    IBOutlet UILabel *label_nodata;
    IBOutlet UIView *view1;
    IBOutlet UILabel *label_titleforthisPage;
    NSString *date_value;
}
@property (strong) NSString *studentName;
@property (strong) NSString *studentID;



@end
