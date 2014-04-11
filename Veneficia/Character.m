//
//  Character.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 29/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Character.h"

@implementation Character

- (id)initWithPosition:(CGPoint)position
                  name:(NSString *)name
             direction:(float)direction
                  life:(float)life
              velocity:(float)velocity
                attack:(float)attack
               defense:(float)defense
             atlasName:(NSString *)atlasName
                  size:(CGSize)size;
{
    self = [super init];
    
    if (self)
    {
        self.position = position;
        self.name = name;
        self.direction = direction;
        self.velocity = velocity;
        self.attack = attack;
        self.defense = defense;
        self.atlas = [SKTextureAtlas atlasNamed:atlasName];
        self.size = size;
        self.life = [[Life alloc] initWithInitialAmount:life];
        
        [self initializeCharacterTextures];

        [self addChild:self.life.bar];
    }
    
    return self;
}

- (void)decreaseLifeByAmount:(float)amount
{
    [self.life decreaseByAmount:amount];
}

- (void)increaseLifeByAmount:(float)amount
{
    [self.life increaseByAmount:amount];
}

- (BOOL)isAlive
{
    return [self.life isAlive];
}

// THESE METHODS MUST BE OVERRIDDEN

#pragma mark - Basic Movements

- (void)Up
{
    NSAssert(NO, @"Character subclass must implement this method");
}

- (void)Down
{
    NSAssert(NO, @"Character subclass must implement this method");
}

- (void)Left
{
    NSAssert(NO, @"Character subclass must implement this method");
}

- (void)Right
{
    NSAssert(NO, @"Character subclass must implement this method");
}

#pragma mark - Diagonal Movements

- (void)UpLeft
{
    NSAssert(NO, @"Character subclass must implement this method");
}

- (void)UpRight
{
    NSAssert(NO, @"Character subclass must implement this method");
}

- (void)DownLeft
{
    NSAssert(NO, @"Character subclass must implement this method");
}

- (void)DownRight
{
    NSAssert(NO, @"Character subclass must implement this method");
}

//
// THIS METHOD CREATE ALL ACTIONS
// WITH TEXTURES OF A ATLAS
// ATLAS NEED TO BE THE FORMAT E.G BACKXXX, FRONTXXX
//

- (void)initializeCharacterTextures
{
    NSPredicate *predicateUP = [NSPredicate predicateWithFormat:@" SELF Like[c] 'UP*' "]; // change to UP after
    NSPredicate *predicateDOWN = [NSPredicate predicateWithFormat:@" SELF Like[c] 'DOWN*' "]; // change to DOWN after
    NSPredicate *predicateLEFT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'LEFT*' "];
    NSPredicate *predicateRIGHT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'RIGHT*' "];
    NSPredicate *predicateUP_RIGHT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'UP_RIGHT*' "];
    NSPredicate *predicateUP_LEFT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'UP_LEFT*' "];
    NSPredicate *predicateDOWN_RIGHT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'DOWN_RIGHT*' "];
    NSPredicate *predicateDOWN_LEFT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'DOWN_LEFT*' "];

    
    self.textureUP = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateUP];
    self.textureDOWN = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateDOWN];
    self.textureLEFT = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateLEFT];
    self.textureRIGHT = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateRIGHT];
    self.textureUP_LEFT = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateUP_LEFT];
    self.textureUP_RIGHT = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateUP_RIGHT];
    self.textureDOWN_LEFT = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateDOWN_LEFT];
    self.textureDOWN_RIGHT = [self generateTexturesArray:[self.atlas textureNames] withPredicate:predicateDOWN_RIGHT];
}

//
// THIS METHOD RECEIVE AN ARRAY OF STRINGS WITH TEXTURE NAMES
// AND A PREDICATE TO GET THE BUNCH STRING FILES THAT NEED IT.
// GENERATE A ARRAY OF TEXTURE IN ORDER OF ANIMATION.
//

- (NSMutableArray *)generateTexturesArray:(NSArray *)textureNames withPredicate:(NSPredicate *)predicate
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *textureSide = [[textureNames filteredArrayUsingPredicate:predicate]
                                            sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *s in textureSide)
        [array addObject:[self.atlas textureNamed:s]];
    
    return array;
}

@end
