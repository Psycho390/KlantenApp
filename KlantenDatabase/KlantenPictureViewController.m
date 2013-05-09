//
//  KlantenPictureViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 18-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "KlantenPictureViewController.h"


@interface KlantenPictureViewController (){
 UIImage *image1;
   
}
@property (nonatomic) Klant *eenKlant;
@end

@implementation KlantenPictureViewController
@synthesize eenKlant;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.sc.selectedSegmentIndex = -1;
    
    //plus button creëren
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                 target:self action:@selector(addPic:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
}
-(void)addPic:(UIBarButtonItem *)sender{
    NSString *fileName = [[NSString stringWithFormat:@"%i", self.eenKlant.ID] stringByAppendingString:@".png"];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSData * binaryImageData = UIImagePNGRepresentation(image1);
    
    [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:fileName] atomically:YES];
    UIAlertView* alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Toevoegen van Image gelukt!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}
-(void)setMijnKlant:(Klant *)klant{
    self.eenKlant = klant;
    
}


- (void)showPic {
    if(image1){
        CGRect frame = [self.imageView frame];
        CGFloat newWidth = 100;
        CGFloat newHeight = newWidth * image1.size.height / image1.size.width;
        frame.size.width = newWidth;
        frame.size.height = newHeight;
        [self.imageView setFrame:frame];
        
        [self.imageView setImage:image1];
        self.sc.selectedSegmentIndex = 1;
        self.sc.selectedSegmentIndex = -1;
        
    }
}
-(IBAction)CameraOfRoll{
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    
    if(self.sc.selectedSegmentIndex==0){
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        
        
    }else if(self.sc.selectedSegmentIndex == 1){
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        
        
    }
     
    [self presentViewController:picker animated:YES completion: nil];
    self.sc.selectedSegmentIndex = -1;
    

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
        [self showPic];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
            
    [self showPic];
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
