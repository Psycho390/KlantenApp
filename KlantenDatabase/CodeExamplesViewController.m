//
//  CodeExamplesViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 05-05-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "CodeExamplesViewController.h"
#import "viewCodeViewController.h"
#import "addCodeViewController.h"

@interface CodeExamplesViewController ()

@end

@implementation CodeExamplesViewController{

NSMutableArray *codes;
sqlite3 *personDB;
NSString *dbPathString;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self codeViewTable]setDataSource:self];
    [[self codeViewTable]setDelegate:self];
    [self createOrOpenDB];
    codes = [[NSMutableArray alloc]init];
   
    //plus button creëren
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addCode:)];
    
    self.navigationItem.rightBarButtonItem = addButton;

}
-(void)addCode:(UIBarButtonItem *)sender{
    addCodeViewController *controller = (addCodeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"addCodeViewController"];
    
    
    [self.navigationController  pushViewController:controller animated:YES];
    
    
}
- (void)viewDidAppear:(BOOL)animated{
        [self fillTable];
    
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
    
    return [codes count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    CodeExamples *eenCode = [codes objectAtIndex:indexPath.row];
    
 
    cell.textLabel.text =  [NSString stringWithFormat:@"%@", eenCode.title];
    return cell;
}


- (void)fillTable{

   
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        [codes removeAllObjects];
 
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM CODE"];
        const char* query_sql = [querySql UTF8String];
        
       if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
         
         
            while (sqlite3_step(statement)==SQLITE_ROW) {
              
                NSInteger ID = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] integerValue];
                
                
                NSString *title = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *code = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                
                CodeExamples *Code= [[CodeExamples alloc]init];
                
    
                
                [Code setID:ID];
                [Code setTitle:title];
                [Code setCode:code];
                
                
               
                
                
                [codes addObject:Code];
            }
        }
    }
    
    [[self codeViewTable]reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CodeExamples *codeExample = [codes objectAtIndex:indexPath.row];
    // Deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    viewCodeViewController *controller = (viewCodeViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"viewCodeViewController"];
    
    
    
    
    
    
    [self.navigationController  pushViewController:controller animated:YES];
    [[controller codeView] setText:codeExample.code];
    
    
    

    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CodeExamples *c = [codes objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"Delete from CODE where ID is '%i'", c.ID]];
        [codes removeObjectAtIndex:indexPath.row];
        
    }
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

-(void)deleteData:(NSString *)deleteQuery{
    char *error;
    
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        
    }
}



@end
