//
//  Joystick.h
//  Veneficia
//
//  Created by Rodrigo Freitas Leite on 28/03/14.
//  Copyright (c) 2014 Frelei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JoystickDelegate;

@interface Joystick : UIView

@property CGFloat updateInterval;
@property (weak) id<JoystickDelegate> delegate;

- (void)setMovementUpdateInterval:(CGFloat)interval;
- (void)setThumbImage:(UIImage *)thumbImage andBGImage:(UIImage *)bgImage;
- (void)setMoveViscosity:(CGFloat)mv andSmallestValue:(CGFloat)sv;

@end

@protocol JoystickDelegate <NSObject>

@optional
- (void)joystick:(Joystick *)aJoystick didUpdate:(CGPoint)movement;

@end


