//
//  mapViewController.h
//  openSiS
//
//  Created by os4ed on 4/19/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface mapViewController : UIViewController
{
    
    IBOutlet MKMapView *mapview;
    IBOutlet UILabel *lbl_name;
    
}

@property(strong,nonatomic)NSString *str_address,*str_name;



@end
