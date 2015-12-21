/*
 * Copyright (c) 2015 Jia Pu
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef PS3ControllerButton_h
#define PS3ControllerButton_h

#import "PS3ControllerElement.h"

typedef NS_ENUM(NSInteger, PS3ControllerButtonID) {
    PS3ControllerPSButton = 17,
    PS3ControllerSelectButton = 1,
    PS3ControllerStartButton = 4,
    PS3ControllerDPadLeftButton = 8,
    PS3ControllerDPadRightButton = 6,
    PS3ControllerDPadUpButton = 5,
    PS3ControllerDPadDownButton = 7,
    PS3ControllerSquareButton = 16,
    PS3ControllerTriangleButton = 13,
    PS3ControllerCircleButton = 14,
    PS3ControllerCrossButton = 15,
    PS3ControllerLeftStickButton = 2,
    PS3ControllerRightStickButton = 3,
    PS3ControllerLeftShoulderButton = 11,
    PS3ControllerRightShoulderButton = 12,
    PS3ControllerLeftTriggerButton = 9,
    PS3ControllerRightTriggerButton = 10
};

typedef NS_ENUM(NSInteger, PS3ControllerGCGamepadButtonID) {
    PS3ControllerCGGamepadDPadLeftButton,
    PS3ControllerCGGamepadDPadRightButton,
    PS3ControllerCGGamepadDPadUpButton,
    PS3ControllerCGGamepadDPadDownButton,
    PS3ControllerCGGamepadAButton,
    PS3ControllerCGGamepadBButton,
    PS3ControllerCGGamepadXButton,
    PS3ControllerCGGamepadYButton,
    PS3ControllerCGGamepadLeftShoulderButton,
    PS3ControllerCGGamepadRightShouldButton,
    PS3ControllerCGGamepadLeftTriggerButton,
    PS3ControllerCGGamepadRightTriggerButton,
    PS3ControllerCGGamepadOtherButton
};

@interface PS3ControllerButton : NSObject<PS3ControllerElement>

@property (readonly) NSString *name;

- (instancetype)initWithElement:(IOHIDElementRef)element;

+ (NSString*)nameForId:(PS3ControllerButtonID)buttonId;
+ (PS3ControllerGCGamepadButtonID)CGGamepadButtonIdForId:(PS3ControllerButtonID)buttonId;

@end


#endif
