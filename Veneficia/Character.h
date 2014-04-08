//
//  Character.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 29/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

/////////////////////////////////
//  REPRESENTS A ABSTRACT CLASS
//  THAT EXTENDS SKSPRITENODE
//


// LISTA DE DEFINICOES - CONTERCLOCKWISE

#define UP 0
#define UP_LEFT 1
#define LEFT 2
#define DOWN_LEFT 3
#define DOWN 4
#define DOWN_RIGHT 5
#define RIGHT 6
#define UP_RIGHT 7


#import <SpriteKit/SpriteKit.h>

@interface Character : SKSpriteNode 

// INICIALIZERS
-(id) initWithPosition:(CGPoint)position
             direction:(float)direction
                  life:(float)life
              velocity:(float)velocity
                attack:(float)attack
               defense:(float)defense
             atlasName:(NSString*)atlasName;

// ATRIBUT FROM CHARACTER
@property(nonatomic) CGPoint position;
@property(nonatomic) float direction;
@property(nonatomic) float life;
@property(nonatomic) float velocity;
@property(nonatomic) float attack;
@property(nonatomic) float defense;
@property(nonatomic) SKTextureAtlas *atlas;

// ARRAYS OF TEXTURES
@property(nonatomic) NSArray *textureUP;
@property(nonatomic) NSArray *textureDOWN;
@property(nonatomic) NSArray *textureLEFT;
@property(nonatomic) NSArray *textureRIGHT;

@property(nonatomic) NSArray *textureUP_RIGHT;
@property(nonatomic) NSArray *textureUP_LEFT;
@property(nonatomic) NSArray *textureDOWN_RIGHT;
@property(nonatomic) NSArray *textureDOWN_LEFT;

// ACTIONS OF CHARACTER - INICIALIZE DURING THE PLAYER INICILIZATOR
@property(nonatomic) SKAction *actionUP;
@property(nonatomic) SKAction *actionDOWN;
@property(nonatomic) SKAction *actionLEFT;
@property(nonatomic) SKAction *actionRIGHT;

@property(nonatomic) SKAction *actionUP_RIGHT;
@property(nonatomic) SKAction *actionUP_LEFT;
@property(nonatomic) SKAction *actionDOWN_RIGHT;
@property(nonatomic) SKAction *actionDOWN_LEFT;

// METHODS THAT NEED TO BE OVERRIDING
-(void)Up;
-(void)Down;
-(void)Left;
-(void)Right;

-(void)UpLeft;
-(void)UpRight;
-(void)DownLeft;
-(void)DownRight;

-(void) incializeCharTextures;

@end
