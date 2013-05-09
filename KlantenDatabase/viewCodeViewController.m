//
//  viewCodeViewController.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 05-05-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "viewCodeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface viewCodeViewController ()

@end

@implementation viewCodeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    
        
}
-(void)viewDidAppear:(BOOL)animated{
    self.codeView.contentSize = CGSizeMake(10000, self.codeView.contentSize.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
