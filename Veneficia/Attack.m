//
//  Attack.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 30/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Attack.h"
#import "MagicPower.h"
#import "Enumerator.h"

@implementation Attack

#pragma mark - Singleton

+ (instancetype)shareAttackInstance
{
    static Attack *attack = nil;
    static dispatch_once_t onceToken=0;
    dispatch_once(&onceToken,
    ^{
        attack = [[super allocWithZone:nil] init];
    });
    
    return attack;
}


+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self shareAttackInstance];
}

- (SKEmitterNode *)createFireAttackBy:(Character *)character;
{
    NSString *fireRayPath = [[NSBundle mainBundle] pathForResource:@"FireRay" ofType:@"sks"];
    SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:fireRayPath];
    fire.name = @"FIRE";
//    fire.sourcePlayer = [character.name copy];
//    fire.damage = character.attack;
    //fire.userData
    
    fire.particlePosition  = character.position;
    [self direction:character.direction ofAttack:fire andRange:1000 andAngle:character.directionAngle];
    return fire;
}

- (SKEmitterNode *)createWaterAttackBy:(Character *)character;
{
    NSString *waterPath = [[NSBundle mainBundle] pathForResource:@"Water" ofType:@"sks"];
    SKEmitterNode *water = [NSKeyedUnarchiver unarchiveObjectWithFile:waterPath];
    water.name = @"WATER";
//    water.sourcePlayer = @"opa";
//    NSLog(@"Name: %@ %@", character.name, water.sourcePlayer);
   
//    water.sourcePlayer = [character.name mutableCopy];
//    water.damage = character.attack;
    
    
    
    
    water.particlePosition  = character.position;
    [self direction:character.direction ofAttack:water andRange:1000 andAngle:character.directionAngle];
    
    return water;
}

//
// CONFIGURE THE SPELL
// DIRECTION IS THE PLACE WHERE THE CHAR IS LOOKING AT
// POWER IS THE SPELL
// RANGE IS HOW FAR THE MAGIC REACHES
//

- (void)direction:(NSInteger)direction ofAttack:(SKEmitterNode *)power andRange:(float)range andAngle: (float)angle
{
    float sinn, coss;
    
    // Correct the angle
    angle = angle / 180.0 * M_PI;
    
    // Set the sin and the cos
    sinn = sinf(angle);
    coss = cosf(angle);
    
    // Set the emission angle
    power.emissionAngle = angle + M_PI;
    [power runAction:[SKAction sequence:@[[SKAction moveByX:coss * range y:sinn * range duration:1.0],
                                          [SKAction removeFromParent]]]];
}

@end
