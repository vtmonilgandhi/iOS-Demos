//
//  main.m
//  House
//
//  Created by Monil Gandhi on 03/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "House.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
      // insert code here...
      NSLog(@"Hello, World!");
    House *myHouse = [[House alloc] init];
    int number = myHouse.numberOfBedrooms;
    
    NSLog(@"%d" , number);
    
  }
  return 0;
}
