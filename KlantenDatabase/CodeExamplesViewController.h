//
//  CodeExamplesViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 05-05-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "CodeExamples.h"

@interface CodeExamplesViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *codeViewTable;
@property (weak, nonatomic) IBOutlet UITextView *codeView;

@end
