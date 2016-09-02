//
//  ip_url.h
//  openSIS-demo
//
//  Created by Apple on 11/08/14.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ip_url : NSObject
@property(retain,nonatomic)NSString *url,*url2,*url3,*url4;
-(NSString *)ipurl;


- (void)fetchjson:(NSString *)urlString keyvalue:(NSString *)keyvalue;
@end
