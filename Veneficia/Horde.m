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
#import "Attack.h"


@interface Horde ()

@property(nonatomic) JSTileMap *map;
@property(nonatomic) Attack *attack;

@end

@implementation Horde


-(id) initHordeNumEnemies:(NSInteger)num inMap:(JSTileMap*)map
{
    self = [super init];
    if (self)
    {
        self.map = map;
        self.attack = [Attack shareAttackInstance];
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
                            life:2000
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
            enemy.physicsBody.usesPreciseCollisionDetection = YES;
            [_hordeEnemies addObject:enemy];
        }
        
    }
    return self;
}

-(void) logicHorder:(Player*) player
{
  /*
    Player *temp = nil;
    for (Player *p in self.hordeEnemies)
    {
        if (![p isAlive])
        {
            temp = p;
            break;
        }
    }
    
    if (temp != nil)
    {
        [self.hordeEnemies removeObject:temp];
        [temp removeFromParent];
    }
*/    
    
    for (Player *p in self.hordeEnemies)
    {
        int aleatorio = arc4random_uniform(50);
       // float distance = [self distanceBetweenPlayer:player andEnemy:p];
      //   float angle = player.directionAngle;
        
        if (aleatorio > 0 && aleatorio  < 10)
        {
            [p movePlayer:CGPointMake( -.4,  .1)];
        }else if ( aleatorio >= 10 && aleatorio < 20){
            [p movePlayer:CGPointMake( .1,  .4)];
        }else if ( aleatorio >= 20 && aleatorio < 30 ){
            [p movePlayer:CGPointMake( .4,  0)];
        }else if( aleatorio >= 30 && aleatorio < 40 ){
            [p movePlayer:CGPointMake( -0.1,  -.4)];
        }else if ( aleatorio > 45 ){
            self.attack = [Attack shareAttackInstance];
            SKNode *node = [self.attack createAttackBy:p andPower:@"FIRE"];
            node.userData = [[NSMutableDictionary alloc] init];
            [node.userData setValue:@"50" forKey:@"damage"];
            node.name = @"FIRE";
            node.zPosition = -101.0;
            node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)];
            node.physicsBody.categoryBitMask = POWER;
            node.physicsBody.contactTestBitMask = GOOD_GUY | DOODADS ;
            node.physicsBody.collisionBitMask =  GOOD_GUY | DOODADS ;
            node.physicsBody.allowsRotation = NO;
            
            [self.map addChild:node];
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
