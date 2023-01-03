//
//  main.m
//  RockPaperScissors
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSController.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    
    RPSController *gameController = [[RPSController alloc] init];
    [gameController throwDown:Paper];
    NSString *resultsMessage = [gameController messageForGame:gameController.game];
     NSLog(@"%@", resultsMessage);
  }
  return 0;
}
