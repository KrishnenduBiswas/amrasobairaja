//
//  AssignmentTableViewCell.m
//  openSiS
//
//  Created by os4ed on 9/25/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import "AssignmentTableViewCell.h"

@implementation AssignmentTableViewCell
@synthesize view_noview;
- (void)awakeFromNib {
    // Initialization code
    
   // view_noview.layer.backgroundColor = self.layer.backgroundColor;
   
}

-(void)pressed:(UILongPressGestureRecognizer*)gesture
{
    NSLog(@"LongPress");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
