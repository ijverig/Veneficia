//
//  FusionPower.h
//  Veneficia
//
//  Created by Rodrigo Leite on 03/04/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MagicPower.h"
#import "Attack.h"
#import "Player.h"

@interface FusionPower : NSObject

- (id)initWithSizeofScreen:(CGSize)size andMap:(SKNode *)map;
- (void)addPower:(NSString *)powerName;
- (SKNode *)shotPower:(Player *) player;
- (NSMutableArray *)showPower;

@end
