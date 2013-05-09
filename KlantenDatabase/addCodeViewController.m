//
//  addCodeViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 05-05-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "addCodeViewController.h"

@interface addCodeViewController (){
    sqlite3 *personDB;
    NSString *dbPathString;

}

@end

@implementation addCodeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	self.myCodeTitle.delegate = self;
    [self createOrOpenDB];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"add" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addCode:)];
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

- (void)addCode:(id)sender {
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *inserStmt;
                    inserStmt =[NSString stringWithFormat:@"INSERT INTO CODE(TITLE, CODE) values ('%s', '%s')",[self.myCodeTitle.text UTF8String], [self.myCode.text UTF8String]];
        
        const char *insert_stmt = [inserStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
            
            
        }
        sqlite3_close(personDB);
    }
    UIAlertView* alert;
            alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Toevoegen van Code gelukt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    [self clearFields];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.myCodeTitle) {
        [textField resignFirstResponder];
        [self.myCode becomeFirstResponder];
    }     return YES;
}

- (IBAction)clearFields {
    self.myCodeTitle.text = @"";
    self.myCode.text= @"";

}
@end
