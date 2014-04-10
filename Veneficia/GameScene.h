//
//  GameScene.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 28/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Joystick.h"

@interface GameScene : SKScene

- (id)initWithSize:(CGSize)size andJoystick:(Joystick *)joystick;
- (void)centerOnNode:(SKNode *)node;

@end
