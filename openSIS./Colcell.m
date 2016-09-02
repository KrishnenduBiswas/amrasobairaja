//
//  Colcell.m
//  Routine
//
//  Created by APPLE on 21/04/16.
//  Copyright (c) 2016 ejobs. All rights reserved.
//

#import "Colcell.h"

@implementation Colcell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
