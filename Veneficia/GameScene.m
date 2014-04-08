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
    // variables of control
    int count;
}



-(id) initWithSize:(CGSize)size andJoystick:(Joystick*)joystick
{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        NSLog(@"Point: %@", NSStringFromCGPoint(self.anchorPoint));
        // TILE MAP
//        JSTileMap* tiledMap = [JSTileMap mapNamed:@"isometric_grass_and_water.tmx"];
        self.map = [JSTileMap mapNamed:@"map.tmx"];

        CGRect mapBounds = [self.map calculateAccumulatedFrame];
        
        NSLog(@"%@",NSStringFromCGRect(mapBounds));
        NSLog(@"%f %f",mapBounds.size.height, mapBounds.size.width);
        self.map.position = CGPointMake(-500, -500);
        [self addChild:self.map];
        
        // Buttons
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
        
        SKSpriteNode *earthNode = [[SKSpriteNode alloc] initWithImageNamed:@"terraSymbol"];
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
        
        
        
        // Controller
        self.joystick = joystick;
        self.joystick.delegate = self;

        // Player inicial
//        self.megaman = [[Player alloc] initWithPosition:CGPointMake(size.width, size.height)
//                                              direction:DOWN
//                                                   life:1000
//                                               velocity:50
//                                                 attack:1000
//                                                defense:1000
//                                              atlasName:@"megaMan"];
//        self.megaman.name = @"Mega-man";
//        self.megaman.size = CGSizeMake(60, 60);
//        [self.map addChild:self.megaman];
//        
//        // Player Enemy
        self.enemy = [[Player alloc] initWithPosition:CGPointMake(size.width +100, size.height +100)
                                            direction:DOWN
                                                 life:1000
                                             velocity:20
                                               attack:1000
                                              defense:1000
                                            atlasName:@"megaMan"];
        self.enemy.name = @"enemy";
        self.enemy.size = CGSizeMake(60, 60);
        [self.map addChild:self.enemy];
        
        // RED Player
        self.redWarrior = [[Player alloc] initWithPosition:CGPointMake(size.width, size.height)
                                                 direction:DOWN
                                                      life:1000
                                                  velocity:10
                                                    attack:10
                                                   defense:1000 atlasName:@"RED_WARRIOR"];
        self.redWarrior.name = @"RED_WARRIOR";
        self.redWarrior.size = CGSizeMake(100, 100);
        [self.map addChild:self.redWarrior];
        
        //Factory of Spells
        self.factoryAttack = [Attack shareAttackInstance];
    
        //Fusion of Powers
        self.fusionPower = [[FusionPower alloc] initWithSizeofScreen:size andMap:self];
    }
    return self;

}



#pragma mark - Inicial Touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
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
        if (self.redWarrior.direction == LEFT){
            self.emmiter.emissionAngle = 0;
            [self.emmiter runAction:[SKAction sequence:@[ [SKAction moveToX:-self.view.bounds.size.width duration:1.0],
                                                          [SKAction removeFromParent]]]];
        }
        if (self.redWarrior.direction == RIGHT){
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:self.view.bounds.size.width duration:1.0],
                                                         [SKAction removeFromParent]]]];
        }
        if(self.redWarrior.direction == UP){
          self.emmiter.emissionAngle = -M_PI/2;
            [self.emmiter runAction:[SKAction sequence:@[ [SKAction moveToY:self.view.bounds.size.width duration:1.0],
                                                          [SKAction removeFromParent]]]];
        }
        if (self.redWarrior.direction == DOWN){
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
        if (self.redWarrior.direction == LEFT){
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:-self.view.bounds.size.width duration:1.0], [SKAction removeFromParent]]]];
        }
        if (self.redWarrior.direction == RIGHT){
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToX:self.view.bounds.size.width duration:1.0], [SKAction removeFromParent]]]];
        }
        if (self.redWarrior.direction == UP){
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:self.view.bounds.size.width duration:1.0], [SKAction removeFromParent]]]];
        }
        if (self.redWarrior.direction == DOWN){
            [self.emmiter runAction:[SKAction sequence:@[[SKAction moveToY:-self.view.bounds.size.width duration:1.0], [SKAction removeFromParent]]]];
        }
    
    }
    
    
    if ([node.name isEqualToString:@"EARTH"])
    {
        NSLog(@"BEGAN EARTH");
    }
    
    if ([node.name isEqualToString:@"SHOT"])
    {
        NSLog(@"BEGAN SHOT");
        [self.fusionPower shotPower];
    }
    
}


#pragma mark - Touch Continuos
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
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
    if (dir.x> 0.5) {
        NSLog(@"Right");
        [self.redWarrior Right];
    }
    
    if (dir.x < -0.5) {
   //     NSLog(@"Left");

        [self.redWarrior Left];
    }
    
    if (dir.y > 0.5) {
    //    NSLog(@"Down");
        [self.redWarrior Down];

    }
    
    if (dir.y < -0.5) {
       // NSLog(@"Top");
        [self.redWarrior Up];

    }
    
}

#pragma mark - Camera Positional
- (void) centerOnNode: (SKNode *) node
{
    CGPoint cameraPositionInScene = [node.scene convertPoint:node.position fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x - cameraPositionInScene.x + self.view.bounds.size.width / 2 ,
                                       node.parent.position.y - cameraPositionInScene.y + self.view.bounds.size.height / 2 );
}


#pragma mark - Logic Application

-(void)update:(NSTimeInterval)currentTime
{
    [self centerOnNode:self.redWarrior];
    [self dummyEnemy];
    
}

-(void) dummyEnemy
{
    int rand = arc4random_uniform(4);

    switch (rand) {
        case 0:
        {
            [self.enemy Left];
            if (self.enemy.direction == LEFT) {
                MagicPower *power = (MagicPower*) [self.factoryAttack createWaterAttackBy:self.enemy];
                [self.map addChild:(SKNode*)power];
            }
        }
            break;
        case 1:
        
            [self.enemy Right];
        
            break;
        case 2:
            [self.enemy Up];
        
            break;
        case 3:
            [self.enemy Down];
            
        default:
            break;
    }
}

@end
