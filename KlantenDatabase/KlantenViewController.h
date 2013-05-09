//
//  KlantenViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Klant.h"
#import "sqlite3.h"

@interface KlantenViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mijnKlantenTable;


@end
