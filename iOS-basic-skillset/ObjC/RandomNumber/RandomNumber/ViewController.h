//
//  ViewController.h
//  RandomNumber
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIAlertViewDelegate> {

IBOutlet UILabel *scoreLabel;
IBOutlet UILabel *timerLabel;
  
  NSInteger count;
  NSInteger seconds;
  NSTimer *timer;

}
- (IBAction)buttonPressed;
@end

