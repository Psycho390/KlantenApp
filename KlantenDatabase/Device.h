//
//  Device.h
//  KlantenDatabase
//
//  Created by Nicolas Alexander van der Boor on 16-04-13.
//  Copyright (c) 2013 Nicolas Alexander van der Boor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject

@property (nonatomic) NSInteger ID;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *merk;
@property (nonatomic, strong) NSString *os;
@property (nonatomic, strong) NSString *info;

@end
