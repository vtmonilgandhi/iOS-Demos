//
//  DeviceDetailViewController.m
//  PersonInfo
//
//  Created by Monil Gandhi on 10/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import <CoreData/CoreData.h>
#import "DeviceViewController.h"

@interface DeviceDetailViewController ()
@property (strong) NSMutableArray *devices;
@end

@implementation DeviceDetailViewController

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];

  NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];
  self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

  [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"UpdateDevice"]) {
    NSManagedObject *selectedDevice = [self.devices objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    DeviceViewController *destViewController = segue.destinationViewController;
    destViewController.device = selectedDevice;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return self.devices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

  // Configure the cell...
  NSManagedObject *device = [self.devices objectAtIndex:indexPath.row];
  [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@", [device valueForKey:@"name"], [device valueForKey:@"version"]]];
  [cell.detailTextLabel setText:[device valueForKey:@"company"]];

  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Return NO if you do not want the specified item to be editable.
  return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSManagedObjectContext *context = [self managedObjectContext];

  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete object from database
    [context deleteObject:[self.devices objectAtIndex:indexPath.row]];

    NSError *error = nil;
    if (![context save:&error]) {
      NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
      return;
    }

    // Remove device from table view
    [self.devices removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

@end
