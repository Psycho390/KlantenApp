//
//  Klant.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Klant : NSObject
@property (nonatomic) NSInteger ID;

@property (nonatomic, strong) NSString *naam;
@property (nonatomic, strong) NSString *straat;
@property (nonatomic, strong) NSString *huisnr;
@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) NSString *stad;
@property (nonatomic, strong) NSString *telnr;
@property (nonatomic, strong) NSString *mobiel;
@end
