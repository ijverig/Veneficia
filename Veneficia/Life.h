//
//  Life.h
//  Veneficia
//
//  Created by Daniel Schmidt on 4/9/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Life : NSObject

@property (nonatomic) float initialAmount;
@property (nonatomic) float amount;
@property (nonatomic) SKShapeNode *bar;

- (Life *)initWithInitialAmount:(float)amount;
- (void)decreaseByAmount:(float)amount;
- (void)increaseByAmount:(float)amount;
- (BOOL)isAlive;

@end
