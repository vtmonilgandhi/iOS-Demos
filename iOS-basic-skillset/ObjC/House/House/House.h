//
//  House.h
//  House
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bedroom.h"
@interface House : NSObject

@property (nonatomic,copy) NSString *address;
@property (nonatomic,readonly) int numberOfBedrooms;
@property (nonatomic) bool hasHotTub;

@property (nonatomic) Bedroom *frontBedroom;
@property (nonatomic) Bedroom *backBedroom;

-(instancetype) initWithAddress: (NSString*)address;

@end
