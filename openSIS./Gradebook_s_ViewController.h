//
//  Gradebook_s_ViewController.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Gradebook_s_ViewController : UIViewController
{

    IBOutlet UITableView *grade_table;

}
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *mp_text;
//@property (strong, nonatomic) IBOutlet UITableView *totaltble;
-(IBAction)home:(id)sender;


@end
