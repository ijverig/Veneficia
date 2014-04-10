//
//  Life.m
//  Veneficia
//
//  Created by Daniel Schmidt on 4/9/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import "Life.h"

@implementation Life

- (Life *)initWithInitialAmount:(float)amount
{
    self = [super init];
    
    if (self)
    {
        _initialAmount = amount;
        _amount = _initialAmount;
        
        _bar = [[SKShapeNode alloc] init];
        _bar.path = [UIBezierPath bezierPathWithRect:CGRectMake(-28, -60, 50.0, 6.0)].CGPath;
        _bar.fillColor = SKColor.yellowColor;
        _bar.strokeColor = SKColor.orangeColor;
    }
    
    return self;
}

- (void)decreaseByAmount:(float)amount
{
    _amount -= amount;

    if (_amount < 0)
    {
        _amount = 0;
    }
    
    [self updateBar];
}

- (void)increaseByAmount:(float)amount
{
    _amount += amount;
    
    if (_amount > _initialAmount)
    {
        _amount = _initialAmount;
    }

    [self updateBar];
}

- (BOOL)isAlive
{
    return _amount > 0;
}

- (void)updateBar
{
    _bar.path = [UIBezierPath bezierPathWithRect:CGRectMake(-28, -60, _amount * 0.05, 6.0)].CGPath;
}

@end
