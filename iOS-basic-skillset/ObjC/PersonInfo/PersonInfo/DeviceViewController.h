//
//  ViewController.h
//  PersonInfo
//
//  Created by Monil Gandhi on 10/07/18.
//  Copyright © 2018 Monil Gandhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DeviceViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *versionTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;

@property (strong) NSManagedObject *device;

- (IBAction)save:(id)sender;
@end

