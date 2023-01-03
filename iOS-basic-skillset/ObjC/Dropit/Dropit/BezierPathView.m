//
//  BezierPathView.m
//  Dropit
//
//  Created by Monil Gandhi on 06/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

- (void)setPath:(UIBezierPath *)path{
  _path = path;
  [self setNeedsLayout];
}

- (void)drawRect:(CGRect)rect {
  [self.path stroke];
}

@end
