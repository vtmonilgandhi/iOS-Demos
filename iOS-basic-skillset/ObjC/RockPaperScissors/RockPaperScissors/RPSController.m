//
//  RPSController.m
//  RockPaperScissors
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "RPSController.h"
#import "RPSTurn.h"
#import "RPSGame.h"

@implementation RPSController

-(void) throwDown: (Move) plyersMove {
  
  RPSTurn *playersTurn = [[RPSTurn alloc] initWithMove:plyersMove];
  RPSTurn *computerTurn = [[RPSTurn alloc] init];
  
  self.game = [[RPSGame alloc] initWithFirstTurn:playersTurn
                                      secondTurn:computerTurn];
}


-(NSString*)resultString:(RPSGame*)game {
  return [game.firstTurn defeats:game.secondTurn] ? @"You Win!" : @"You Lose!";
}


-(NSString*)messageForGame:(RPSGame*)game {
  // Handle the tie
  if (game.firstTurn.move == game.secondTurn.move) {
    return @"It's a tie!";
  } else {
    
    // Here we build up the results message "Rock crushes Scissors. You Win!" etc.
    NSString *winnerString = [[game winner] description];
    NSString *loserString = [[game loser]  description];
    NSString *resultsString = [self resultString: game];
    
    NSString *wholeString =  [NSString stringWithFormat:@"%@ %@ %@ %@ %@", winnerString, @" defeats ", loserString, @".",  resultsString];
    
    return wholeString;
  }
}

@end
