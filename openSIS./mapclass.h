//
//  mapclass.h
//  openSiS
//
//  Created by os4ed on 4/19/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface mapclass : NSObject <MKAnnotation>{
    
    NSString *title;
    NSString *subTitle;
    CLLocationCoordinate2D coordinate;
    
    NSString *saveIndex,*type;
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *saveIndex,*type;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)ttl subTitle:(NSString *)subttl andCoordinate:(CLLocationCoordinate2D)c2d;



@end
