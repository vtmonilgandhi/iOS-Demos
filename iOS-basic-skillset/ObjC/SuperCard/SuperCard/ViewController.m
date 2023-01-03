//
//  ViewController.m
//  SuperCard
//
//  Created by Monil Gandhi on 06/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong,nonatomic) Deck *deck ;
@end

@implementation ViewController

- (Deck *)deck {
  if(!_deck) _deck = [[PlayingCardDeck alloc] init];
  return _deck;
}

- (void)drawRandomPlayingCard {
  Card *card = [self.deck drawRandomCard];
  if([card isKindOfClass:[PlayingCard class]]){
    PlayingCard *playingCard = (PlayingCard *)card;
    self.playingCardView.rank = playingCard.rank;
    self.playingCardView.suit = playingCard.suit;
  }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
  if(!_playingCardView.faceUp) [self drawRandomPlayingCard];
  self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView
                                                                                      action:@selector(pinch:)]];
  self.playingCardView.suit = @"♥️";
  self.playingCardView.rank = 12;
}

@end
