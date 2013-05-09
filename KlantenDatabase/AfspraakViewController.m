//
//  AfspraakViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 19-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//
#import "AfspraakViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AfspraakViewController (){
    
}
@property (nonatomic) Klant *klant;

@end

@implementation AfspraakViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
  
    
    self.notesField.layer.cornerRadius = 5.0;
    //plus button creëren
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(saveEvent)];
    UIBarButtonItem *hideButton = [[UIBarButtonItem alloc]initWithTitle:@"hide keyboard" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyPad)];
     
    self.navigationItem.rightBarButtonItems = @[addButton, hideButton];
    
    

	
}

-(void)setMijnKlant:(Klant *)eenKlant{
    self.klant = eenKlant;
}

-(void)saveEvent{
    NSString *adres = [self.klant.straat stringByAppendingString:[@" " stringByAppendingString:[self.klant.huisnr stringByAppendingString:[@" " stringByAppendingString:self.klant.stad]]]];
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    // display error message here
                }
                else if (!granted)
                {
                    // display access denied error message here
                }
                else
                {
                    
                    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                    
                    
                        event.calendar  = [eventStore defaultCalendarForNewEvents];
                        NSLog(@"Calendar Existed");
                
                
                    event.title     = [self.klant.naam stringByAppendingString:@" afspraak!"];
                    event.location  = adres;
                    event.notes     = self.notesField.text;
                    event.startDate = self.choosePicker.date;
                    event.endDate   = [NSDate dateWithTimeInterval:60*60*3 sinceDate:event.startDate];
                    event.allDay    = NO;
                    EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-3600]; // Hour Before
                    event.alarms = [NSArray arrayWithObject:alarm];
                    
                    [eventStore saveEvent:event span:EKSpanThisEvent error:nil];
                    UIAlertView *alertSave = [[UIAlertView alloc] initWithTitle:nil     message:@"Afspraak toegevoegd!"
                                                                     delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
                                            
                                            
                [alertSave show];
                    
                    
                }
            });
        }];
    }
    else
    {
        // do the important stuff here
    }

}

- (IBAction)hideKeyPad {
    [self.notesField resignFirstResponder];
    
}


@end
