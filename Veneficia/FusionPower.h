//
//  FusionPower.h
//  Veneficus
//
//  Created by Rodrigo Leite on 03/04/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicPower.h"

@interface FusionPower : NSObject

//Contrutor
- (id)initWithSizeofScreen:(CGSize)size andMap:(SKNode*)map;
-(void) addPower:(SKNode*) powerName;
-(SKNode*) shotPower;
-(NSMutableArray*) showPower;

@end
