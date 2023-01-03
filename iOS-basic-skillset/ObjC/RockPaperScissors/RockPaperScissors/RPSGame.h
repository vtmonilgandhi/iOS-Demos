//
//  RPSGame.h
//  RockPaperScissors
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSTurn.h"

@interface RPSGame : NSObject

@property (nonatomic) RPSTurn *firstTurn;
@property (nonatomic) RPSTurn *secondTurn;

-(instancetype)initWithFirstTurn:(RPSTurn*) playerTurn secondTurn: (RPSTurn*)computerTurn;
-(RPSTurn*)winner;
-(RPSTurn*)loser;

@end
