//
//  AddKlantViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 17-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"
#import "sqlite3.h"
#import "Klant.h"


@interface AddKlantViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *naamField;
@property (weak, nonatomic) IBOutlet UITextField *straatField;
@property (weak, nonatomic) IBOutlet UITextField *huisnrField;
@property (weak, nonatomic) IBOutlet UITextField *postcodeField;
@property (weak, nonatomic) IBOutlet UITextField *stadField;
@property (weak, nonatomic) IBOutlet UITextField *telnrField;
@property (weak, nonatomic) IBOutlet UITextField *mobielField;
@property (nonatomic)BOOL alter;
@property (nonatomic) Klant *klantToAlter;
- (IBAction)clearFields;
-(void)setKlantToAlter:(Klant *)klantToAlter;

@end
