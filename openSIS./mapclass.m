//
//  mapclass.m
//  openSiS
//
//  Created by os4ed on 4/19/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import "mapclass.h"

@implementation mapclass

@synthesize title, coordinate,saveIndex,subTitle,type;

- (id)initWithTitle:(NSString *)ttl subTitle:(NSString *)subttl andCoordinate:(CLLocationCoordinate2D)c2d {
    
    self=[super init];
    self.title = ttl;
    self.type = type;
    self.subTitle = subttl;
    self.coordinate = c2d;
    return self;
}


// optional
- (NSString *)subtitle
{
    return self.subTitle;
}


@end
