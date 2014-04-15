//
//  Horde.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 11/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSTileMap.h"
#import "Player.h"

@interface Horde : NSObject

@property(nonatomic) NSMutableArray *hordeEnemies;


// Inicializer
-(id) initHordeNumEnemies:(NSInteger)num inMap:(JSTileMap*)map;


// Methods
-(void) logicHorder:(Player*) player;
-(NSInteger) containsEnemy;

@end
