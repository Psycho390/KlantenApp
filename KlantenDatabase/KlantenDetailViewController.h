//
//  KlantenDetailViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Klant.h"
#import "Device.h"
#import "sqlite3.h"

@interface KlantenDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
NSMutableDictionary *selectedIndexes;
}
@property (nonatomic) Klant *klant;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) IBOutlet UITableView *allDevices;

@property (nonatomic) IBOutlet UITableView *devicesVanKlantTable;
- (void)AddButton:(Device *)device;


- (void)fillTable:(NSString *)ID;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)eenKlantToevoegen:(Klant *)persoon;
- (IBAction)addDeviceToPerson:(id)sender;
-(void)makeThisKlant:(Klant *)klant;
-(IBAction)addPic:(UIBarButtonItem *)sender;
- (IBAction)alterDevice:(id)sender;
- (IBAction)openAfspraakView:(id)sender;
-(UIImage*)resizeImage:(UIImage*)image withWidth:(int)width withHeight:(int)height;
@end
