//
//  MessageGroupsCell.h
//  openSiS
//
//  Created by os4ed on 1/4/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageGroupsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_grouptitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_groupDesc;
@property (strong, nonatomic) IBOutlet UILabel *lbl_groupCreation;
@property (strong, nonatomic) IBOutlet UILabel *lbl_groupMembers;


@end
