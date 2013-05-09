//
//  AddKlantViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 17-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "AddKlantViewController.h"

@interface AddKlantViewController (){
sqlite3 *personDB;
NSString *dbPathString;

}
@end

@implementation AddKlantViewController


- (void)viewDidLoad
{
    self.alter = NO;
    [super viewDidLoad];
    self.naamField.delegate = self;
    self.straatField.delegate = self;
    self.huisnrField.delegate = self;
    self.postcodeField.delegate = self;
    self.stadField.delegate = self;
    self.telnrField.delegate = self;
    self.mobielField.delegate = self;

   
    
    
    
	[self createOrOpenDB];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addKlantButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
}
-(void)viewDidAppear:(BOOL)animated{
    if(self.alter) {
        self.naamField.text = self.klantToAlter.naam;
        self.straatField.text= self.klantToAlter.straat;
        self.huisnrField.text= self.klantToAlter.huisnr;
        self.postcodeField.text= self.klantToAlter.postcode;
        self.stadField.text= self.klantToAlter.stad;
        self.telnrField.text= self.klantToAlter.telnr;
        self.mobielField.text= self.klantToAlter.mobiel;
        
    }
}

- (void)createOrOpenDB{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"klanten.db"];
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        
        
    }
}

- (void)addKlantButton:(id)sender {
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *inserStmt;
        if(self.alter){
            inserStmt =[NSString stringWithFormat:@"UPDATE KLANTEN SET NAME = '%s', STREET = '%s', POSTCODE= '%s', HUISNR= '%s', STAD= '%s', TELNR= '%s', MOBIEL = '%s' WHERE ID = '%i'",[self.naamField.text UTF8String], [self.straatField.text UTF8String],[self.postcodeField.text UTF8String],[self.huisnrField.text UTF8String],[self.stadField.text UTF8String],[self.telnrField.text UTF8String],[self.mobielField.text UTF8String], self.klantToAlter.ID];

        }else{
        inserStmt =[NSString stringWithFormat:@"INSERT INTO KLANTEN(NAME, STREET, POSTCODE, HUISNR, STAD, TELNR, MOBIEL) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s')",[self.naamField.text UTF8String], [self.straatField.text UTF8String],[self.postcodeField.text UTF8String],[self.huisnrField.text UTF8String],[self.stadField.text UTF8String],[self.telnrField.text UTF8String],[self.mobielField.text UTF8String]];
        }
        const char *insert_stmt = [inserStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
        
            
        }
        sqlite3_close(personDB);
    }
    UIAlertView* alert;
    if(self.alter){
           alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Aanpassen van Klant gelukt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil]; 
    }else{
    alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Toevoegen van Klant gelukt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alert show];
    [self clearFields];
   
    
}
-(void)setKlantToAlter:(Klant *)klantToAlter{
    self.klantToAlter = klantToAlter;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.naamField) {
        [textField resignFirstResponder];
        [self.straatField becomeFirstResponder];
    } else if (textField == self.straatField) {
        [textField resignFirstResponder];
        [self.huisnrField becomeFirstResponder];
    } else if (textField == self.huisnrField) {
        [textField resignFirstResponder];
        [self.postcodeField becomeFirstResponder];
    } else if (textField == self.postcodeField) {
        [textField resignFirstResponder];
        [self.stadField becomeFirstResponder];
    } else if (textField == self.stadField) {
        [textField resignFirstResponder];
        [self.telnrField becomeFirstResponder];
    } else if (textField == self.telnrField) {
        [textField resignFirstResponder];
        [self.mobielField becomeFirstResponder];
    } else if (textField == self.mobielField) {
        [textField resignFirstResponder];
            }
    return YES;
}

- (IBAction)clearFields {
    self.naamField.text = @"";
    self.straatField.text= @"";
    self.postcodeField.text= @"";
    self.huisnrField.text= @"";
    self.stadField.text= @"";
    self.telnrField.text= @"";
    self.mobielField.text= @"";
}
@end
