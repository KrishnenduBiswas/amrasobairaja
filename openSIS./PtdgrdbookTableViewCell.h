//
//  StdgrdbookTableViewCell.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PtdgrdbookTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *graderange_lbl;
@property (strong, nonatomic) IBOutlet UILabel *ungrade_lbl;
@property (strong, nonatomic) IBOutlet UILabel *grade;
@property (strong, nonatomic) IBOutlet UILabel *title_lbl;
@property (strong, nonatomic) IBOutlet UILabel *percent_lbl;

@end
