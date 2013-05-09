//
//  AddDeviceViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 17-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "AddDeviceViewController.h"

@interface AddDeviceViewController ()
{
    sqlite3 *personDB;
    NSString *dbPathString;
  


}
@end

@implementation AddDeviceViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createOrOpenDB];
    //add button creëren
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addDeviceButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)createOrOpenDB{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"klanten.db"];
    
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        
        
    }
}

- (void)addDeviceButton:(id)sender {
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *inserStmt =[NSString stringWithFormat:@"INSERT INTO DEVICES(TYPE, MERK) values ('%s', '%s')",[self.typeField.text UTF8String], [self.merkField.text UTF8String]];
        
        const char *insert_stmt = [inserStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {

            
        }
        sqlite3_close(personDB);
    }
    UIAlertView* alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Toevoegen van Device gelukt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [self clearFields];
    
}


- (IBAction)clearFields {
    
    self.typeField.text=@"";
    self.merkField.text =@"";

}
@end
