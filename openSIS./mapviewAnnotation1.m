//
//  mapviewAnnotation1.m
//  Goferme
//
//  Created by Tanay Bhattacharjee on 04/04/15.
//  Copyright (c) 2015 Tanay Bhattacharjee. All rights reserved.
//

#import "mapviewAnnotation1.h"

@implementation mapviewAnnotation1

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
