//
//  ClassWorkCell.h
//  openSiS
//
//  Created by os4ed on 10/28/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassWorkCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_points;
@property (strong, nonatomic) IBOutlet UILabel *lbl_time;
@property (strong, nonatomic) IBOutlet UIView *view_noview;

@end
