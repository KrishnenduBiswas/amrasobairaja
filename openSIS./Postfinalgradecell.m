//
//  Postfinalgradecell.m
//  openSiS
//
//  Created by os4ed on 11/23/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "Postfinalgradecell.h"

@implementation Postfinalgradecell

- (void)awakeFromNib {
    
    _view_grades.clipsToBounds = YES;
    [_view_grades.layer setBorderWidth:1.0f];
    [_view_grades.layer setCornerRadius:1.5f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
