//
//  House.m
//  House
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "House.h"
@interface House()

@property (nonatomic,readwrite) int numberOfBedrooms;

@end

@implementation House

-(instancetype) initWithAddress: (NSString*)address {
  self = [super init];
  
  if(self){
    _address = [address copy];
    _numberOfBedrooms = 2;
    _hasHotTub = false;
  }
  return self;
}
@end
