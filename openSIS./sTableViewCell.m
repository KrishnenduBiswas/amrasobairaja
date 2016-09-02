//
//  GradeBookTableViewCell.m
//  openSiS
//
//  Created by os4ed on 9/24/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "sTableViewCell.h"

@implementation sTableViewCell

- (void)awakeFromNib {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
