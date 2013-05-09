//
//  addCodeViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 05-05-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeExamples.h"
#import "sqlite3.h"


@interface addCodeViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myCodeTitle;
@property (weak, nonatomic) IBOutlet UITextView *myCode;


@end
