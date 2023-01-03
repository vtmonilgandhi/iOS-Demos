//
//  RPSTurn.h
//  RockPaperScissors
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Move) {
  Rock,
  Paper,
  Scissors,
  Invalid
};

@interface RPSTurn : NSObject

@property (nonatomic) Move move;

-(instancetype)initWithMove:(Move) move;
-(NSString *)description;
-(BOOL) defeats: (RPSTurn *) opponent ;
@end
