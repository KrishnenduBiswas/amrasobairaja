//
//  mapviewAnnotation1.h
//  Goferme
//
//  Created by Tanay Bhattacharjee on 04/04/15.
//  Copyright (c) 2015 Tanay Bhattacharjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface mapviewAnnotation1 : NSObject<MKAnnotation>{
    
    NSString *title;
    NSString *subTitle;
    CLLocationCoordinate2D coordinate;
    
    NSString *saveIndex,*type;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *saveIndex,*type;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)ttl subTitle:(NSString *)subttl andCoordinate:(CLLocationCoordinate2D)c2d;

@end
