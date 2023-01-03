//
//  DropitBehaviour.m
//  Dropit
//
//  Created by Monil Gandhi on 06/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "DropitBehaviour.h"

@interface DropitBehaviour() 
@property (strong,nonatomic) UIGravityBehavior *gravity;
@property (strong,nonatomic) UICollisionBehavior *colider;
@property (strong,nonatomic) UIDynamicItemBehavior *animationOption;
@end

@implementation DropitBehaviour

- (UIGravityBehavior *)gravity {
  if(!_gravity){
    _gravity = [[UIGravityBehavior alloc] init];
    _gravity.magnitude = 0.9;
  }
  return _gravity;
}

- (UICollisionBehavior *)colider {
  if(!_colider){
    _colider = [[UICollisionBehavior alloc] init];
    _colider.translatesReferenceBoundsIntoBoundary = YES;
  }
  return _colider;
}

- (UIDynamicItemBehavior *)animationOption {
  if(!_animationOption){
    _animationOption = [[UIDynamicItemBehavior alloc] init];
    _animationOption.allowsRotation = NO;
  }
  return _animationOption;
}

- (void)addItem:(id <UIDynamicItem>)item{
  [self.gravity addItem:item];
  [self.colider addItem:item];
  [self.animationOption addItem:item];
}

- (void)removeItem:(id <UIDynamicItem>)item{
  [self.gravity removeItem:item];
  [self.colider removeItem:item];
  [self.animationOption removeItem:item];
  }


- (instancetype)init {
  self = [super init];
  [self addChildBehavior:self.gravity];
  [self addChildBehavior:self.colider];
  [self addChildBehavior:self.animationOption];
  return self;
}
@end

