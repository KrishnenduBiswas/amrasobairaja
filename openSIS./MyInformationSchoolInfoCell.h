//
//  MyInformationSchoolInfoCell.h
//  openSiS
//
//  Created by subhajit halder on 12/01/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationSchoolInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_schoolname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_profile;
@property (weak, nonatomic) IBOutlet UILabel *lbl_startdate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_activeornot;

@end
