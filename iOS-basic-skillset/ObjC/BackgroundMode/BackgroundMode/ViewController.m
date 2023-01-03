//
//  ViewController.m
//  BackgroundMode
//
//  Created by Monil Gandhi on 10/09/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.timeLabel.text = @"12:00:00";
}


- (void)alterTime
{
  NSDate *now = [NSDate date];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"HH:mm:ss"];
  NSString *timeString = [dateFormatter stringFromDate:now];
  self.timeLabel.text = timeString;
}

@end
