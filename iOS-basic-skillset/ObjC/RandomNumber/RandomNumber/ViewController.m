//
//  ViewController.m
//  RandomNumber
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupGame];
}

- (IBAction)buttonPressed {
  NSLog(@"Pressed!");
  
  count++;
  scoreLabel.text = [NSString stringWithFormat:@"Score %li", (long)count];
}

-(void) setupGame {
  seconds = 30;
  count = 0;
  
  timerLabel.text = [NSString stringWithFormat:@"Time %li", (long)seconds];
  scoreLabel.text = [NSString stringWithFormat:@"Score %li", (long)count];
  
  timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                           target:self
                                         selector:@selector(subtractTime)
                                         userInfo:nil
                                          repeats:YES];
}

-(void) subtractTime {
  seconds--;
  timerLabel.text = [NSString stringWithFormat:@"Time %li", (long)seconds];
  if (seconds == 0) {
    [timer invalidate];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Time is up!"
                                                                             message:[NSString stringWithFormat:@"You scored %li points", (long)count]       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Play Again"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action){
                                                        [self setupGame];
                                                      }]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
  }
}



@end
