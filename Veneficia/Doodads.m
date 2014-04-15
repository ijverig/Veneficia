//
//  Doodads.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 11/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import "Doodads.h"
#import "Enumerator.h"

///////////////////////////////////////////
// REPRESENTA TODOS OBJETOS QUE NAO PODEM SER
// DESTRUIDOS DO JOGO, OBJECTOS NECESSITAM DE COLISÃO
// MUDANÇA ISOMETRICA

@interface Doodads ()

@property(nonatomic) JSTileMap *map;

@end



@implementation Doodads



-(id) initWithMap:(JSTileMap*)map
{
    self = [super init];
    if (self)
    {
        NSMutableArray *array = [[map groupNamed:@"Colision Layer"] objects];
        _doodleObjects = [[NSMutableArray alloc] init];
        
        int count = 0;
        for (NSDictionary *a in array)
        {
            SKSpriteNode *s = [[SKSpriteNode alloc] initWithColor:[UIColor redColor]
                                                             size:CGSizeMake([a[@"width"] integerValue],
                                                                             [a[@"height"] integerValue] )];
           
            s.position = CGPointMake([a[@"x"] integerValue] + ([a[@"width"] integerValue] * 0.5) ,
                                     [a[@"y"]integerValue] + ([a[@"height"] integerValue] * 0.5));
            s.name = [[NSString alloc] initWithFormat:@"WALL%d",count];
            [map addChild:s];
            s.zPosition = 0.0;
            s.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:s.size];
            s.physicsBody.categoryBitMask = DOODADS;
            s.physicsBody.collisionBitMask = GOOD_GUY | BAD_GUY | POWER;
            s.physicsBody.allowsRotation = NO;
            s.physicsBody.dynamic = NO;
            count++;
            [_doodleObjects addObject:s];
            
        }
    }
    return self;
}


/////////////////////////////////////////
// ESTA CLASSE PRECISA SER CHAMADA A TODO
// MOMENTO NA LOGICA DO PROGRAMA, POIS DETERMINA
// A POSIÇÃO Z DO PLAYER E DOS INIMIGOS


-(BOOL) zPosition:(Player*) player
{
    
    
    return NO;
}


@end
