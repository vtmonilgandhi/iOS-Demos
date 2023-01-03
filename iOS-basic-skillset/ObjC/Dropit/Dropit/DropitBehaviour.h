//
//  DropitBehaviour.h
//  Dropit
//
//  Created by Monil Gandhi on 06/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehaviour : UIDynamicBehavior

- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;

@end
