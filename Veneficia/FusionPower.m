//
//  FusionPower.m
//  Veneficia
//
//  Created by Rodrigo Leite on 03/04/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "FusionPower.h"

@interface FusionPower ()

// Stack of type SKNode
@property(nonatomic) NSMutableArray *stack;
@property(nonatomic) NSMutableDictionary *fusions;
@property(nonatomic) SKNode *mapNode;
@property(nonatomic) CGSize size;

@end


@implementation FusionPower


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _stack = [[NSMutableArray alloc] init];
        _fusions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (id)initWithSizeofScreen:(CGSize)size andMap:(SKNode*)map
{
    self = [super init];
    if (self)
    {
        _stack = [[NSMutableArray alloc] init];
        _fusions = [[NSMutableDictionary alloc] init];
        _size = size;
        _mapNode = map;
    }
    return self;
}



/////////////////////////////
// Look Top of the stack and
// fusion a power if necessary

-(SKNode*) fusionOnTop:(SKNode*)top  receiver:(SKNode*) receiver
{
    // implementation
    return receiver;
}


////////////////////////////////////
// RECEIVE A TYPE OF POWER
-(void) addPower:(SKNode*) powerName
{
    SKNode *lastNode = [_stack lastObject];
    // Empty Stack
    if (lastNode == nil)
    {
        [_stack addObject:[powerName copy]];
    }else if (![lastNode.name isEqualToString:powerName.name])
        {
            SKNode *newPower = [self fusionOnTop:lastNode receiver:powerName];
            [_stack addObject:[newPower copy]];
        }
    [self fixLastNodePosition];
    lastNode = [_stack lastObject];
    [lastNode removeFromParent];
    [_mapNode addChild:lastNode];//[_stack lastObject]];
    
}


-(void) fixLastNodePosition
{
    SKNode *node = [_stack lastObject];
    node.position = CGPointMake(_size.width  - node.frame.size.width ,
                                _size.height - (node.frame.size.height * [_stack count]));
    
}


//////////////////////////////////
// SHOW THE POWER IN THE SCREEN
-(NSMutableArray*) showPower
{
    return _stack;
}

//////////////////////////////////
// Return the Power and
// clear the Stack
-(SKNode*) shotPower
{
    for (SKNode *node in _stack)
        [node removeFromParent];
    
    [_stack removeAllObjects];
    return nil;
}


@end
