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
#import "Enumerator.h"
#import "Doodads.h"
#import "Horde.h"

@interface GameScene () <JoystickDelegate, SKPhysicsContactDelegate>

@property(nonatomic) Joystick *joystick;
@property(nonatomic) SKEmitterNode *emmiter;
@property(nonatomic) Player *redWarrior;
@property(nonatomic) Player *enemy;
@property(nonatomic) Attack *factoryAttack;
@property(nonatomic) JSTileMap *map;
@property(nonatomic) FusionPower *fusionPower;
@property(nonatomic) NSString *lastTouched;
@property(nonatomic) SKSpriteNode *shootButton1;
@property(nonatomic) SKSpriteNode *shootButton2;
@property(nonatomic) SKSpriteNode *shootButton3;
@property(nonatomic) SKSpriteNode *shootButton4;
@property(nonatomic) Doodads *doodads;
@property(nonatomic) Horde *horde;


@end

@implementation GameScene


#pragma mark - Contact Delegate


-(void)didBeginContact:(SKPhysicsContact *)contact
{
    // Evitar bounce do player ao colidir com algo
    if ([contact.bodyB.node.name isEqualToString:@"RED_WARRIOR"]) // Nome do jogador
    {
        if ([contact.bodyB.node isKindOfClass:[Player class]])
        {
            Player *p = (Player*) contact.bodyB.node;
            if (p.direction == UP)
                p.userData[@"DIRECTION"] = @"UP";
            if (p.direction == DOWN)
                p.userData[@"DIRECTION"] = @"DOWN";
            if (p.direction == LEFT)
                p.userData[@"DIRECTION"] = @"LEFT";
            if (p.direction == RIGHT)
                p.userData[@"DIRECTION"] = @"RIGHT";
        }
    }
    //    NSLog(@"Begin ContactA %@",contact.bodyA.node.name);
    //    NSLog(@"Begin ContactB %@",contact.bodyB.node.name);
    
    
    
    //	NSLog(@"contato: %@ - %@",contact.bodyA.node.name,contact.bodyB.node.name);
    //	NSLog(@"local: (%.0f,%.0f)",contact.contactPoint.x,contact.contactPoint.y);
    //	NSLog(@"impulso: %f",contact.collisionImpulse);
    
}


- (void)didEndContact:(SKPhysicsContact *)contact
{
    
    // Evitar bounce do player ao colidir com algo
    if ([contact.bodyB.node.name isEqualToString:@"RED_WARRIOR"]) // Nome do jogador
    {
        if ([contact.bodyB.node isKindOfClass:[Player class]])
        {
            Player *p = (Player*) contact.bodyB.node;
            p.userData[@"DIRECTION"] = @"NONE";
        }
    }
    
    //    NSLog(@"END ContactA %@",contact.bodyA.node.name);
    //    NSLog(@"END ContactB %@",contact.bodyB.node.name);
    
    
    
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
        self.map = [JSTileMap mapNamed:@"mapa.tmx"];
        CGRect mapBounds = [self.map calculateAccumulatedFrame];
        self.map.position = CGPointMake(-500, -500);
        [self addChild:self.map];
        
        
        // WORD
		self.physicsWorld.contactDelegate = self;
		self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        
		self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.map.frame];
		self.name = @"WORLD";
		self.physicsBody.categoryBitMask = WORLD;
		self.physicsBody.collisionBitMask = WORLD;
        
        // IMMUTABLE OBJECTS
        self.doodads  = [[Doodads alloc] initWithMap:self.map];
        
        
        //shooters
        _shootButton1 = [[SKSpriteNode alloc] initWithImageNamed:@"quarter 2"];
        _shootButton1.position = CGPointMake(size.width - 200, 180);
        _shootButton1.name = @"SHOT1";
        _shootButton1.zPosition = 1.0;
        _shootButton1.size = CGSizeMake(150, 150);
        [_shootButton1 setAlpha:0.5];
        [self addChild:_shootButton1];
        
        _shootButton2 = [[SKSpriteNode alloc] initWithImageNamed:@"quarter 2"];
        _shootButton2.position = CGPointMake(size.width - 198, 78);
        _shootButton2.name = @"SHOT2";
        _shootButton2.zPosition = 1.0;
        _shootButton2.size = CGSizeMake(150, 150);
        [_shootButton2 setZRotation:M_PI/2];
        [_shootButton2 setAlpha:0.5];
        [self addChild:_shootButton2];
        
        _shootButton3 = [[SKSpriteNode alloc] initWithImageNamed:@"quarter 2"];
        _shootButton3.position = CGPointMake(size.width - 96, 80);
        _shootButton3.name = @"SHOT3";
        _shootButton3.zPosition = 1.0;
        _shootButton3.size = CGSizeMake(150, 150);
        [_shootButton3 setZRotation:M_PI];
        [_shootButton3 setAlpha:0.5];
        [self addChild:_shootButton3];
        
        _shootButton4 = [[SKSpriteNode alloc] initWithImageNamed:@"quarter 2"];
        _shootButton4.position = CGPointMake(size.width - 98, 182);
        _shootButton4.name = @"SHOT4";
        _shootButton4.zPosition = 1.0;
        _shootButton4.size = CGSizeMake(150, 150);
        [_shootButton4 setZRotation:M_PI*3/2];
        [_shootButton4 setAlpha:0.5];
        [self addChild:_shootButton4];
        
        // spells controller
        SKSpriteNode *fireNode = [[SKSpriteNode alloc] initWithImageNamed:@"fireSymbol"];
        fireNode.position = CGPointMake(size.width - 147, 228);
        fireNode.name = @"FIRE";
        fireNode.zPosition = 1.0;
        fireNode.size = CGSizeMake(50, 50);
        [self addChild:fireNode];
        
        SKSpriteNode *waterNode = [[SKSpriteNode alloc] initWithImageNamed:@"waterSymbol"];
        waterNode.position = CGPointMake(size.width - 245, 130);
        waterNode.name = @"WATER";
        waterNode.zPosition = 1.0;
        waterNode.size = CGSizeMake(50, 50);
        [self addChild:waterNode];
        
        SKSpriteNode *earthNode = [[SKSpriteNode alloc] initWithImageNamed:@"earthSymbol"];
        earthNode.position = CGPointMake(size.width - 55, 130);
        earthNode.name = @"EARTH";
        earthNode.zPosition = 1.0;
        earthNode.size = CGSizeMake(50, 50);
        [self addChild:earthNode];
        
        SKSpriteNode *lightningNode = [[SKSpriteNode alloc] initWithImageNamed:@"lightningSymbol"];
        lightningNode.position = CGPointMake(size.width - 147, 35);
        lightningNode.name = @"LIGHTNING";
        lightningNode.zPosition = 1.0;
        lightningNode.size = CGSizeMake(50, 50);
        [self addChild:lightningNode];
        
        // joystick controller
        self.joystick = joystick;
        self.joystick.delegate = self;
        
        // main player
        self.redWarrior = [[Player alloc] initWithPosition:CGPointMake(mapBounds.size.width / 2, mapBounds.size.height / 2)
                                                      name:@"RED_WARRIOR"
                                                 direction:DOWN
                                                      life:1000
                                                  velocity:10
                                                    attack:10
                                                   defense:1000
                                                 atlasName:@"redWarrior"
                                                      size:CGSizeMake(100, 106)];
        [self.map addChild:self.redWarrior];
        self.redWarrior.zPosition = -101.0;
        self.redWarrior.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.redWarrior.size];
        self.redWarrior.physicsBody.categoryBitMask = GOOD_GUY;
        self.redWarrior.physicsBody.contactTestBitMask = BAD_GUY | DOODADS | POWER;
        self.redWarrior.physicsBody.collisionBitMask = BAD_GUY | DOODADS | POWER;
        self.redWarrior.physicsBody.allowsRotation = NO;
        self.redWarrior.physicsBody.usesPreciseCollisionDetection = YES;
        
        
        
        // enemy player
//        self.enemy = [[Player alloc] initWithPosition:CGPointMake(size.width + 100, size.height + 100)
//                                                 name:@"ENEMY"
//                                            direction:DOWN
//                                                 life:1000
//                                             velocity:20
//                                               attack:1000
//                                              defense:1000
//                                            atlasName:@"megaMan"
//                                                 size:CGSizeMake(36, 68)];
//        [self.map addChild:self.enemy];
        
        
        
        // HORDE CONFIGURATION
        self.horde = [[Horde alloc] initHordeNumEnemies:2 inMap:self.map];

        
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
    
//    if ([node.name isEqualToString:@"FIRE"])
//    {
//        NSString *fireRayPath = [[NSBundle mainBundle] pathForResource:@"FireRay" ofType:@"sks"];
//		self.emmiter = [NSKeyedUnarchiver unarchiveObjectWithFile:fireRayPath];
//        self.emmiter.particlePosition = self.redWarrior.position;
//        [self.map addChild:self.emmiter];
//        
//        if (self.redWarrior.direction == LEFT)
//        {
//            self.emmiter.emissionAngle = 0;
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:-self.view.bounds.size.width duration:1.0],
//                                                        [SKAction removeFromParent]]]];
//        }
//        
//        if (self.redWarrior.direction == RIGHT)
//        {
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:self.view.bounds.size.width duration:1.0],
//                                                         [SKAction removeFromParent]]]];
//        }
//        
//        if (self.redWarrior.direction == UP)
//        {
//            self.emmiter.emissionAngle = -M_PI/2;
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:self.view.bounds.size.width duration:1.0],
//                                                        [SKAction removeFromParent]]]];
//        }
//        
//        if (self.redWarrior.direction == DOWN)
//        {
//            self.emmiter.emissionAngle = M_PI/2;
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:-self.view.bounds.size.width duration:1.0],
//                                                         [SKAction removeFromParent]]]];
//        }
//    }
//    
//    if ([node.name isEqualToString:@"WATER"])
//    {
//        NSString *WaterRay = [[NSBundle mainBundle] pathForResource:@"Water" ofType:@"sks"];
//		self.emmiter = [NSKeyedUnarchiver unarchiveObjectWithFile:WaterRay];
//        self.emmiter.particlePosition = self.redWarrior.position;
//        [self.map addChild:self.emmiter];
//        
//        if (self.redWarrior.direction == LEFT)
//        {
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:-self.view.bounds.size.width duration:1.0],
//                                                         [SKAction removeFromParent]]]];
//        }
//        
//        if (self.redWarrior.direction == RIGHT)
//        {
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:self.view.bounds.size.width duration:1.0],
//                                                         [SKAction removeFromParent]]]];
//        }
//        
//        if (self.redWarrior.direction == UP)
//        {
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:self.view.bounds.size.width duration:1.0],
//                                                         [SKAction removeFromParent]]]];
//        }
//        
//        if (self.redWarrior.direction == DOWN)
//        {
//            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:-self.view.bounds.size.width duration:1.0],
//                                                         [SKAction removeFromParent]]]];
//        }
//    }
//    
//    if ([node.name isEqualToString:@"EARTH"])
//    {
//        NSLog(@"=== EARTH SPELL ===");
//    }
//    
//    if ([node.name isEqualToString:@"SHOT"])
//    {
//        [self.fusionPower shotPower];
//    }
    
    if ([node.name isEqualToString:@"FIRE"] && ![_lastTouched isEqualToString:@"FIRE"])
    {
        [self shotSmall];
        _lastTouched = @"FIRE";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot FIRE");
    }
    
    if ([node.name isEqualToString:@"WATER"] && ![_lastTouched isEqualToString:@"WATER"])
    {
        [self shotSmall];
        _lastTouched = @"WATER";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot WATER");
    }
    
    if ([node.name isEqualToString:@"EARTH"] && ![_lastTouched isEqualToString:@"EARTH"])
    {
        [self shotSmall];
        _lastTouched = @"EARTH";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot EARTH");
    }
    
    if ([node.name isEqualToString:@"LIGHTNING"] && ![_lastTouched isEqualToString:@"LIGHTNING"])
    {
        [self shotSmall];
        _lastTouched = @"LIGHTNING";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot LIGHTNING");
    }
    
    if ([node.name isEqualToString:@"SHOT1"] && ![_lastTouched isEqualToString:@"SHOT1"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT1";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
    
    if ([node.name isEqualToString:@"SHOT2"] && ![_lastTouched isEqualToString:@"SHOT2"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT2";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
    
    if ([node.name isEqualToString:@"SHOT3"] && ![_lastTouched isEqualToString:@"SHOT3"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT3";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
    
    if ([node.name isEqualToString:@"SHOT4"] && ![_lastTouched isEqualToString:@"SHOT4"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT4";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
}

#pragma mark - Continuous Touches


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"FIRE"] && ![_lastTouched isEqualToString:@"FIRE"])
    {
        [self shotSmall];
        _lastTouched = @"FIRE";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot FIRE");
    }
    
    if ([node.name isEqualToString:@"WATER"] && ![_lastTouched isEqualToString:@"WATER"])
    {
        [self shotSmall];
        _lastTouched = @"WATER";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot WATER");
    }
    
    if ([node.name isEqualToString:@"EARTH"] && ![_lastTouched isEqualToString:@"EARTH"])
    {
        [self shotSmall];
        _lastTouched = @"EARTH";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot EARTH");
    }
    
    if ([node.name isEqualToString:@"LIGHTNING"] && ![_lastTouched isEqualToString:@"LIGHTNING"])
    {
        [self shotSmall];
        _lastTouched = @"LIGHTNING";
        [self.fusionPower addPower:node.name];
        NSLog(@"Shot LIGHTNING");
    }
    
    if ([node.name isEqualToString:@"SHOT1"] && ![_lastTouched isEqualToString:@"SHOT1"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT1";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
    
    if ([node.name isEqualToString:@"SHOT2"] && ![_lastTouched isEqualToString:@"SHOT2"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT2";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
    
    if ([node.name isEqualToString:@"SHOT3"] && ![_lastTouched isEqualToString:@"SHOT3"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT3";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
    
    if ([node.name isEqualToString:@"SHOT4"] && ![_lastTouched isEqualToString:@"SHOT4"])
    {
        [self shotSmall];
        _lastTouched = @"SHOT4";
        [UIView animateWithDuration:0.1 animations:^
         {
             [node setScale:1.04];
             [node setAlpha:0.7];
         }];
    }
}

-(void)shotSmall
{
    [UIView animateWithDuration:0.1 animations:^
     {
         [_shootButton1 setScale:1];
         [_shootButton1 setAlpha:0.25];
     }];
    [UIView animateWithDuration:0.1 animations:^
     {
         [_shootButton2 setScale:1];
         [_shootButton2 setAlpha:0.25];
     }];
    [UIView animateWithDuration:0.1 animations:^
     {
         [_shootButton3 setScale:1];
         [_shootButton3 setAlpha:0.25];
     }];
    [UIView animateWithDuration:0.1 animations:^
     {
         [_shootButton4 setScale:1];
         [_shootButton4 setAlpha:0.25];
     }];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self shotSmall];
    [self.fusionPower shotPower];
    _lastTouched = @"";
}

#pragma mark - Joystick Delegate

- (void)joystick:(Joystick *)aJoystick didUpdate:(CGPoint)dir
{
    
    [self.redWarrior movePlayer:dir];
    
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

    [self.horde logicHorder:self.redWarrior];
    
    //    [self dummyEnemy];
    //    [self dummyAttackAndHeal];
}

/*
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
 */
 
 
/*
- (void)dummyAttackAndHeal
{
    switch (arc4random_uniform(200))
    {
        case 10:
//            [self.redWarrior decreaseLifeByAmount:247.0];
//            NSLog(@"Life: %4.0f | Dead: %@", self.redWarrior.life.amount, [self.redWarrior isAlive] ? @"nope" : @"yep");
            break;
            
        case 20:
//            [self.redWarrior increaseLifeByAmount:183.0];
//            NSLog(@"Life: %4.0f | Dead: %@", self.redWarrior.life.amount, [self.redWarrior isAlive] ? @"nope" : @"yep");
            break;

        case 30:
 //           [self.enemy decreaseLifeByAmount:259.0];
            break;
            
        case 40:
//            [self.enemy increaseLifeByAmount:163.0];
            break;
    }
}

 */
@end
