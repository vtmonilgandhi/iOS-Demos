//
//  ViewController.m
//  Imaginarium
//
//  Created by Monil Gandhi on 09/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if([segue.destinationViewController isKindOfClass:[ImageViewController class]]){
    ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
    ivc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",segue.identifier]];
  }
}
@end
