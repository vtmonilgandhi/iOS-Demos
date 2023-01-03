//
//  RPSController.h
//  RockPaperScissors
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSGame.h"

@interface RPSController : NSObject

@property (nonatomic) RPSGame *game;
-(void) throwDown: (Move) plyersMove;
-(NSString*)messageForGame:(RPSGame*)game;
@end
