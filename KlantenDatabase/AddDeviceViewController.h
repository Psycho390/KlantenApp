//
//  AddDeviceViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 17-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"
#import "sqlite3.h"
@interface AddDeviceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UITextField *merkField;

- (IBAction)clearFields;


@end
