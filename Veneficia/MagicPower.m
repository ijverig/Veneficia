//
//  MagicPower.m
//  Veneficus
//
//  Created by Rodrigo Freitas Leite on 30/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "MagicPower.h"

@implementation MagicPower

- (instancetype)init
{
    self = [super init];
    if (self) {
        _damage = 0;
        _sourcePlayer = @"";
    }
    return self;
}

@end
