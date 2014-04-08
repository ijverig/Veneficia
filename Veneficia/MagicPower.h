//
//  MagicPower.h
//  Veneficus
//
//  Created by Rodrigo Freitas Leite on 30/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MagicPower : SKEmitterNode

@property(nonatomic) float damage;
@property(strong,nonatomic) NSString *sourcePlayer;

@end
