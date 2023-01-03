//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Monil Gandhi on 04/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)flipCardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex2:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *status;

@end
