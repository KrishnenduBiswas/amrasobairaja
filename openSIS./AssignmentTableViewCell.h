//
//  AssignmentTableViewCell.h
//  openSiS
//
//  Created by os4ed on 9/25/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet UILabel *lbl_marks;
@property (strong, nonatomic) IBOutlet UIView *view_noview;

@end
