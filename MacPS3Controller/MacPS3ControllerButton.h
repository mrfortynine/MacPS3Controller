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
    MacPS3ControllerButtonIDPS = 17,
    MacPS3ControllerButtonIDSelect = 1,
    MacPS3ControllerButtonIDStart = 4,
    MacPS3ControllerButtonIDDPadLeft = 8,
    MacPS3ControllerButtonIDDPadRight = 6,
    MacPS3ControllerButtonIDDPadUp = 5,
    MacPS3ControllerButtonIDDPadDown = 7,
    MacPS3ControllerButtonIDSquare = 16,
    MacPS3ControllerButtonIDTriangle = 13,
    MacPS3ControllerButtonIDCircle = 14,
    MacPS3ControllerButtonIDCross = 15,
    MacPS3ControllerButtonIDLeftStick = 2,
    MacPS3ControllerButtonIDRightStick = 3,
    MacPS3ControllerButtonIDLeftShoulder = 11,
    MacPS3ControllerButtonIDRightShoulder = 12,
    MacPS3ControllerButtonIDLeftTrigger = 9,
    MacPS3ControllerButtonIDRightTrigger = 10
};

typedef NS_ENUM(NSInteger, MacPS3ControllerGCGamepadButtonID) {
    MacPS3ControllerCGGamepadButtonIDDPadLeft,
    MacPS3ControllerCGGamepadButtonIDDPadRight,
    MacPS3ControllerCGGamepadButtonIDDPadUp,
    MacPS3ControllerCGGamepadButtonIDDPadDown,
    MacPS3ControllerCGGamepadButtonIDA,
    MacPS3ControllerCGGamepadButtonIDB,
    MacPS3ControllerCGGamepadButtonIDX,
    MacPS3ControllerCGGamepadButtonIDY,
    MacPS3ControllerCGGamepadButtonIDLeftShoulder,
    MacPS3ControllerCGGamepadButtonIDRightShould,
    MacPS3ControllerCGGamepadButtonIDLeftTrigger,
    MacPS3ControllerCGGamepadButtonIDRightTrigger,
    MacPS3ControllerCGGamepadButtonIDOther
};

@interface MacPS3ControllerButton : NSObject<MacPS3ControllerElement>

@property (readonly) NSString *name;
@property (readonly) MacPS3ControllerElementType type;
@property (readonly) CFIndex state;

- (instancetype)initWithElement:(IOHIDElementRef)element;

+ (NSString*)nameForId:(MacPS3ControllerButtonID)buttonId;
+ (MacPS3ControllerGCGamepadButtonID)CGGamepadButtonIdForId:(MacPS3ControllerButtonID)buttonId;

@end

