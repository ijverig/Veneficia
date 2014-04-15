//
//  Attack.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 30/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Attack.h"
#import "MagicPower.h"

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

- (SKNode *)createAttackBy:(Character *)character andPower:(NSString *)power
{
    NSString *elementPath = [[NSBundle mainBundle] pathForResource:power ofType:@"sks"];
    SKEmitterNode *attack = [NSKeyedUnarchiver unarchiveObjectWithFile:elementPath];
    
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor:[UIColor clearColor] size:CGSizeMake(10, 10)];
    [node addChild:attack];
    attack.name = power;
    
//    fire.sourcePlayer = [character.name copy];
//    fire.damage = character.attack;
    //fire.userData

//    attack.particlePosition  = character.position;
    node.position = character.position;
    [self direction:character.direction ofAttack:node andRange:1000 andAngle:character.directionAngle];
   
    
    return node;
}



//
// CONFIGURE THE SPELL
// DIRECTION IS THE PLACE WHERE THE CHAR IS LOOKING AT
// POWER IS THE SPELL
// RANGE IS HOW FAR THE MAGIC REACHES
//

- (void)direction:(NSInteger)direction ofAttack:(SKNode *)power andRange:(float)range andAngle: (float)angle
{
    float sinn, coss;
    
    // Correct the angle
    angle = angle / 180.0 * M_PI;
    
    // Set the sin and the cos
    sinn = sinf(angle);
    coss = cosf(angle);
    
    // Set the emission angle
    SKEmitterNode *emmiter = [power.children lastObject];
    
    emmiter.emissionAngle = angle + M_PI;
    [power runAction:[SKAction sequence:@[[SKAction moveByX:coss * range y:sinn * range duration:1.0],
                                          [SKAction removeFromParent]]]];
}

@end
