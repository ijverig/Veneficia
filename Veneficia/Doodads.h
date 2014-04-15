//
//  Doodads.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 11/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "player.h"
#import "JSTileMap.h"

// Create Immutable Objects in Field
// Bugigangas ou coisinhas

@interface Doodads : NSObject

@property(nonatomic) NSMutableArray *doodleObjects;

-(id) initWithMap:(JSTileMap*)map;
-(BOOL) zPosition:(Player*) player;

@end
