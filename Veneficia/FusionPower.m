//
//  FusionPower.m
//  Veneficia
//
//  Created by Rodrigo Leite on 03/04/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#define STACK_SIZE      2


#import "FusionPower.h"

@interface FusionPower ()

@property (nonatomic) NSMutableArray *stack; // stack of type SKNode
@property (nonatomic) NSMutableDictionary *fusions;
@property (nonatomic) SKNode *mapNode;
@property (nonatomic) CGSize size;
@property (nonatomic) Attack *attack;

@end

@implementation FusionPower

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _stack = [[NSMutableArray alloc] init];
        _fusions = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id)initWithSizeofScreen:(CGSize)size andMap:(SKNode *)map
{
    self = [super init];
    
    if (self)
    {
        _stack = [[NSMutableArray alloc] init];
        _fusions = [[NSMutableDictionary alloc] init];
        _size = size;
        _mapNode = map;
    }
    
    return self;
}

//
// fusion a power if needed
//

- (NSString *)fusion:(NSString *)receiver
{
    // implementation
    
    if([receiver isEqualToString:@"FIRE"])
    {

        SKNode *aux = [_stack lastObject];
        if([aux.name isEqualToString:@"EARTH"])
        {
            [_stack removeObject:aux];
            [aux removeFromParent];
            return @"LAVA";
        }
        
    }
    else if([receiver isEqualToString:@"EARTH"])
    {
        SKNode *aux = [_stack lastObject];
        if([aux.name isEqualToString:@"FIRE"])
        {
            [_stack removeObject:aux];
            [aux removeFromParent];
            return @"LAVA";
        }
        if([aux.name isEqualToString:@"LIGHTNING"])
        {
            [_stack removeObject:aux];
            [aux removeFromParent];
            return @"LIFE";
        }
    }
    else if([receiver isEqualToString:@"LIGHTNING"])
    {
        SKNode *aux = [_stack lastObject];
        if([aux.name isEqualToString:@"EARTH"])
        {
            [_stack removeObject:aux];
            [aux removeFromParent];
            return @"LIFE";
        }
    }
    return receiver;
}

//
// RECEIVE A TYPE OF POWER
//

- (void)addPower:(NSString *)powerName
{
    if (_stack.count != STACK_SIZE)
    {
        SKNode *lastNode = [_stack lastObject];
        
        // Empty Stack
        if (lastNode == nil)
        {
            [self createPower:powerName];
        }
        else
        {
            NSString *newPower = [self fusion:powerName];
            [self createPower:newPower];
            
        }
        
    }
    else
    {
        NSString *newPower = [self fusion:powerName];
        if (newPower != powerName) //FUSION OCURRED
        {
            [self fixLastNodePosition];
            [self createPower:newPower];
        }
    }
    
}

- (void)fixLastNodePosition
{
    SKNode *node = [_stack lastObject];
    node.position = CGPointMake(_size.width  - node.frame.size.width ,
                                _size.height - (node.frame.size.height * [_stack count]));
}

//
// SHOW THE POWER ON THE SCREEN
//

- (NSMutableArray *)showPower
{
    return _stack;
}

//
// Return the Power and
// clear the Stack
//

- (SKNode *)shotPower:(Player *) player
{
    _attack = [Attack shareAttackInstance];
    NSInteger fire=0;
    NSInteger earth=0;
    NSInteger water=0;
    NSInteger lightning=0;
    NSInteger life=0;
    NSInteger lava=0;
    for (NSInteger i=0; i<_stack.count; i++)
    {
        SKNode *aux = _stack[i];
        if([aux.name isEqualToString:@"FIRE"])
            fire++;
        if([aux.name isEqualToString:@"EARTH"])
            earth++;
        if([aux.name isEqualToString:@"WATER"])
            water++;
        if([aux.name isEqualToString:@"LIGHTNING"])
            lightning++;
        if([aux.name isEqualToString:@"LIFE"])
            life++;
        if([aux.name isEqualToString:@"LAVA"])
            lava++;
    }
    
    if(fire==1)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"FIRE"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"50" forKey:@"damage"];
        return node;
    }
    else if(fire==2)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"FIRE"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"250" forKey:@"damage"];
        return node;
    }
    else if(water==1)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"WATER"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"50" forKey:@"damage"];
        return node;
    }
    else if(water==2)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"WATER"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"250" forKey:@"damage"];
        return node;
    }
    else if(lightning==1)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"LIGHTNING"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"50" forKey:@"damage"];
        return node;
    }
    else if(lightning==2)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"LIGHTNING"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"250" forKey:@"damage"];
        return node;
    }
    else if(earth==1)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"EARTH"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"50" forKey:@"damage"];
        return node;
    }
    else if(earth==2)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"EARTH"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"250" forKey:@"damage"];
        return node;
    }
    else if(lava==1)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"LAVA"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"400" forKey:@"damage"];
        return node;
    }
    else if(lava==2)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"LAVA"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"1000" forKey:@"damage"];
        return node;
    }
    else if(life==1)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"LIFE"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"400" forKey:@"damage"];
        return node;
    }
    else if(life==2)
    {
        SKNode *node=[_attack createAttackBy:player andPower:@"LIFE"];
        [self cleanStack];
        node.userData = [[NSMutableDictionary alloc] init];
        [node.userData setValue:@"1000" forKey:@"damage"];
        return node;
    }
    
    [self cleanStack];
    return nil;
}

-(void)cleanStack
{
    for (SKNode *node in _stack)
        [node removeFromParent];
    
    [_stack removeAllObjects];
}
- (void)createPower: (NSString *)powerName
{
    if([powerName isEqualToString:@"FIRE"])
    {
        SKSpriteNode *fireNode = [[SKSpriteNode alloc] initWithImageNamed:@"fireSymbol"];
        fireNode.position = CGPointMake(_size.width - 140, 200);
        fireNode.name = @"FIRE";
        fireNode.zPosition = 1.0;
        fireNode.size = CGSizeMake(50, 50);
        [_mapNode addChild:fireNode];
        [_stack addObject:fireNode];
    }
    
    else if([powerName isEqualToString:@"WATER"])
    {
        SKSpriteNode *waterNode = [[SKSpriteNode alloc] initWithImageNamed:@"waterSymbol"];
        waterNode.position = CGPointMake(_size.width - 220, 120);
        waterNode.name = @"WATER";
        waterNode.zPosition = 1.0;
        waterNode.size = CGSizeMake(50, 50);
        [_mapNode addChild:waterNode];
        [_stack addObject:waterNode];
    }
    
    else if([powerName isEqualToString:@"EARTH"])
    {
        SKSpriteNode *earthNode = [[SKSpriteNode alloc] initWithImageNamed:@"earthSymbol"];
        earthNode.position = CGPointMake(_size.width - 60, 120);
        earthNode.name = @"EARTH";
        earthNode.zPosition = 1.0;
        earthNode.size = CGSizeMake(50, 50);
        [_mapNode addChild:earthNode];
        [_stack addObject:earthNode];
    }
    
    else if([powerName isEqualToString:@"LAVA"])
    {
        SKSpriteNode *lavaNode = [[SKSpriteNode alloc] initWithImageNamed:@"lavaSymbol"];
        lavaNode.position = CGPointMake(_size.width - 140, 120);
        lavaNode.name = @"LAVA";
        lavaNode.zPosition = 1.0;
        lavaNode.size = CGSizeMake(50, 50);
        [_mapNode addChild:lavaNode];
        [_stack addObject:lavaNode];
    }
    
    else if([powerName isEqualToString:@"LIFE"])
    {
        SKSpriteNode *lifeNode = [[SKSpriteNode alloc] initWithImageNamed:@"lifeSymbol"];
        lifeNode.position = CGPointMake(_size.width - 140, 120);
        lifeNode.name = @"LIFE";
        lifeNode.zPosition = 1.0;
        lifeNode.size = CGSizeMake(50, 50);
        [_mapNode addChild:lifeNode];
        [_stack addObject:lifeNode];
    }
    
    else if([powerName isEqualToString:@"LIGHTNING"])
    {
        SKSpriteNode *lavaNode = [[SKSpriteNode alloc] initWithImageNamed:@"lightningSymbol"];
        lavaNode.position = CGPointMake(_size.width - 140, 120);
        lavaNode.name = @"LIGHTNING";
        lavaNode.zPosition = 1.0;
        lavaNode.size = CGSizeMake(50, 50);
        [_mapNode addChild:lavaNode];
        [_stack addObject:lavaNode];
    }
    
    [self fixLastNodePosition];
}

@end
