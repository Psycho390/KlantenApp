//
//  KlantenDetailViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "KlantenDetailViewController.h"
#import "KlantenPictureViewController.h"
#import "AfspraakViewController.h"
#import "AddKlantViewController.h"

@interface KlantenDetailViewController (){
    NSMutableArray *devicesVanKlant;
    NSMutableArray *devices;
    sqlite3 *personDB;
    NSString *dbPathString;
    NSString *entryText;
    Klant *thisKlant;
    Device *selectedDevice;
    NSString *nieuwID;
    UITextField *myTextField;
 
    
}
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath;
@property (nonatomic) BOOL osFilled;
@property (nonatomic) BOOL alter;
@property (nonatomic) BOOL selected;
@property (nonatomic) NSString *OSKlant;
@property (nonatomic) NSString *InfoKlant;


@end

@implementation KlantenDetailViewController
#define kCellHeight 50.0



- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    devicesVanKlant = [[NSMutableArray alloc]init];
    thisKlant = [[Klant alloc]init];
    self.selected = NO;
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 45, 260, 25)];
      selectedDevice = [[Device alloc]init];
    [[self devicesVanKlantTable]setDelegate:self];
    [[self devicesVanKlantTable]setDataSource:self];
    devices = [[NSMutableArray alloc]init];
    [[self allDevices]setDelegate:self];
    [[self allDevices]setDataSource:self];
    
    [self createOrOpenDB];
    [self fillAllDevicesTable];
    //plus button creëren
    UIBarButtonItem *alterButton = [[UIBarButtonItem alloc] initWithTitle:@"alter" style:UIBarButtonItemStylePlain
                                                                   target:self action:@selector(alterKlant:)];
    
    self.navigationItem.rightBarButtonItem = alterButton;


    

	selectedIndexes = [[NSMutableDictionary alloc] init];
}
-(void)alterKlant:(UIBarButtonItem *)sender{
    AddKlantViewController *controller = (AddKlantViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddKlantViewController"];
    
    
    [self.navigationController  pushViewController:controller animated:YES];
    controller.alter = YES;
    
    [controller setKlantToAlter:thisKlant];
    
    
    
    
}
- (void)viewDidUnload {
	
	selectedIndexes = nil;
	
	[super viewDidUnload];
}

- (UIImage*)loadImage{
    NSString *fileLocation = [[NSString stringWithFormat:@"%i", thisKlant.ID] stringByAppendingString:@".png"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                       fileLocation ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}
-(void)addPic:(UIBarButtonItem *)sender{
    KlantenPictureViewController *controller = (KlantenPictureViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"KlantenPictureViewController"];
    
    
    [self.navigationController  pushViewController:controller animated:YES];
    
    [controller setMijnKlant:thisKlant];
}
- (IBAction)alterDevice:(id)sender {
    self.alter = YES;
    if(self.selected){
        myTextField.text = selectedDevice.os;
        nieuwID = [NSString stringWithFormat:@"%i", thisKlant.ID];
    UIAlertView *alertOS = [[UIAlertView alloc] initWithTitle:@"Enter OS:"     message:@"this gets covered!"
                                                     delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK!", nil];
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
    [alertOS setTransform:myTransform];
    
    
    //Give the text field some unique tag
    [myTextField setTag:10250];
    
    
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    
    [alertOS addSubview:myTextField];
    
    [alertOS show];
    }


}

- (IBAction)openAfspraakView:(id)sender {
    AfspraakViewController *controller = (AfspraakViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"AfspraakViewController"];
    
    [self.navigationController  pushViewController:controller animated:YES];
    
    [controller setMijnKlant:thisKlant];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // If our cell is selected, return double height
    if([self cellIsSelected:indexPath]) {
        
        Device *eenDevice = [devicesVanKlant objectAtIndex:indexPath.row];
        if(eenDevice.info.length >10 && eenDevice.info.length <70){
        
        return kCellHeight * 2.5;
            
        }else if (eenDevice.info.length >70 && eenDevice.info.length <200){
            return kCellHeight * 4;
        }
    }
    // Cell isn't selected so return single height
    return kCellHeight;
}
- (void)layoutSubviews {

    
}
-(void)makeThisKlant:(NSString *)klantID{
    nieuwID = klantID;
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [segue.destinationViewController makeThisKlant: [NSString stringWithFormat:@"%i", thisKlant.ID]];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self.navigationItem setTitle:thisKlant.naam];
    [self fillTable:[NSString stringWithFormat:@"%i", thisKlant.ID]];
    self.textView.text = [NSString stringWithFormat:@"Naam:   %@ \nAdres:   %@ %@\n              %@ %@\nTelnr:     %@\nMobiel:  %@",thisKlant.naam, thisKlant.straat, thisKlant.huisnr, thisKlant.postcode, thisKlant.stad, thisKlant.telnr, thisKlant.mobiel];
    if([self loadImage]){
    CGRect frame = [self.imageView frame];
    CGFloat newWidth = 87;
    CGFloat newHeight = newWidth * [self loadImage].size.height / [self loadImage].size.width;
    frame.size.width = newWidth;
    frame.size.height = newHeight;
    [self.imageView setFrame:frame];
    }
    [self.imageView setImage:[self loadImage]];
    
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
    if([self.allDevices isEqual:tableView]){
        return [devices count];
    }else{
        
        return [devicesVanKlant count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];


    }

    Device *eenDevice;
    if([self.allDevices isEqual:tableView]){
        eenDevice = [devices objectAtIndex:indexPath.row];
        
        
    }else{
        eenDevice = [devicesVanKlant objectAtIndex:indexPath.row];
        NSString *detailLabelString = [eenDevice.os stringByAppendingString:@" - "];
        cell.detailTextLabel.text = [detailLabelString stringByAppendingString:eenDevice.info];
    }

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
                
                UIImage *image =[UIImage imageNamed:@"iPadMini.png"];
                [cell.imageView setImage:image];
                
            }else{
                UIImage *image =[UIImage imageNamed:@"iPad1.png"];
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
                
                UIImage *image =[UIImage imageNamed:@"GalaxyS3.png"];
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
                
                
                UIImage *image =[UIImage imageNamed:@"desktop.png"];
                [cell.imageView setImage:image];
                
            }
            
        }
        
        
    }
    if([self.devicesVanKlantTable isEqual:tableView]){
    [cell.imageView setImage:[self resizeImage:cell.imageView.image withWidth:50 withHeight:50]];
    }
    NSString *labelString = [eenDevice.merk stringByAppendingString:@" - "];
    cell.textLabel.text = [labelString stringByAppendingString:eenDevice.type];

    return cell;
}
-(UIImage*)resizeImage:(UIImage*)image withWidth:(int)width withHeight:(int)height
{
    CGSize newSize = CGSizeMake(width, height);
    float widthRatio = newSize.width/image.size.width;
    float heightRatio = newSize.height/image.size.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    }
    else
    {
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if([self.devicesVanKlantTable isEqual:tableView]){
        selectedDevice = [devicesVanKlant objectAtIndex:indexPath.row];
    }else{
    
    selectedDevice = [devices objectAtIndex:indexPath.row];
    }
   
    self.selected = YES;
    

    
    
	// Toggle 'selected' state
	BOOL isSelected = ![self cellIsSelected:indexPath];
	
	// Store cell 'selected' state keyed on indexPath
	NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
	[selectedIndexes setObject:selectedIndex forKey:indexPath];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if([self cellIsSelected:indexPath]){
    [cell.detailTextLabel setLineBreakMode: NSLineBreakByWordWrapping];
    cell.detailTextLabel.numberOfLines = 0;
    }else{
      cell.detailTextLabel.numberOfLines = 1;
    }
	// This is where magic happens...
	[self.devicesVanKlantTable beginUpdates];
    
	[self.devicesVanKlantTable endUpdates];

    


}


- (void)fillAllDevicesTable{
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
    
    [[self allDevices]reloadData];
    
    
}
-(Device *)fillMyTableWithDevice:(NSString *)ID{
    
    sqlite3_stmt *statementDevice;
    Device *eenDevice= [[Device alloc]init];
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM DEVICES WHERE ID ='%@'", ID];
        const char* query_sql = [querySql UTF8String];
        if (sqlite3_prepare(personDB, query_sql, -1, &statementDevice, NULL)==SQLITE_OK) {
            while(sqlite3_step(statementDevice)==SQLITE_ROW) {
                NSInteger dId = [[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statementDevice, 0)] integerValue];
                NSString *dType= [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statementDevice, 1)];
                NSString *dMerk= [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statementDevice, 2)];
                                
                
                
                [eenDevice setID:dId];
                [eenDevice setType:dType];
                [eenDevice setMerk:dMerk];

                
                
                
                
                
            }
        }
    }
return eenDevice;
}
- (void)fillTable:(NSString *)ID{
    
    sqlite3_stmt *statement;
    
    [devicesVanKlant removeAllObjects];
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM KLANTENDEVICES WHERE KLANTID ='%@'", ID];
        const char* query_sql = [querySql UTF8String];
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while(sqlite3_step(statement)==SQLITE_ROW) {
                NSString *dID= [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *os = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *info = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                
                
                Device *addDevice  = [self fillMyTableWithDevice:dID];
                [addDevice setOs:os];
                [addDevice setInfo:info];
                [devicesVanKlant addObject:addDevice];
            }
        }
    }
    [[self devicesVanKlantTable]reloadData];
    
}
-(void)eenKlantToevoegen:(Klant *)persoon{
    thisKlant = persoon;
    
}
- (IBAction)addDeviceToPerson:(id)sender {
    UIAlertView *alertOS = [[UIAlertView alloc] initWithTitle:@"Enter OS:"     message:@"this gets covered!"
                                                     delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK!", nil];
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
    [alertOS setTransform:myTransform];
    
    
    //Give the text field some unique tag
    [myTextField setTag:10250];
    
    
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    
    [alertOS addSubview:myTextField];
    
    [alertOS show];
   
}
-(void)alertIT{
    UIAlertView *alertInfo = [[UIAlertView alloc] initWithTitle:@"Enter Info:"     message:@"this gets covered!"
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK!", nil];
        CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
  
    [alertInfo setTransform:myTransform];
      if(self.alter){
          myTextField.text = selectedDevice.info;
      
      }else{
        myTextField.text = @"";}
    [myTextField setTag:10250];
 [alertInfo addSubview:myTextField];
     [alertInfo show];
}
- (void)AddButton:(Device *)device {
    NSString *klantID =nieuwID;
    NSString *deviceID = [NSString stringWithFormat:@"%i", device.ID];
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *inserStmt =[NSString stringWithFormat:@"INSERT INTO KLANTENDEVICES(KLANTID, DEVICEID, OS, INFO) values ('%s', '%s', '%s', '%s' )",[klantID UTF8String], [deviceID UTF8String], [self.OSKlant UTF8String], [self.InfoKlant UTF8String]];
        
        const char *insert_stmt = [inserStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
            
            
        }
        sqlite3_close(personDB);
    }

    [self fillMyTableWithDevice:deviceID];
    
    
    
    
}
- (void)AlterButton:(Device *)device {
    NSString *klantID =nieuwID;
    NSString *deviceID = [NSString stringWithFormat:@"%i", device.ID];

    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)==SQLITE_OK) {
        NSString *inserStmt =[NSString stringWithFormat:@"UPDATE KLANTENDEVICES SET OS = '%s' , INFO = '%s' WHERE KLANTID = '%s' AND DEVICEID = '%s'",[self.OSKlant UTF8String], [self.InfoKlant UTF8String],[klantID UTF8String], [deviceID UTF8String] ];
        
        const char *insert_stmt = [inserStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
            
            
        }
        sqlite3_close(personDB);
    }
    
  
    [self fillTable:[NSString stringWithFormat:@"%i", thisKlant.ID]];
    self.alter = NO;
    
    
}
-(void)deleteData:(NSString *)deleteQuery{
    char *error;
    
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.allDevices isEqual:tableView]){
        UIAlertView* alert;
        
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot delete devices here!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    else{
        
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            Device *d = [devicesVanKlant objectAtIndex:indexPath.row];
            
            
            [self deleteData:[NSString stringWithFormat:@"Delete from klantendevices where klantid is '%i' AND deviceid is '%i'",thisKlant.ID, d.ID ]];
            [devicesVanKlant removeObjectAtIndex:indexPath.row];
            
            
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
    
}
- (void)didPresentAlertView:(UIAlertView *)alertView {
    
    [myTextField becomeFirstResponder];
}
- (void) alertView:(UIAlertView *) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField* myField = (UITextField*)[actionSheet viewWithTag:10250];

    
    if(self.osFilled){
        
        self.InfoKlant= myField.text;
        
        self.osFilled = NO;
        if(self.alter){
           
            [self AlterButton:selectedDevice];
            
        }else{
        
            if(self.selected){
                [self AddButton:selectedDevice];
            }else {
                NSLog(@"no device");
            }
        }
    }else{
        
        self.OSKlant = myField.text;
        self.osFilled = YES;
      
            [self alertIT];
        
    }
    
}


@end
