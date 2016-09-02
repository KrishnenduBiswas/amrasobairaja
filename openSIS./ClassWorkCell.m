//
//  ClassWorkCell.m
//  openSiS
//
//  Created by os4ed on 10/28/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "ClassWorkCell.h"

@implementation ClassWorkCell

- (void)awakeFromNib {
    // Initialization code
    self.view_noview.backgroundColor = self.backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
