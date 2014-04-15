//
//  Player.m
//  Veneficus
//
//  Created by Rodrigo Freitas Leite on 29/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithPosition:(CGPoint)position
                  name:(NSString *)name
             direction:(float)direction
                  life:(float)life
              velocity:(float)velocity
                attack:(float)attack
               defense:(float)defense
             atlasName:(NSString *)atlasName
                  size:(CGSize)size
{
    self = [super initWithPosition:position
                              name:name
                         direction:direction
                              life:life
                          velocity:velocity
                            attack:attack
                           defense:defense
                         atlasName:atlasName
                              size:size];
    
    if (self)
    {
        self.texture =   [self.textureDOWN firstObject];
        self.actionUP = [SKAction animateWithTextures:self.textureUP timePerFrame:0.1];
        self.actionDOWN = [SKAction animateWithTextures:self.textureDOWN timePerFrame:0.1];
        self.actionLEFT = [SKAction animateWithTextures:self.textureLEFT timePerFrame:0.1];
        self.actionRIGHT = [SKAction animateWithTextures:self.textureRIGHT timePerFrame:0.1];
        self.actionUP_LEFT = [SKAction animateWithTextures:self.textureUP_LEFT timePerFrame:0.1];
        self.actionUP_RIGHT = [SKAction animateWithTextures:self.textureUP_RIGHT timePerFrame:0.1];
        self.actionDOWN_LEFT = [SKAction animateWithTextures:self.textureDOWN_LEFT timePerFrame:0.1];
        self.actionDOWN_RIGHT = [SKAction animateWithTextures:self.textureDOWN_RIGHT timePerFrame:0.1];
        
        // Collision Direction
        self.userData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"NONE",@"MOVE-DIRECTION", nil];
        
    }
    
    return self;
}

#pragma mark Directions


-(void) movePlayer:(CGPoint)dir
{
    [self setPosition:CGPointMake(self.position.x + self.velocity*dir.x, self.position.y - self.velocity*dir.y)];
    
    //////////////////////////////////
    // Get the angle from the dir.y //
    //////////////////////////////////
    
    NSInteger angleSum = 0;
    float angle;
    float norY;
    float vecSize;
    
    // Get the normal and normalize Y
    vecSize = sqrtf(dir.x * dir.x + dir.y * dir.y);
    norY = -dir.y / vecSize;

    // Get the partial angle
    angle = asinf(norY)/ M_PI * 180.0;
    
    // Correct the angle using the x position
    if(dir.x < 0)
    {
        angle = 180.0 - angle;
    }
    
    // Correct the angle using the forth quadrant
    if(dir.x > 0 && -dir.y < 0)
    {
        angle += 360;
    }
    
    // Done!
    
    //NSLog(@"Angle: %f", angle);
    if (![self hasActions])
    {
        // Rigth
        angleSum = 0;
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionRIGHT]]];
            self.direction = RIGHT;
        }
        
        // Increment the angle sum
        angleSum += 45;
        
        //Up Right
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionUP_RIGHT]]];
            self.direction = UP_RIGHT;
            
        }
        
        angleSum+=45;
        
        //Up
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionUP]]];
            self.direction = UP;
            
        }
        
        // Increment the angle sum
        angleSum += 45;
        
        //Up Left
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionUP_LEFT]]];
            self.direction = UP_LEFT;
            
        }
        
        // Increment the angle sum
        angleSum += 45;
        
        //Left
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionLEFT]]];
            self.direction = LEFT;
            
        }
        
        // Increment the angle sum
        angleSum += 45;
        
        //Down Left
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionDOWN_LEFT]]];
            self.direction = DOWN_LEFT;
            
        }
        
        // Increment the angle sum
        angleSum += 45;
        
        //Down
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionDOWN]]];
            self.direction = DOWN;
            
        }
        // Increment the angle sum
        angleSum += 45;
        
        //Down Right
        if(angle < angleSum + 22.5 && angle > angleSum - 22.5)
        {
            [self runAction:[SKAction sequence:@[self.actionDOWN_RIGHT]]];
            self.direction = DOWN_RIGHT;
            
        }
        
    }
}

- (void)Right
{
    float newRight = self.position.x + self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction sequence:@[self.actionRIGHT]]];
        self.direction = RIGHT;
    }
    // Hit in the wall
//    NSLog(@"enter here");
//    if (! [self.userData[@"DIRECTION"] isEqualToString:@"RIGHT"] )
        [self setPosition:CGPointMake(newRight, self.position.y)];
}

- (void)Left
{
    float newLeft = self.position.x - self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction sequence:@[self.actionLEFT]]];
        self.direction = LEFT;
    }
    
    [self setPosition:CGPointMake(newLeft, self.position.y)];
}



- (void)Up
{
    float newY = self.position.y + self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction sequence:@[self.actionUP]]];
        self.direction = UP;
    }
    
    [self setPosition:CGPointMake(self.position.x, newY)];
}

- (void)Down
{
    float newY  = self.position.y - self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction sequence:@[self.actionDOWN]]];
        self.direction = DOWN;
    }
    
    [self setPosition:CGPointMake(self.position.x, newY)];
}

- (void)UpLeft
{
    float newY = self.position.y + self.velocity;
    float newX = self.position.x - self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionUP_LEFT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = UP_LEFT;
    }
}

- (void)UpRight
{
    float newY = self.position.y + self.velocity;
    float newX = self.position.x + self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionUP_RIGHT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = UP_RIGHT;
    }
}

- (void)DownLeft
{
    float newY = self.position.y - self.velocity;
    float newX = self.position.x - self.velocity;
    
    if (![self hasActions])
    {
        [self runAction:[SKAction group:@[self.actionDOWN_LEFT, [SKAction moveByX:newX y:newY duration:0.1]]]];
        self.direction = DOWN_LEFT;
    }
}

- (void)DownRight
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
