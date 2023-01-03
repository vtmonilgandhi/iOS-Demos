//
//  Bedroom.h
//  House
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,Direction) {
  North,
  South,
  East,
  Weat
};
@interface Bedroom : NSObject

@property (nonatomic) BOOL privateBath;
@property (nonatomic) Direction directionWindowFaces;


@end
