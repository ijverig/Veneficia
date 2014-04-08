//
//  Character.m
//  Veneficus
//
//  Created by Rodrigo Freitas Leite on 29/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Character.h"

@interface Character ()



@end

@implementation Character

-(id) initWithPosition:(CGPoint)position
             direction:(float)direction
                  life:(float)life
              velocity:(float)velocity
                attack:(float)attack
               defense:(float)defense
             atlasName:(NSString *)atlasName
{
    self = [super init];
    if (self)
    {
        self.position = position;
        self.direction = direction;
        self.life = life;
        self.velocity = velocity;
        self.attack = attack;
        self.defense = defense;
        self.atlas = [SKTextureAtlas atlasNamed:atlasName];
        [self incializeCharTextures];
    }
    return self;
}

/////////////////////////////////////////////////
// THESE METHODS NEED TO BE OVERRIDING BY SUBCLASS
#pragma mark - Basic Movements
-(void)Up{ NSAssert(NO, @"SubClass of Character need to implements this method"); }
-(void)Down{ NSAssert(NO, @"SubClass of Character need to implements this method"); }
-(void)Left{ NSAssert(NO, @"SubClass of Character need to implements this method"); }
-(void)Right{ NSAssert(NO, @"SubClass of Character need to implements this method"); }

#pragma mark - Diagonal Movements
-(void)UpLeft{ NSAssert(NO, @"SubClass of Character need to implements this method"); }
-(void)UpRight{ NSAssert(NO, @"SubClass of Character need to implements this method"); }
-(void)DownLeft{ NSAssert(NO, @"SubClass of Character need to implements this method"); }
-(void)DownRight{ NSAssert(NO, @"SubClass of Character need to implements this method"); }


////////////////////////////////////////////////
// THIS METHOD CREATE ALL ACTIONS
// WITH TEXTURES OF A ATLAS
// ATLAS NEED TO BE THE FORMAT E.G BACKXXX, FRONTXXX

-(void) incializeCharTextures
{
    NSPredicate *predicateUP = [NSPredicate predicateWithFormat:@" SELF Like[c] 'BACK*' "]; // change to UP after
    NSPredicate *predicateDOWN = [NSPredicate predicateWithFormat:@" SELF Like[c] 'FRONT*' "]; // change to DOWN after
    NSPredicate *predicateLEFT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'LEFT*' "];
    NSPredicate *predicateRIGHT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'RIGHT*' "];
    NSPredicate *predicateUP_RIGHT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'UP_RIGHT*' "];
    NSPredicate *predicateUP_LEFT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'UP_LEFT*' "];
    NSPredicate *predicateDOWN_RIGHT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'DOWN_RIGHT*' "];
    NSPredicate *predicateDOWN_LEFT = [NSPredicate predicateWithFormat:@" SELF Like[c] 'DOWN_LEFT*' "];

    
    self.textureUP = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateUP];
    self.textureDOWN = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateDOWN];
    self.textureLEFT = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateLEFT];
    self.textureRIGHT = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateRIGHT];
    self.textureUP_LEFT = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateUP_LEFT];
    self.textureUP_RIGHT = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateUP_RIGHT];
    self.textureDOWN_LEFT = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateDOWN_LEFT];
    self.textureDOWN_RIGHT = [self generateArrayTextures:[self.atlas textureNames] Withpredicate:predicateDOWN_RIGHT];
}


//////////////////////////////////////////////////////
// THIS METHOD RECEIVE A ARRAY OF STRING WITH TEXTURE NAMES
// AND A PREDICATE TO GET THE BUNCH STRING FILES THAT NEED IT.
// GENERATE A ARRAY OF TEXTURE IN ORDER OF ANIMATION.
-(NSMutableArray*) generateArrayTextures:(NSArray*)textureName Withpredicate:(NSPredicate*)predicate
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *textureSide = [[textureName filteredArrayUsingPredicate:predicate]
                                            sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *s in textureSide)
        [array addObject:[SKTexture textureWithImageNamed:s]];
    return array;
    
}


@end
