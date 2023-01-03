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
@synthesize device;

- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.device) {
    [self.nameTextField setText:[self.device valueForKey:@"name"]];
    [self.versionTextField setText:[self.device valueForKey:@"version"]];
    [self.companyTextField setText:[self.device valueForKey:@"company"]];
  }
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

  if (self.device) {
    // Update existing device
    [self.device setValue:self.nameTextField.text forKey:@"name"];
    [self.device setValue:self.versionTextField.text forKey:@"version"];
    [self.device setValue:self.companyTextField.text forKey:@"company"];

  } else {
    // Create a new device
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
    [newDevice setValue:self.nameTextField.text forKey:@"name"];
    [newDevice setValue:self.versionTextField.text forKey:@"version"];
    [newDevice setValue:self.companyTextField.text forKey:@"company"];
  }

  NSError *error = nil;
  // Save the object to persistent store
  if (![context save:&error]) {
    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
  }

  [self dismissViewControllerAnimated:YES completion:nil];
}


@end
