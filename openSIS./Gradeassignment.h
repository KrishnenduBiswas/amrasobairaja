//
//  Gradeassignment.h
//  openSiS
//
//  Created by os4ed on 4/26/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPdetails.h"
#import "Gradeassignment.h"

@interface Gradeassignment : UIViewController
@property(strong ,nonatomic)NSString *course_id_str ,*name_title ,*id_cp;

@property (strong, nonatomic) IBOutlet UILabel *assgntype;
@property (strong, nonatomic) IBOutlet UILabel *titleee;
@property (strong, nonatomic) IBOutlet UILabel *points;
@property (strong, nonatomic) IBOutlet UILabel *assgndate;
@property (strong, nonatomic) IBOutlet UILabel *duedate;
@property (strong, nonatomic) IBOutlet UITextView *descrip;
@property (strong, nonatomic) IBOutlet UILabel *assgntitleheader;

@end
