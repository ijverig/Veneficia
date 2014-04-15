//
//  ViewController.m
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 28/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "Joystick.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics = YES;
    // Create Joystick
    Joystick *joystick = [[Joystick alloc] initWithFrame:CGRectMake(35, self.view.bounds.size.height  - 300, 128, 128)];
    [joystick setThumbImage:[UIImage imageNamed:@"joy_thumb.png"]
                 andBGImage:[UIImage imageNamed:@"stick_base.png"]];
       [self.view addSubview:joystick];
    
    // Create and configure Game Scene
    GameScene *game = [[GameScene alloc] initWithSize:skView.bounds.size andJoystick:joystick];
    game.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene
    [skView presentScene:game];
 
}



- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    NSLog(@"***** Memory Warning *****");
}

@end
