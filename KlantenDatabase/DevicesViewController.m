//
//  DevicesViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "DevicesViewController.h"
#import "AddDeviceViewController.h"

@interface DevicesViewController (){
NSMutableArray *devices;
sqlite3 *personDB;
NSString *dbPathString;

    


}
@end

@implementation DevicesViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	devices = [[NSMutableArray alloc]init];
    [[self mijnDevicesTable]setDelegate:self];
    [[self mijnDevicesTable]setDataSource:self];
    [self createOrOpenDB];

 //   [self fillSections];
    
    
    //plus button creëren 
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addDevice:)];
        self.navigationItem.rightBarButtonItem = addButton;
}
- (void)viewDidAppear:(BOOL)animated{
    [self fillTable];
    
}
/*
-(void)fillSections{
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        [devices removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT DISTINCT merk FROM DEVICES"];
        const char* query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {

                NSString *merk = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                
                

                
                NSLog(@"%@", merk);
                [sections addObject:merk];
            }
        }
    }

}

 */
 
 -(void)addDevice:(UIBarButtonItem *)sender{
    AddDeviceViewController *controller = (AddDeviceViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"addDeviceViewController"];
    
        
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
    
    return [devices count];
    
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
            Device *eenDevice = [devices objectAtIndex:indexPath.row];
    NSRange range = [eenDevice.merk rangeOfString:@"Apple" options:NSCaseInsensitiveSearch];
    
    if (range.location != NSNotFound)
    {
        NSRange iPhone3G= [eenDevice.type rangeOfString:@"iPhone 3G" options:NSCaseInsensitiveSearch];
        NSRange iPhone3GS= [eenDevice.type rangeOfString:@"iPhone 3GS" options:NSCaseInsensitiveSearch];
        NSRange iPhone4= [eenDevice.type rangeOfString:@"iPhone 4" options:NSCaseInsensitiveSearch];
        NSRange iPhone4S= [eenDevice.type rangeOfString:@"iPhone 4S" options:NSCaseInsensitiveSearch];
        NSRange iPhone5= [eenDevice.type rangeOfString:@"iPhone 5" options:NSCaseInsensitiveSearch];
        NSRange macBookPro= [eenDevice.type rangeOfString:@"MacBook Pro" options:NSCaseInsensitiveSearch];
        NSRange macBookAir= [eenDevice.type rangeOfString:@"MacBook Air" options:NSCaseInsensitiveSearch];
        NSRange iPad= [eenDevice.type rangeOfString:@"iPad" options:NSCaseInsensitiveSearch];
        NSRange appleTV= [eenDevice.type rangeOfString:@"Apple TV" options:NSCaseInsensitiveSearch];
        
        
               if(iPhone3G.location != NSNotFound || iPhone3GS.location != NSNotFound ){
            
            UIImage *image = [UIImage imageNamed:@"iPhones3G.png"];
            [cell.imageView setImage:image];
            
        } else if(iPhone4.location != NSNotFound || iPhone4S.location != NSNotFound ){
            
            UIImage *image = [UIImage imageNamed:@"iphone4.png"];
            [cell.imageView setImage:image];
            
        } else if(iPhone5.location != NSNotFound ){
            
            UIImage *image = [UIImage imageNamed:@"iphone5.png"];
            [cell.imageView setImage:image];
        }else if(macBookPro.location != NSNotFound ){
            
            UIImage *image = [UIImage imageNamed:@"MacBookPro.png"];
            [cell.imageView setImage:image];
        }else if(macBookAir.location != NSNotFound ){
            
            UIImage *image = [UIImage imageNamed:@"MacBookAir.png"];
            [cell.imageView setImage:image];
        }else if(iPad.location !=NSNotFound){
            NSRange iPad2= [eenDevice.type rangeOfString:@"iPad 2" options:NSCaseInsensitiveSearch];
            NSRange iPad3= [eenDevice.type rangeOfString:@"iPad 3" options:NSCaseInsensitiveSearch];
             NSRange iPad4= [eenDevice.type rangeOfString:@"iPad 4" options:NSCaseInsensitiveSearch];
            NSRange iPadMini= [eenDevice.type rangeOfString:@"iPad Mini" options:NSCaseInsensitiveSearch];
            
            if(iPad2.location != NSNotFound){
                
                UIImage *image = [UIImage imageNamed:@"iPad2.png"];
                [cell.imageView setImage:image];
                
            }else if(iPad3.location != NSNotFound || iPad4.location != NSNotFound ){
                
                UIImage *image = [UIImage imageNamed:@"NewiPad.png"];
                [cell.imageView setImage:image];
                
            }else if(iPadMini.location != NSNotFound){
                
                UIImage *image = [UIImage imageNamed:@"iPadMini.png"];
                [cell.imageView setImage:image];
                
            }else{
                UIImage *image = [UIImage imageNamed:@"iPad1.png"];
                [cell.imageView setImage:image];
                
            }

        }else if(appleTV.location !=NSNotFound){
            NSRange appleTV2= [eenDevice.type rangeOfString:@"Apple TV 2" options:NSCaseInsensitiveSearch];
            NSRange appleTV3= [eenDevice.type rangeOfString:@"Apple TV 3" options:NSCaseInsensitiveSearch];
                        
            if(appleTV2.location != NSNotFound || appleTV3.location != NSNotFound){
                
                UIImage *image = [UIImage imageNamed:@"AppleTV2.png"];
                [cell.imageView setImage:image];
                
            }else{
                UIImage *image = [UIImage imageNamed:@"AppleTV.png"];
                [cell.imageView setImage:image];
                
            
            }
        }

        
        
        
    }else{
        NSRange range = [eenDevice.merk rangeOfString:@"Samsung" options:NSCaseInsensitiveSearch];
        
        if (range.location != NSNotFound)
        {
            NSRange GalaxyS3= [eenDevice.type rangeOfString:@"Galaxy S3" options:NSCaseInsensitiveSearch];
            if(GalaxyS3.location != NSNotFound){
                
                UIImage *image = [UIImage imageNamed:@"GalaxyS3.png"];
                [cell.imageView setImage:image];
                
            }
            
        }else {
            
            NSRange laptop = [eenDevice.type rangeOfString:@"laptop" options:NSCaseInsensitiveSearch];
            NSRange desktop = [eenDevice.type rangeOfString:@"desktop" options:NSCaseInsensitiveSearch];
            
            if (laptop.location != NSNotFound)
            {
                
                
                UIImage *image = [UIImage imageNamed:@"laptop.png"];
                [cell.imageView setImage:image];
                
            }else   if (desktop.location != NSNotFound)
            {
                
                
                UIImage *image = [UIImage imageNamed:@"desktop.png"];
                [cell.imageView setImage:image];
                
            }
            
        }
        
        
    }
        NSString *labelString = [eenDevice.merk stringByAppendingString:@" - "];
        cell.textLabel.text = [labelString stringByAppendingString:eenDevice.type];
                    return cell;
}

- (void)fillTable{
  
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        [devices removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM DEVICES"];
        const char* query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSInteger ID = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] integerValue];
                NSString *type = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *merk = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                               
                
                Device *eenDevice= [[Device alloc]init];
                [eenDevice setID:ID];
                [eenDevice setType:type];
                [eenDevice setMerk:merk];
               
                
                
                [devices addObject:eenDevice];
            }
        }
    }
    
   [[self mijnDevicesTable]reloadData];
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

            Device *d = [devices objectAtIndex:indexPath.row];
            [self deleteData:[NSString stringWithFormat:@"Delete from devices where ID is '%i'", d.ID]];
            [devices removeObjectAtIndex:indexPath.row];
        
        }
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

-(void)deleteData:(NSString *)deleteQuery{
    char *error;
    
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        
    }
}



@end
