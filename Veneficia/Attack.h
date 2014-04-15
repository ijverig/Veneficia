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

@property(nonatomic) JSTileMap *map;

+ (instancetype)shareAttackInstance;
- (SKEmitterNode *)createAttackBy:(Character *)character andPower:(NSString *)power;

@end
