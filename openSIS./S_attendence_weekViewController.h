//
//  S_attendence_weekViewController.h
//  openSiS
//
//  Created by os4ed on 5/10/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface S_attendence_weekViewController : UIViewController
{
    IBOutlet UILabel *label_nodata;
    IBOutlet UILabel *label_titleforthisPage;
    NSString *date_value;
}

@property (strong) NSString *studentID;
@property (strong) NSString *studentName;
-(NSString*)loaddatax1;
@end
