//
//  KlantenViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "KlantenViewController.h"
#import "KlantenDetailViewController.h"
#import "AddKlantViewController.h"



@interface KlantenViewController (){
     NSMutableArray *klanten;
    sqlite3 *personDB;
    NSString *dbPathString;
   
}

@end

@implementation KlantenViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	 klanten = [[NSMutableArray alloc]init];
    [[self mijnKlantenTable]setDelegate:self];
    [[self mijnKlantenTable]setDataSource:self];
   [self createOrOpenDB];
   
    //plus button creëren
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addKlant:)];

    self.navigationItem.rightBarButtonItem = addButton;

    


}
- (void)viewDidAppear:(BOOL)animated{
    [self fillTable];
    
}

-(void)addKlant:(UIBarButtonItem *)sender{
    AddKlantViewController *controller = (AddKlantViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddKlantViewController"];
    
    
    [self.navigationController  pushViewController:controller animated:YES];

    
}





- (void)createOrOpenDB{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"klanten.db"];
    
   
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
               
        
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return [klanten count];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
           Klant *eenKlant = [klanten objectAtIndex:indexPath.row];
        // Deselect row
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        KlantenDetailViewController *controller = (KlantenDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"klantenDetail"];
    
        
        
        
        
        
        [self.navigationController  pushViewController:controller animated:YES];
    [controller eenKlantToevoegen:eenKlant];
         
    
    
    
    

    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
           }
    
        
       Klant *eenKlant = [klanten objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", eenKlant.naam];
 
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
        
        
    
    return cell;
}
- (void)fillTable {
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        [klanten removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM KLANTEN"];
        const char* query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSInteger ID = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] integerValue];
                NSString *naam = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *straat = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *postcode = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *huisnr = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *Stad = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *TelNr = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                NSString *Mobiel = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                
                
                Klant *person = [[Klant alloc]init];
                [person setID:ID];
                [person setNaam:naam];
                [person setStraat:straat];
                [person setPostcode:postcode];
                [person setHuisnr:huisnr];
                [person setStad:Stad];
                [person setTelnr:TelNr];
                [person setMobiel:Mobiel];
                
                
                
                
                [klanten addObject:person];
            }
        }
    }
    [[self mijnKlantenTable]reloadData];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
            Klant *k = [klanten objectAtIndex:indexPath.row];
            [self deleteData:[NSString stringWithFormat:@"Delete from klanten where id is '%i'", k.ID]];
            [klanten removeObjectAtIndex:indexPath.row];
 
        }
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

-(void)deleteData:(NSString *)deleteQuery{
    char *error;
    
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        
    }
}


@end
