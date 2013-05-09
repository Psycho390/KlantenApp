//
//  ViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
sqlite3 *personDB;
NSString *dbPathString;
NSString *entryText;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createOrOpenDB];
}

- (void)createOrOpenDB{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"klanten.db"];
    
    char *error;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        //creat db here
        if (sqlite3_open(dbPath, &personDB)==SQLITE_OK) {
            //create Table Klanten
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS KLANTEN (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, STREET TEXT, POSTCODE TEXT, HUISNR TEXT, STAD TEXT, TELNR TEXT, MOBIEL TEXT)";
            sqlite3_exec(personDB, sql_stmt, NULL, NULL, &error);
            
            //create table devices
            const char *sec_sql_stmt = "CREATE TABLE IF NOT EXISTS DEVICES (ID INTEGER PRIMARY KEY AUTOINCREMENT, TYPE TEXT, MERK TEXT)";
            sqlite3_exec(personDB, sec_sql_stmt, NULL, NULL, &error);
            //create table for devices van klant
            const char *third_sql_stmt = "CREATE TABLE KLANTENDEVICES (KLANTID INTEGER, DEVICEID INTEGER, OS TEXT, INFO TEXT)";
            sqlite3_exec(personDB, third_sql_stmt,NULL, NULL, &error);
            
            //create table vor code examples
            const char *fourth_sql_stmt = "CREATE TABLE IF NOT EXISTS CODE (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT, CODE TEXT)";
            sqlite3_exec(personDB, fourth_sql_stmt,NULL, NULL, &error);
            
            
            
            sqlite3_close(personDB);
        }
    }
}

@end
