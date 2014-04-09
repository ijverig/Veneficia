//
//  Attack.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 30/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
#import "JSTileMap.h"

@class MagicPower;

@interface Attack : NSObject

+ (instancetype)shareAttackInstance;
- (MagicPower *)createFireAttackBy:(Character *)character;
- (MagicPower *)createWaterAttackBy:(Character *)character;

@end
