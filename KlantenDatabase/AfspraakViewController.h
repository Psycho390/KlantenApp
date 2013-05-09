//
//  AfspraakViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 19-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Klant.h"
#import <EventKit/EventKit.h>

@interface AfspraakViewController : UIViewController
-(void)setMijnKlant:(Klant *)eenKlant;
@property (weak, nonatomic) IBOutlet UIDatePicker *choosePicker;



@property (weak, nonatomic) IBOutlet UITextView *notesField;
- (IBAction)hideKeyPad;


@end
