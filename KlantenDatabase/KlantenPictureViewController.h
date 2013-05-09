//
//  KlantenPictureViewController.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 18-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Klant.h"

@interface KlantenPictureViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImagePickerController *picker;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *sc;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)CameraOfRoll;
-(void)setMijnKlant:(Klant *)klant;
@end
