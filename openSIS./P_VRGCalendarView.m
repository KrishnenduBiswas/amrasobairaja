//
//  VRGCalendarView.m
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "P_VRGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"

@implementation P_VRGCalendarView
{
    NSInteger firstWeekDay21;
    UIImage *myImage;
}
@synthesize currentMonth,labelCurrentMonth, delegate,animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate;

#pragma mark - Select Date
-(void)selectDate:(int)date
{
    
  
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    if (self.timeZone)
        [gregorian setTimeZone:self.timeZone];
    
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
    [comps setDay:date];
    self.selectedDate = [gregorian dateFromComponents:comps];
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear)
    {
        [self showPreviousMonth];
    }
    else if (selectedDateYear > currentMonthYear)
    {
        [self showNextMonth];
    }
    else if (selectedDateMonth < currentMonthMonth)
    {
        [self showPreviousMonth];
    }
    else if (selectedDateMonth > currentMonthMonth)
    {
        [self showNextMonth];
    }
    else
    {
        [self setNeedsDisplay];
    }
    
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)]) [delegate calendarView:self dateSelected:self.selectedDate];
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates
{
    self.markedDates = dates;
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[dates count]; i++) {
        [colors addObject:[UIColor blueColor]];
    }
    
    self.markedColors = [NSArray arrayWithArray:colors];
    [colors release];
    
    [self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors
{
    self.markedDates = dates;
    self.markedColors = colors;
    [self setNeedsDisplay];
}

#pragma mark - Set date to now

-(void)reset
{
   NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    if (self.timeZone)
        [gregorian setTimeZone:self.timeZone];
    
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    
   /*NSString *s=@"2015-11-18";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // = [[NSDate alloc] init];
    // voila!
    self.currentMonth = [dateFormatter dateFromString:s];*/


    
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToMonth:[self.currentMonth month] year:[self.currentMonth year] numOfDays:[self.currentMonth numDaysInMonth] targetHeight:self.calendarHeight animated:NO];
}

#pragma mark - Next & Previous
-(void)showNextMonth
{
    if(isAnimating) return;
    self.markedDates=nil;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
   [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
   // UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
   if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:year:numOfDays:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] year:[currentMonth year] numOfDays:[currentMonth numDaysInMonth] targetHeight:self.calendarHeight animated:NO];
    prepAnimationNextMonth=NO;
   [self setNeedsDisplay];
    
   // UIImage *imageNextMonth = [self drawCurrentState];
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, targetSize-kVRGCalendarViewTopBarHeight)];
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
    //Animate
    //self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
   // self.animationView_B = [[UIImageView alloc] initWithImage:imageNextMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasNextMonthDays) {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (kVRGCalendarViewDayHeight+3);
    } else {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
    }
    
    //Animation
    __block P_VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.00
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
                         if (hasNextMonthDays) {
                             animationView_A.frameY = -animationView_A.frameHeight + kVRGCalendarViewDayHeight+3;
                         }
                         else
                         {
                             animationView_A.frameY = -animationView_A.frameHeight + 3;
                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

-(void)showPreviousMonth
{
    if (isAnimating) return;
    isAnimating=YES;
    self.markedDates=nil;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
   // UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:year:numOfDays:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] year:[currentMonth year] numOfDays:[currentMonth numDaysInMonth] targetHeight:self.calendarHeight animated:NO];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
  //  UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, kVRGCalendarViewTopBarHeight, kVRGCalendarViewWidth, targetSize-kVRGCalendarViewTopBarHeight)];
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
    [animationHolder release];
    
  //  self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
  //  self.animationView_B = [[UIImageView alloc] initWithImage:imagePreviousMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasPreviousDays) {
        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-kVRGCalendarViewDayHeight) + 3;
    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
    }
    
    __block P_VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.00
                     animations:^{
                         [self updateSize];
                         
                         if (hasPreviousDays) {
                             animationView_A.frameY = animationView_B.frameHeight-(kVRGCalendarViewDayHeight+3); 
                             
                         } else {
                             animationView_A.frameY = animationView_B.frameHeight-3;
                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}


#pragma mark - update size & row count
-(void)updateSize
{
    self.frameHeight = self.calendarHeight;
 //   [self setNeedsDisplay];
}

-(float)calendarHeight
{
   // return kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
     return kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
}

-(int)numRows
{
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]-1);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{       
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    
    if (touchPoint.y > kVRGCalendarViewTopBarHeight) {
        float xLocation = touchPoint.x;
        float yLocation = touchPoint.y-kVRGCalendarViewTopBarHeight;
        
        int column = floorf(xLocation/(kVRGCalendarViewDayWidth+2));
        int row = floorf(yLocation/(kVRGCalendarViewDayHeight+2));
        
        int blockNr = (column+1)+row*7;
        int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
        int date = blockNr-firstWeekDay;
        [self selectDate:date];
        return;
    }
    
    self.markedDates=nil;
    self.markedColors=nil;  
    //change left arrow write arrow size
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    //change touch position for calender
   // CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    //Set touchn point 
     CGRect rectArrowRight = CGRectMake(self.frame.size.width-200, 0, 60, 40);
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint))
    {
    [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:year:numOfDays:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] year:[currentMonth year] numOfDays:[currentMonth numDaysInMonth] targetHeight:self.calendarHeight animated:NO];
    }
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
    firstWeekDay21=firstWeekDay;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    labelCurrentMonth.text = [[formatter stringFromDate:self.currentMonth] uppercaseString];
    [labelCurrentMonth sizeToFit];
   
  //  labelCurrentMonth.frameX = roundf((self.frame.size.width/2 - labelCurrentMonth.frameWidth/2)-78);
   // labelCurrentMonth.frameY = 15;
    [formatter release];
    [currentMonth firstWeekDayInMonth];
    
   CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
  /*  CGRect rectangle = CGRectMake(0,0,self.frame.size.width,kVRGCalendarViewTopBarHeight);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 12;
    int xmargin = 20;
    int ymargin = 18;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    CGContextFillPath(context);*/
    
    //Weekdays
  /*  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEE";
    CGContextSetFillColorWithColor(context,
                                   [UIColor orangeColor].CGColor);
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithObjects:@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun", nil];
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    for (int i =0; i<[weekdays count]; i++)
    {
        UIView *viewback=[[UIView alloc] initWithFrame:CGRectMake(i*(kVRGCalendarViewDayWidth+2), 40, kVRGCalendarViewDayWidth+2, 20)];
        
        
        UILabel *datelbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, kVRGCalendarViewDayWidth+2, 20)];
        datelbl.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:10];*/
        
     //   datelbl.shadowColor=[UIColor orangeColor];
       // if (i==0||i==6)
      //  {
          //  [viewback setBackgroundColor:[UIColor colorWithHexString:@"0xba2525"]];
            // datelbl.textColor=[UIColor colorWithHexString:@"0xf7c743"];
            // datelbl.textColor=[UIColor blackColor];
          // [viewback setBackgroundColor:[UIColor colorWithRed:(157/255.0) green:(205/255.0) blue:(83/255.0) alpha:1.0]];
     //   }
       // else
      //  {
         //   [viewback setBackgroundColor:[UIColor colorWithHexString:@"0xf7c743"]];
            // datelbl.textColor=[UIColor colorWithHexString:@"0xba2525"];
     //   }
        
//        datelbl.textAlignment=NSTextAlignmentCenter;
//        datelbl.text=[weekdays objectAtIndex:i];
//        [viewback addSubview:datelbl];
//        [self addSubview:viewback];
    
   // }
    int numRows = [self numRows];
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    //Grid background
    float gridHeight = numRows*(kVRGCalendarViewDayHeight+2)+1;
    CGRect rectangleGrid = CGRectMake(0,kVRGCalendarViewTopBarHeight,self.frame.size.width,gridHeight);
    CGContextAddRect(context, rectangleGrid);
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xFEEFD1"].CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xff0000"].CGColor);
    CGContextFillPath(context);
    
    //Grid white lines
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+1);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+1);
    for (int i = 1; i<7; i++)
    {
        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1-1, kVRGCalendarViewTopBarHeight);
        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1-1, kVRGCalendarViewTopBarHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1+1);
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1+1);
    }
    
    CGContextStrokePath(context);
    
    //Grid dark lines
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xcfd4d8"].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight);
    for (int i = 1; i<7; i++) {
        //columns
        CGContextMoveToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1, kVRGCalendarViewTopBarHeight);
        CGContextAddLineToPoint(context, i*(kVRGCalendarViewDayWidth+1)+i*1, kVRGCalendarViewTopBarHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1);
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, kVRGCalendarViewTopBarHeight+i*(kVRGCalendarViewDayHeight+1)+i*1);
    }
    CGContextMoveToPoint(context, 0, gridHeight+kVRGCalendarViewTopBarHeight);
    CGContextAddLineToPoint(context, kVRGCalendarViewWidth, gridHeight+kVRGCalendarViewTopBarHeight);
    
    CGContextStrokePath(context);
    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    CGContextSetFillColorWithColor(context, 
                                   [UIColor blackColor].CGColor);
    
    
    //NSLog(@"currentMonth month = %i, first weekday in month = %i",[self.currentMonth month],[self.currentMonth firstWeekDayInMonth]);
    
    int numBlocks = numRows*7;
    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth)
        {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate =[NSDate date];
    int todayBlock = -1;
   if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year])
     {
        todayBlock = [todayDate day] + firstWeekDay - 1;
     }
    

//    NSDate *todayDate1 =self.currentMonth;
//    int todayBlock1 = -1;
//    if ([todayDate1 month] == [currentMonth month] && [todayDate1 year] == [currentMonth year])
//    {
//        todayBlock1 = [todayDate1 day] + firstWeekDay - 1;
//    }

    
    for (int i=0; i<numBlocks; i++) {
        int targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (kVRGCalendarViewDayWidth+2);
        int targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2);
        
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) { //previous month
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
         //   NSString *hex = (isSelectedDatePreviousMonth) ? @"0x383838" : @"aaaaaa";
            
        //    CGContextSetFillColorWithColor(context,
                                      //     [UIColor colorWithHexString:hex].CGColor);
            CGContextSetFillColorWithColor(context,
                                           [UIColor  grayColor].CGColor);
        } else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
         //   NSString *hex = (isSelectedDateNextMonth) ? @"0x383838" : @"aaaaaa";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor grayColor].CGColor);
        } else { //current month
            //isCurrentMonth = YES;
            targetDate = (i-firstWeekDay)+1;
            NSString *hex = (isSelectedDatePreviousMonth || isSelectedDateNextMonth) ? @"0xaaaaaa" : @"0x383838";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor blackColor].CGColor);
        }
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];
        
        //draw selected date
        if (selectedDate && i==selectedDateBlock) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            //fce092
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor blueColor].CGColor);
        } else if (todayBlock==i)
        {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+2,kVRGCalendarViewDayHeight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor whiteColor].CGColor);
        }
        
        
        
    
//        else if (targetColumn==0||targetColumn==6)
//        {
//            
//            CGRect rectangleGrid = CGRectMake(targetX,targetY,kVRGCalendarViewDayWidth+1,kVRGCalendarViewDayHeight+1);
//            CGContextAddRect(context, rectangleGrid);
//            
//            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xFEEFD1"].CGColor);
//            
//            CGContextFillPath(context);
//            CGContextSetFillColorWithColor(context,
//                                           [UIColor greenColor].CGColor);
        
//        }
//        
        //change date with date formet    calendare ar date size and x y set kora.
        
        [date drawInRect:CGRectMake(targetX+15, targetY+6, 15, 15) withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];//
        
        
        
        
        UILabel*lbl=[[UILabel alloc]initWithFrame:CGRectMake(targetX+7, targetY+25, 32, 12)];
        
        
        lbl.backgroundColor=[UIColor colorWithHexString:@"70B32B"];
        
        
        lbl.text=@"P";
        
        lbl.textColor=[UIColor whiteColor];
        
        lbl.textAlignment=UITextAlignmentCenter;
        
        [lbl setFont: [lbl.font fontWithSize:10]];
        
        
        [self addSubview:lbl];
       
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    //Draw markings for terget date and month
 
    if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth)
        return;
    
    for (int i = 0; i<[self.markedDates count]; i++)
    {
       
        NSString *markedDateObj = [self.markedDates objectAtIndex:i];
        
        NSInteger targetDate=[markedDateObj integerValue];

        
        
        NSInteger targetBlock = firstWeekDay + (targetDate-1);
        NSInteger targetColumn = targetBlock%7;
        NSInteger targetRow = targetBlock/7;
        
        NSInteger targetX = targetColumn * (kVRGCalendarViewDayWidth+2) + 7;
        NSInteger targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2) + 38;
        NSLog(@"terget blok x and terget block y %ld %ld",(long)targetX,(long)targetY);
        UIImageView *ImageView=[[UIImageView alloc] initWithFrame:CGRectMake(targetX, targetY-35, 18, 18)];
        [ImageView setImage:[UIImage imageNamed:@"icon_cal_lyellow"]];
        [self addSubview:ImageView];

    }
}


-(void)UpdatewithCalenderWithimage
{
   
    for (UIView *SubView in [self subviews])
    {
        if ([SubView isKindOfClass:[UIImageView class]])
        {
            NSLog(@"The set imager viewrty");
            UIImageView *imageView=(UIImageView *)SubView;
            if (imageView.image==[UIImage imageNamed:@"icon_cal_lyellow"])
            {
                [imageView removeFromSuperview];
            }
        }
    }
    for (int i = 0; i<[self.markedDates count]; i++)
    {
        
        NSString *markedDateObj = [self.markedDates objectAtIndex:i];
        
        NSInteger targetDate=[markedDateObj integerValue];
        
        
        
        NSInteger targetBlock = firstWeekDay21 + (targetDate-1);
        NSInteger targetColumn = targetBlock%7;
        NSInteger targetRow = targetBlock/7;
        
        NSInteger targetX = targetColumn * (kVRGCalendarViewDayWidth+2) + 7;
        NSInteger targetY = kVRGCalendarViewTopBarHeight + targetRow * (kVRGCalendarViewDayHeight+2) + 38;
        NSLog(@"terget blok x and terget block y %ld %ld",(long)targetX,(long)targetY);
        UIImageView *ImageView=[[UIImageView alloc] initWithFrame:CGRectMake(targetX, targetY-35, 18, 18)];
        [ImageView setImage:[UIImage imageNamed:@"icon_cal_lyellow"]];
        [self addSubview:ImageView];
        
    }
 
}
-(void)loadPicker1{
    
    picker1 = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker1  .delegate = self;
    picker1 .dataSource = self;
    
    [ picker1  setShowsSelectionIndicator:YES];
    // picker1.tag=3;
   txtField.inputView = picker1;
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismisspicker)];
    
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    txtField.inputAccessoryView = mypickerToolbar;
    
}

#pragma mark - Draw image for animation
-(UIImage *)drawCurrentState
{
    float targetHeight = kVRGCalendarViewTopBarHeight + [self numRows]*(kVRGCalendarViewDayHeight+2)+1;
    
    UIGraphicsBeginImageContext(CGSizeMake(kVRGCalendarViewWidth, targetHeight-kVRGCalendarViewTopBarHeight));
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -kVRGCalendarViewTopBarHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - Init
-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kVRGCalendarViewWidth, 0)];
    if (self)
    {
        self.contentMode = UIViewContentModeTop;
       
        arr_picker = [[NSMutableArray alloc]initWithObjects:@"Date",@"Week",@"Month", @"Year", nil];
        [self setBackgroundColor:[UIColor greenColor]];
       /* UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kVRGCalendarViewWidth, 100)];
        [view setBackgroundColor:[UIColor colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1.0]];
        [self addSubview:view];*/
//        UIImageView *LeFrarrow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 9, 24, 24)];
//        [LeFrarrow setImage:[UIImage imageNamed:@"leftArrow"]];
//        [view addSubview:LeFrarrow];
//        
//        UIImageView *Rightrarrow=[[UIImageView alloc] initWithFrame:CGRectMake(130, 9, 24, 24)];
//        [Rightrarrow setImage:[UIImage imageNamed:@"rightArrowpng"]];
//        [view addSubview:Rightrarrow];
//        
//        view.clipsToBounds=YES;
        isAnimating=NO;
       // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(18, 15, 15, 15)];
      //  [img setImage:[UIImage imageNamed:@"cal123"]];
       // [self addSubview:img];
        self.labelCurrentMonth = [[UILabel alloc]initWithFrame:CGRectMake(33, 15, 120, 60)];
      
    labelCurrentMonth.font = [UIFont fontWithName:@"OpenSans-Semibold" size:13.0f];
        labelCurrentMonth.textColor = [UIColor blackColor];

        
  //      [self addSubview:labelCurrentMonth];
       // labelCurrentMonth.textAlignment = NSTextAlignmentCenter;
//        UILabel *Lbl=[[UILabel alloc] initWithFrame:CGRectMake(240, 2, 100, 40)];
//        Lbl.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:11.0f];
//        Lbl.textColor=[UIColor blackColor];
//        Lbl.text=@"Todays Date";
//        UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Taptomainmonth:)];
//        [Lbl setUserInteractionEnabled:YES];
//        [Lbl addGestureRecognizer:recognizer];
//        [self addSubview:Lbl];
    UIView    *view_textFieldContainer = [[UIView alloc]initWithFrame:CGRectMake(230, 8, 85, 27)];
        view_textFieldContainer.clipsToBounds = YES;
        view_textFieldContainer.backgroundColor = [UIColor whiteColor];
        view_textFieldContainer.layer.cornerRadius = 2.0f;
        view_textFieldContainer.layer.borderColor = [[UIColor colorWithRed:0.647f green:0.647f blue:0.647f alpha:1.00f] CGColor];
        view_textFieldContainer.layer.borderWidth = 1.0f;
        
        txtField = [[UITextField alloc]initWithFrame:CGRectMake(9, -10, 100, 50)];
        [txtField setBorderStyle:UITextBorderStyleNone];
        txtField.delegate = self;
         txtField.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12.0f];
        txtField.text=@"Month";
        UIImageView *downimg = [[UIImageView alloc]initWithFrame:CGRectMake(55 , 9, 11 , 11)];
        downimg.image = [UIImage imageNamed:@"downArow.png"];
        [downimg setContentMode:UIViewContentModeScaleAspectFit];
        
         [self loadPicker1];
        [view_textFieldContainer addSubview:txtField];
        [view_textFieldContainer addSubview:downimg];
        [view_textFieldContainer bringSubviewToFront:downimg];
      //  [self addSubview:view_textFieldContainer];
        
        [self performSelector:@selector(reset) withObject:nil afterDelay:0.1];
   
        //so delegate can be set after init and still get called on init
        //        [self reset];
    }
    return self;
}

-(void)dismisspicker
{
    [txtField resignFirstResponder];

}
-(void)Taptomainmonth:(UITapGestureRecognizer *)gesture
{
    [delegate GetTodaysmonth:gesture];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arr_picker.count;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arr_picker objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    txtField.text = [arr_picker objectAtIndex:row];
 //   NSString *str_12=[NSString stringWithFormat:@"%@",self.text_mon_day_yr.text];
   // if ([str_12 isEqualToString:@"Month"]) {
        
//        UIStoryboard *s=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        MonthViewController *obj=[s instantiateViewControllerWithIdentifier:@"month"];
//        obj.studentID=self.studentID;
//        [self.navigationController pushViewController:obj animated:YES];
        
  //  }
}

//show today date

-(void)dealloc
{
    
    self.delegate=nil;
    self.currentMonth=nil;
    self.labelCurrentMonth=nil;
    
    self.markedDates=nil;
    self.markedColors=nil;
    
    [super dealloc];
}
@end
