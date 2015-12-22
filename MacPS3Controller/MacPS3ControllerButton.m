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

#import <Foundation/Foundation.h>

#import "DDHidElement.h"
#import "DDHidUsage.h"
#import "MacPS3ControllerButton.h"

@interface MacPS3ControllerButton () {
    DDHidElement *_element;
    MacPS3ControllerButtonID _buttonId;
}

@end

@implementation MacPS3ControllerButton

- (instancetype)initWithElement:(IOHIDElementRef)element {
    _element = [[DDHidElement alloc] initWithHIDElement:element];
    _buttonId = _element.usage.usageId;
    _name = [MacPS3ControllerButton nameForId:_buttonId];
    return self;
}

- (BOOL)handleValue:(IOHIDValueRef)value forHidElement:(DDHidElement *)element {
    _state = IOHIDValueGetIntegerValue(value);
    BOOL processed = false;
    if ([_element.usage isEqual:element.usage]) {
        processed = true;
    }
    return processed;
}

- (MacPS3ControllerElementType)type {
    return MacPS3ControllerElementTypeButton;
}

+ (NSString*)nameForId:(MacPS3ControllerButtonID)buttonId {
    switch (buttonId) {
        case MacPS3ControllerButtonIDPS:
            return @"PS Logo";
        case MacPS3ControllerButtonIDSelect:
            return @"Select";
        case MacPS3ControllerButtonIDStart:
            return @"Start";
        case MacPS3ControllerButtonIDDPadLeft:
            return @"DPad Left";
        case MacPS3ControllerButtonIDDPadRight:
            return @"DPad Right";
        case MacPS3ControllerButtonIDDPadUp:
            return @"DPad Up";
        case MacPS3ControllerButtonIDDPadDown:
            return @"DPad Down";
        case MacPS3ControllerButtonIDSquare:
            return @"Square";
        case MacPS3ControllerButtonIDTriangle:
            return @"Triangle";
        case MacPS3ControllerButtonIDCircle:
            return @"Circle";
        case MacPS3ControllerButtonIDCross:
            return @"Cross";
        case MacPS3ControllerButtonIDLeftStick:
            return @"Left Stick";
        case MacPS3ControllerButtonIDRightStick:
            return @"Right Stick";
        case MacPS3ControllerButtonIDLeftShoulder:
            return @"Left Shoulder";
        case MacPS3ControllerButtonIDRightShoulder:
            return @"Right Shoulder";
        case MacPS3ControllerButtonIDLeftTrigger:
            return @"Left Trigger";
        case MacPS3ControllerButtonIDRightTrigger:
            return @"Right Trigger";
    }
}

+ (MacPS3ControllerGCGamepadButtonID)CGGamepadButtonIdForId:(MacPS3ControllerButtonID)buttonId {
    switch (buttonId) {
        case MacPS3ControllerButtonIDDPadLeft:
            return MacPS3ControllerCGGamepadButtonIDDPadLeft;
        case MacPS3ControllerButtonIDDPadRight:
            return MacPS3ControllerCGGamepadButtonIDDPadRight;
        case MacPS3ControllerButtonIDDPadUp:
            return MacPS3ControllerCGGamepadButtonIDDPadUp;
        case MacPS3ControllerButtonIDDPadDown:
            return MacPS3ControllerCGGamepadButtonIDDPadDown;
        case MacPS3ControllerButtonIDSquare:
            return MacPS3ControllerCGGamepadButtonIDX;
        case MacPS3ControllerButtonIDTriangle:
            return MacPS3ControllerCGGamepadButtonIDY;
        case MacPS3ControllerButtonIDCross:
            return MacPS3ControllerCGGamepadButtonIDA;
        case MacPS3ControllerButtonIDCircle:
            return MacPS3ControllerCGGamepadButtonIDB;
        case MacPS3ControllerButtonIDLeftTrigger:
            return MacPS3ControllerCGGamepadButtonIDLeftTrigger;
        case MacPS3ControllerButtonIDLeftShoulder:
            return MacPS3ControllerCGGamepadButtonIDLeftShoulder;
        case MacPS3ControllerButtonIDRightTrigger:
            return MacPS3ControllerCGGamepadButtonIDRightShould;
        case MacPS3ControllerButtonIDRightShoulder:
            return MacPS3ControllerCGGamepadButtonIDRightShould;
        default:
            return MacPS3ControllerCGGamepadButtonIDOther;
    }
}

@end
