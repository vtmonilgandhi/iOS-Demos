//
//  RPSGame.m
//  RockPaperScissors
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "RPSGame.h"
#import "RPSTurn.h"

@implementation RPSGame

-(instancetype)initWithFirstTurn:(RPSTurn*) playerTurn secondTurn: (RPSTurn*)computerTurn {
  self = [super init];
  
  if(self) {
    _firstTurn = playerTurn;
    _secondTurn = computerTurn;
  }
  
  return self;
}

-(RPSTurn*)winner {
  return [self.firstTurn defeats:self.secondTurn] ? self.firstTurn : self.secondTurn;
}

-(RPSTurn*)loser {
  return [self.firstTurn defeats:self.secondTurn] ? self.secondTurn : self.firstTurn;
}


@end
