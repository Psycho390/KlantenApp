//
//  Button.m
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 22-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import "Button.h"
#import <QuartzCore/QuartzCore.h>

@implementation Button

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CAGradientLayer *btnGradient;
    btnGradient.frame = self.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                          (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                          nil];
    [self.layer insertSublayer:btnGradient atIndex:0];
    
    
    
}


@end
