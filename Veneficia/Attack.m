//
//  Attack.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 30/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

// Maybe this class need to ber a singleton

#import "Attack.h"
#import "MagicPower.h"

@implementation Attack

#pragma mark - Singleton
+(instancetype)shareAttackInstance
{
    static Attack *attack = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken, ^{
        attack = [[super allocWithZone:nil] init];
    });
    return attack;
}


+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self shareAttackInstance];
}



-(MagicPower*) createFireAttackBy:(Character*) character;
{
    NSString *fireRayPath = [[NSBundle mainBundle] pathForResource:@"FireRay" ofType:@"sks"];
    MagicPower *fire = (MagicPower*) [NSKeyedUnarchiver unarchiveObjectWithFile:fireRayPath];
//    fire.name = @"FIRE";
//    fire.sourcePlayer = [character.name copy];
 //   fire.damage = character.attack;
    fire.position  = character.position;
    [self direction:character.direction ofAttack:fire andRange:1000];
    return fire;
    
}
-(MagicPower*) createWaterAttackBy:(Character*) character;
{
    NSString *waterPath = [[NSBundle mainBundle] pathForResource:@"Water" ofType:@"sks"];
    SKNode *node = (SKNode *)[NSKeyedUnarchiver unarchiveObjectWithFile:waterPath];
    MagicPower *water = (MagicPower *) node;//[NSKeyedUnarchiver unarchiveObjectWithFile:waterPath];
    water.name = @"WATER";
 //   water.sourcePlayer = @"opa";
  //  NSLog(@"Name: %@ %@",character.name, water.sourcePlayer);
   
 //   water.sourcePlayer = [character.name mutableCopy];
 //   water.damage = character.attack;
    water.position  = character.position;
    [self direction:character.direction ofAttack:water andRange:1000];
    
    return water;
}

//////////////////////////////////////////
// CONFIGURE THE SPELL
// DIRECTION IS THE PLACE WHERE THE CHAR IS LOOKAT
// POWER IS THE SPELL
// RANGE HOW LONG THE MAGIC GO

-(void)direction:(NSInteger)direction ofAttack:(MagicPower*)power andRange:(float)range 
{
    switch (direction) {
        case UP:
            power.emissionAngle = -M_PI/2;
            [power runAction:[SKAction sequence:@[[SKAction moveToY:range duration:1.0],
                                                  [SKAction removeFromParent]]]];
            break;
        case DOWN:
            power.emissionAngle = M_PI/2;
            [power runAction:[SKAction sequence:@[[SKAction moveToY:range duration:1.0],
                                                  [SKAction removeFromParent]]]];
            break;
      
        case LEFT:
            power.emissionAngle = 0;
            [power runAction:[SKAction sequence:@[ [SKAction moveToX:-range duration:1.0],
                                                   [SKAction removeFromParent]]]];
            break;

        case RIGHT:
            [power runAction:[SKAction sequence:@[[SKAction moveToX:range duration:1.0],
                                                         [SKAction removeFromParent]]]];
            
            break;
            
        // DIGONALS
        case UP_LEFT:
            [power runAction:[SKAction sequence:@[[SKAction moveByX:-range y:-range duration:1.0],
                                                  [SKAction removeFromParent]]]];
            
            break;
            
        case UP_RIGHT:
            break;
            
            
        case DOWN_RIGHT:
            break;
            
        case DOWN_LEFT:
            break;
            
            
            
    }
}


@end
