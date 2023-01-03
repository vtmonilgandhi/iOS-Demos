//
//  ViewController.m
//  PersonInfo
//
//  Created by Monil Gandhi on 10/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "DeviceViewController.h"
#import <CoreData/CoreData.h>

@interface DeviceViewController ()

@end

@implementation DeviceViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}


- (NSManagedObjectContext *)managedObjectContext {
  NSManagedObjectContext *context = nil;
  id delegate = [[UIApplication sharedApplication] delegate];
  if ([delegate performSelector:@selector(managedObjectContext)]) {
    context = [delegate managedObjectContext];
  }
  return context;
}

- (IBAction)save:(id)sender {
  NSManagedObjectContext *context = [self managedObjectContext];

  // Create a new managed object
  NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
  [newDevice setValue:self.nameTextField.text forKey:@"name"];
  [newDevice setValue:self.versionTextField.text forKey:@"version"];
  [newDevice setValue:self.companyTextField.text forKey:@"company"];

  NSError *error = nil;
  // Save the object to persistent store
  if (![context save:&error]) {
    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
  }

  [self dismissViewControllerAnimated:YES completion:nil];
}



@end
