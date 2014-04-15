//
//  Horde.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 11/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

// CLASSE RESPONSÁVEL POR CRIAR INIMIGOS
// E GERENCIAR SUA LOGICA


#import "Horde.h"
#import "Player.h"
#import "JSTileMap.h"
#import "Enumerator.h"

@interface Horde ()

@property(nonatomic) JSTileMap *map;

@end

@implementation Horde


-(id) initHordeNumEnemies:(NSInteger)num inMap:(JSTileMap*)map
{
    self = [super init];
    if (self)
    {
        self.map = map;
        _hordeEnemies = [[NSMutableArray alloc] init];
        CGRect mapBounds = [map calculateAccumulatedFrame];
        NSString *name = @"Enemy";
        for(int i = 0; i < num ; i++)
        {
           Player *enemy = [[Player alloc]
                            initWithPosition:CGPointMake(mapBounds.size.width  / 2 + 200 * (i + 1),
                                                         mapBounds.size.height / 2 + 200 * (i + 1))
                                        name:[[NSString alloc] initWithFormat:@"%@%d",name,i]
                                   direction:DOWN
                            life:1000
                            velocity:10
                            attack:100
                            defense:100
                            atlasName:@"bird"
                            size:CGSizeMake(80, 80)];
            
            [self.map addChild:enemy];
            enemy.zPosition = -101.0;
            enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemy.size];
            enemy.physicsBody.categoryBitMask = BAD_GUY;
            enemy.physicsBody.contactTestBitMask = GOOD_GUY |DOODADS | POWER;
            enemy.physicsBody.collisionBitMask = GOOD_GUY | DOODADS | POWER;
            enemy.physicsBody.allowsRotation = NO;
            [_hordeEnemies addObject:enemy];
        }
        
    }
    return self;
}

-(void) logicHorder:(Player*) player
{
    for (Player *p in self.hordeEnemies)
    {
        float distance = [self distanceBetweenPlayer:player andEnemy:p];
        NSLog(@"Distance: %f",distance);
        NSLog(@" %f", player.position.x / [self.map calculateAccumulatedFrame].size.width );
        // Run From Player
        if (distance < 300)
        {
            if (player.direction == LEFT)
            {
                [p movePlayer:CGPointMake(- 0.1, .04)];
            }else if (player.direction == RIGHT)
            {
                [p movePlayer:CGPointMake( 0.1, .04)];
            }else if (player.direction == UP || player.direction == UP_LEFT || player.direction == UP_RIGHT)
            {
                [p movePlayer:CGPointMake( 0.1, -0.4)];
            }else if (player.direction == DOWN || player.direction == DOWN_LEFT || player.direction == DOWN_RIGHT)
            {
                [p movePlayer:CGPointMake( -0.1, .4)];
            }
        }
        
        // Enemy Attack
        if (distance >= 300 && distance < 450)
        {
            
            
        }
        
        // Persuit Enemy
        if (distance > 450)
        {
            
            
            CGPoint derivatePoint = CGPointMake( (player.position.x - p.position.x) / 100, (player.position.y - p.position.y) / 100 );
            [p runAction:[SKAction moveTo:derivatePoint duration:1.0]];
            

            
            
            
//            if (player.direction == LEFT)
//            {
//                [p movePlayer:CGPointMake( -0.4, .1)];
//            }else if (player.direction == RIGHT)
//            {
//                [p movePlayer:CGPointMake( 0.1, .04)];
//            }else if (player.direction == UP || player.direction == UP_LEFT || player.direction == UP_RIGHT)
//            {
//                [p movePlayer:CGPointMake( 0.1, -0.4)];
//            }else if (player.direction == DOWN || player.direction == DOWN_LEFT || player.direction == DOWN_RIGHT)
//            {
//                [p movePlayer:CGPointMake( -0.1, .4)];
//            }
            
        }
        
        
    }
    
    
}

/////////////////////////////////////
// Distancia entre dois players
-(float) distanceBetweenPlayer:(Player*)player andEnemy:(Player*)enemy
{
    float xDistance =  ABS( player.position.x - enemy.position.x );
    float yDistance =  ABS( player.position.y - enemy.position.y );
    return sqrtf( powf(xDistance, 2) + powf(yDistance, 2) );
}

/////////////////////////////////
// Diz quantos inimigos há na horda
-(NSInteger) containsEnemy
{
    return [_hordeEnemies count];
}


@end
