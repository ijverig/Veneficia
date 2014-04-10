//
//  Player.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 29/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "Character.h"

@interface Player : Character

- (id)initWithPosition:(CGPoint)position
                  name:(NSString *)name
             direction:(float)direction
                  life:(float)life
              velocity:(float)velocity
                attack:(float)attack
               defense:(float)defense
             atlasName:(NSString *)atlasName
                  size:(CGSize)size;

@end
