//
//  AppDelegate.h
//  openSiS
//
//  Created by EjobIndia on 10/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo,*dic_term,*dic_year,*dic_sub,*dic_course,*dic_school;

@property(strong,nonatomic)NSMutableArray *cp_value,*dateary,*statecodeary;
@property(strong,nonatomic)ViewController *viewController;
@property(strong,nonatomic)UINavigationController *navigation;
@property(strong,nonatomic)NSString *str_txt_url;
@end

