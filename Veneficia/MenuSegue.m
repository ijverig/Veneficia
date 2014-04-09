//
//  MenuSegue.m
//  Veneficia
//
//  Created by Rodolfo Antoniazzi on 08/04/14.
//  Copyright (c) 2014 Veneficia. All rights reserved.
//

#import "MenuSegue.h"

@implementation MenuSegue

-(void)perform
{
    UIViewController* sourceVC = [self sourceViewController];
    UIViewController* destinoVC = [self destinationViewController];
    [sourceVC presentViewController:destinoVC animated:NO completion:NULL]; // present VC
}

@end
