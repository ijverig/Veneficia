//
//  MegaMan.m
//  Veneficus
//
//  Created by Rodrigo Freitas Leite on 29/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Player.h"


@implementation Player

-(id)initWithPosition:(CGPoint)position
            direction:(float)direction
                 life:(float)life
             velocity:(float)velocity
               attack:(float)attack
              defense:(float)defense
            atlasName:(NSString *)atlasName
{
    self = [super initWithPosition:position
                         direction:direction
                              life:life
                          velocity:velocity
                            attack:attack
                           defense:defense
                         atlasName:atlasName];
    
    if (self)
    {
        self.texture =   [self.textureDOWN firstObject];
        self.actionUP = [SKAction animateWithTextures:self.textureUP timePerFrame:0.06];
        self.actionDOWN = [SKAction animateWithTextures:self.textureDOWN timePerFrame:0.06];
        self.actionLEFT = [SKAction animateWithTextures:self.textureLEFT timePerFrame:0.06];
        self.actionRIGHT = [SKAction animateWithTextures:self.textureRIGHT timePerFrame:0.06];
        self.actionUP_LEFT = [SKAction animateWithTextures:self.textureUP_LEFT timePerFrame:0.06];
        self.actionUP_RIGHT = [SKAction animateWithTextures:self.textureUP_RIGHT timePerFrame:0.06];
        self.actionDOWN_LEFT = [SKAction animateWithTextures:self.textureDOWN_LEFT timePerFrame:0.06];
        self.actionDOWN_RIGHT = [SKAction animateWithTextures:self.textureDOWN_RIGHT timePerFrame:0.06];
        
    }
    return self;
}


#pragma mark Directions

-(void) Left
{
    float newLeft = self.position.x - self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[ self.actionLEFT, [SKAction moveToX:newLeft duration:0.01] ]]];
        self.direction = LEFT;
    }
}

-(void) Right
{
    float newRight = self.position.x + self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[ self.actionRIGHT, [SKAction moveToX:newRight duration:0.01] ]]];
        self.direction = RIGHT;
    }
}

-(void) Up
{
    float newY = self.position.y + self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionUP, [SKAction moveToY:newY duration:0.1]]]];
        self.direction = UP;
    }
}

-(void) Down
{
    float newY  = self.position.y - self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionDOWN, [SKAction moveToY:newY duration:0.1]]]];
        self.direction = DOWN;
    }
}


-(void)UpLeft
{
    float newY = self.position.y + self.velocity;
    float newX = self.position.x - self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionUP_LEFT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = UP_LEFT;
    }
}


-(void)UpRight
{
    float newY = self.position.y + self.velocity;
    float newX = self.position.x + self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionUP_RIGHT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = UP_RIGHT;
    }
}


-(void)DownLeft
{
    float newY = self.position.y - self.velocity;
    float newX = self.position.x - self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionDOWN_LEFT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = DOWN_LEFT;
    }
}


-(void)DownRight
{
    float newY = self.position.y - self.velocity;
    float newX = self.position.x + self.velocity;
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionDOWN_RIGHT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = DOWN_RIGHT;
    }
}





@end
