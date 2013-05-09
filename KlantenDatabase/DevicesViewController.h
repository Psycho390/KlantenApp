//
//  DevicesViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"
#import "sqlite3.h"
@interface DevicesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) IBOutlet UITableView *mijnDevicesTable;

@end
