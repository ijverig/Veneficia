//
//  GameScene.m
//  Veneficus
//
//  Created by Rodrigo Freitas Leite on 28/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "GameScene.h"
#import "Joystick.h"
#import "Player.h"
#import "JSTileMap.h"
#import "Attack.h"
#import "FusionPower.h"

@interface GameScene () <JoystickDelegate>

@property(nonatomic) Joystick *joystick;
@property(nonatomic) SKEmitterNode *emmiter;
@property(nonatomic) Player *redWarrior;
@property(nonatomic) Player *enemy;
@property(nonatomic) Attack *factoryAttack;
@property(nonatomic) JSTileMap *map;
@property(nonatomic) FusionPower *fusionPower;

@end

@implementation GameScene
{
    // control variables
    int count;
}

- (id)initWithSize:(CGSize)size andJoystick:(Joystick *)joystick
{
    if (self = [super initWithSize:size])
    {
        // map
//        NSLog(@"Point: %@", NSStringFromCGPoint(self.anchorPoint));
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
//        TILE MAP
//        JSTileMap* tiledMap = [JSTileMap mapNamed:@"isometric_grass_and_water.tmx"];
        self.map = [JSTileMap mapNamed:@"map.tmx"];
//        CGRect mapBounds = [self.map calculateAccumulatedFrame];
//        NSLog(@"%@",NSStringFromCGRect(mapBounds));
//        NSLog(@"%f %f",mapBounds.size.height, mapBounds.size.width);
        self.map.position = CGPointMake(-500, -500);
        [self addChild:self.map];
        
        // spells controller
        SKSpriteNode *fireNode = [[SKSpriteNode alloc] initWithImageNamed:@"fireSymbol"];
        fireNode.position = CGPointMake(size.width - 140, 200);
        fireNode.name = @"FIRE";
        fireNode.zPosition = 1.0;
        fireNode.size = CGSizeMake(50, 50);
        [self addChild:fireNode];
        
        SKSpriteNode *waterNode = [[SKSpriteNode alloc] initWithImageNamed:@"waterSymbol"];
        waterNode.position = CGPointMake(size.width - 220, 120);
        waterNode.name = @"WATER";
        waterNode.zPosition = 1.0;
        waterNode.size = CGSizeMake(50, 50);
        [self addChild:waterNode];
        
        SKSpriteNode *earthNode = [[SKSpriteNode alloc] initWithImageNamed:@"earthSymbol"];
        earthNode.position = CGPointMake(size.width - 60, 120);
        earthNode.name = @"EARTH";
        earthNode.zPosition = 1.0;
        earthNode.size = CGSizeMake(50, 50);
        [self addChild:earthNode];
        
        SKSpriteNode *shotButton = [[SKSpriteNode alloc] initWithImageNamed:@"glassButtonGreen"];
        shotButton.position = CGPointMake(size.width - 140, 120);
        shotButton.name = @"SHOT";
        shotButton.zPosition = 1.0;
        shotButton.size = CGSizeMake(60, 60);
        [self addChild:shotButton];
        
        // joystick controller
        self.joystick = joystick;
        self.joystick.delegate = self;
        
        // main player
        self.redWarrior = [[Player alloc] initWithPosition:CGPointMake(size.width, size.height)
                                                      name:@"RED_WARRIOR"
                                                 direction:DOWN
                                                      life:1000
                                                  velocity:10
                                                    attack:10
                                                   defense:1000
                                                 atlasName:@"redWarrior"
                                                      size:CGSizeMake(100, 106)];
        [self.map addChild:self.redWarrior];
        
        // enemy player
        self.enemy = [[Player alloc] initWithPosition:CGPointMake(size.width + 100, size.height + 100)
                                                 name:@"ENEMY"
                                            direction:DOWN
                                                 life:1000
                                             velocity:20
                                               attack:1000
                                              defense:1000
                                            atlasName:@"megaMan"
                                                 size:CGSizeMake(36, 68)];
        [self.map addChild:self.enemy];
        
        // spell factory
        self.factoryAttack = [Attack shareAttackInstance];
        
        // power fusion
        self.fusionPower = [[FusionPower alloc] initWithSizeofScreen:size andMap:self];
    }
    
    return self;
}

#pragma mark - Initial Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"FIRE"])
    {
        NSString *fireRayPath = [[NSBundle mainBundle] pathForResource:@"FireRay" ofType:@"sks"];
		self.emmiter = [NSKeyedUnarchiver unarchiveObjectWithFile:fireRayPath];
        self.emmiter.particlePosition = self.redWarrior.position;
        [self.map addChild:self.emmiter];
        
        if (self.redWarrior.direction == LEFT)
        {
            self.emmiter.emissionAngle = 0;
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:-self.view.bounds.size.width duration:1.0],
                                                        [SKAction removeFromParent]]]];
        }
        
        if (self.redWarrior.direction == RIGHT)
        {
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
        
        if (self.redWarrior.direction == UP)
        {
            self.emmiter.emissionAngle = -M_PI/2;
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:self.view.bounds.size.width duration:1.0],
                                                        [SKAction removeFromParent]]]];
        }
        
        if (self.redWarrior.direction == DOWN)
        {
            self.emmiter.emissionAngle = M_PI/2;
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:-self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
    }
    
    if ([node.name isEqualToString:@"WATER"])
    {
        NSString *WaterRay = [[NSBundle mainBundle] pathForResource:@"Water" ofType:@"sks"];
		self.emmiter = [NSKeyedUnarchiver unarchiveObjectWithFile:WaterRay];
        self.emmiter.particlePosition = self.redWarrior.position;
        [self.map addChild:self.emmiter];
        
        if (self.redWarrior.direction == LEFT)
        {
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:-self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
        
        if (self.redWarrior.direction == RIGHT)
        {
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
        
        if (self.redWarrior.direction == UP)
        {
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
        
        if (self.redWarrior.direction == DOWN)
        {
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:-self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
    }
    
    if ([node.name isEqualToString:@"EARTH"])
    {
        NSLog(@"=== EARTH SPELL ===");
    }
    
    if ([node.name isEqualToString:@"SHOT"])
    {
        [self.fusionPower shotPower];
    }
}

#pragma mark - Continuous Touches

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"FIRE"])
    {
        [self.fusionPower addPower:node];
        NSLog(@"Shot FIRE");
    }
    
    
    if ([node.name isEqualToString:@"WATER"])
    {
        [self.fusionPower addPower:node];
        NSLog(@"Shot WATER");
    }
    
    if ([node.name isEqualToString:@"EARTH"])
    {
        [self.fusionPower addPower:node];
        NSLog(@"Shot EARTH");
    }
}

#pragma mark - Joystick Delegate

- (void)joystick:(Joystick *)aJoystick didUpdate:(CGPoint)dir
{    
    if (dir.x > 0.5)
    {
        [self.redWarrior Right];
    }
    
    if (dir.x < -0.5)
    {
        [self.redWarrior Left];
    }
    
    if (dir.y > 0.5)
    {
        [self.redWarrior Down];
    }
    
    if (dir.y < -0.5)
    {
        [self.redWarrior Up];
    }
}

#pragma mark - Camera Position

- (void)centerOnNode:(SKNode *)node
{
    CGPoint cameraPositionInScene = [node.scene convertPoint:node.position fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x - cameraPositionInScene.x + self.view.bounds.size.width / 2 ,
                                       node.parent.position.y - cameraPositionInScene.y + self.view.bounds.size.height / 2 );
}

#pragma mark - Game Logic

- (void)update:(NSTimeInterval)currentTime
{
    if (![self.redWarrior isAlive])
    {
        [self.redWarrior removeFromParent];
    }
    
    if (![self.enemy isAlive])
    {
        [self.enemy removeFromParent];
    }
    
    [self centerOnNode:self.redWarrior];
    [self dummyEnemy];
    [self dummyAttackAndHeal];
}

- (void)dummyEnemy
{
    int rand = arc4random_uniform(40);

    switch (rand)
    {
        case LEFT:
        {
            [self.enemy Left];
            
            if (self.enemy.direction == LEFT)
            {
                MagicPower *power = (MagicPower *)[self.factoryAttack createWaterAttackBy:self.enemy];
                [self.map addChild:(SKNode *)power];
            }
        }
        break;
            
        case RIGHT:
            [self.enemy Right];
            break;
            
        case UP:
            [self.enemy Up];
            break;
            
        case DOWN:
            [self.enemy Down];
            break;
            
        default:
            break;
    }
}

- (void)dummyAttackAndHeal
{
    switch (arc4random_uniform(200))
    {
        case 10:
            [self.redWarrior decreaseLifeByAmount:247.0];
//            NSLog(@"Life: %4.0f | Dead: %@", self.redWarrior.life.amount, [self.redWarrior isAlive] ? @"nope" : @"yep");
            break;
            
        case 20:
            [self.redWarrior increaseLifeByAmount:183.0];
//            NSLog(@"Life: %4.0f | Dead: %@", self.redWarrior.life.amount, [self.redWarrior isAlive] ? @"nope" : @"yep");
            break;

        case 30:
            [self.enemy decreaseLifeByAmount:259.0];
            break;
            
        case 40:
            [self.enemy increaseLifeByAmount:163.0];
            break;
    }
}

@end
