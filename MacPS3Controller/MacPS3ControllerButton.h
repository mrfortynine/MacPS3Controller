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

#import "MacPS3ControllerElement.h"

typedef NS_ENUM(NSInteger, MacPS3ControllerButtonID) {
    MacPS3ControllerPSButton = 17,
    MacPS3ControllerSelectButton = 1,
    MacPS3ControllerStartButton = 4,
    MacPS3ControllerDPadLeftButton = 8,
    MacPS3ControllerDPadRightButton = 6,
    MacPS3ControllerDPadUpButton = 5,
    MacPS3ControllerDPadDownButton = 7,
    MacPS3ControllerSquareButton = 16,
    MacPS3ControllerTriangleButton = 13,
    MacPS3ControllerCircleButton = 14,
    MacPS3ControllerCrossButton = 15,
    MacPS3ControllerLeftStickButton = 2,
    MacPS3ControllerRightStickButton = 3,
    MacPS3ControllerLeftShoulderButton = 11,
    MacPS3ControllerRightShoulderButton = 12,
    MacPS3ControllerLeftTriggerButton = 9,
    MacPS3ControllerRightTriggerButton = 10
};

typedef NS_ENUM(NSInteger, MacPS3ControllerGCGamepadButtonID) {
    MacPS3ControllerCGGamepadDPadLeftButton,
    MacPS3ControllerCGGamepadDPadRightButton,
    MacPS3ControllerCGGamepadDPadUpButton,
    MacPS3ControllerCGGamepadDPadDownButton,
    MacPS3ControllerCGGamepadAButton,
    MacPS3ControllerCGGamepadBButton,
    MacPS3ControllerCGGamepadXButton,
    MacPS3ControllerCGGamepadYButton,
    MacPS3ControllerCGGamepadLeftShoulderButton,
    MacPS3ControllerCGGamepadRightShouldButton,
    MacPS3ControllerCGGamepadLeftTriggerButton,
    MacPS3ControllerCGGamepadRightTriggerButton,
    MacPS3ControllerCGGamepadOtherButton
};

@interface MacPS3ControllerButton : NSObject<MacPS3ControllerElement>

@property (readonly) NSString *name;
@property (readonly) MacPS3ControllerElementType type;

- (instancetype)initWithElement:(IOHIDElementRef)element;

+ (NSString*)nameForId:(MacPS3ControllerButtonID)buttonId;
+ (MacPS3ControllerGCGamepadButtonID)CGGamepadButtonIdForId:(MacPS3ControllerButtonID)buttonId;

@end

