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
    return MacPS3ControllerButtonElement;
}

+ (NSString*)nameForId:(MacPS3ControllerButtonID)buttonId {
    switch (buttonId) {
        case MacPS3ControllerPSButton:
            return @"PS Logo";
        case MacPS3ControllerSelectButton:
            return @"Select";
        case MacPS3ControllerStartButton:
            return @"Start";
        case MacPS3ControllerDPadLeftButton:
            return @"DPad Left";
        case MacPS3ControllerDPadRightButton:
            return @"DPad Right";
        case MacPS3ControllerDPadUpButton:
            return @"DPad Up";
        case MacPS3ControllerDPadDownButton:
            return @"DPad Down";
        case MacPS3ControllerSquareButton:
            return @"Square";
        case MacPS3ControllerTriangleButton:
            return @"Triangle";
        case MacPS3ControllerCircleButton:
            return @"Circle";
        case MacPS3ControllerCrossButton:
            return @"Cross";
        case MacPS3ControllerLeftStickButton:
            return @"Left Stick";
        case MacPS3ControllerRightStickButton:
            return @"Right Stick";
        case MacPS3ControllerLeftShoulderButton:
            return @"Left Shoulder";
        case MacPS3ControllerRightShoulderButton:
            return @"Right Shoulder";
        case MacPS3ControllerLeftTriggerButton:
            return @"Left Trigger";
        case MacPS3ControllerRightTriggerButton:
            return @"Right Trigger";
    }
}

+ (MacPS3ControllerGCGamepadButtonID)CGGamepadButtonIdForId:(MacPS3ControllerButtonID)buttonId {
    switch (buttonId) {
        case MacPS3ControllerDPadLeftButton:
            return MacPS3ControllerCGGamepadDPadLeftButton;
        case MacPS3ControllerDPadRightButton:
            return MacPS3ControllerCGGamepadDPadRightButton;
        case MacPS3ControllerDPadUpButton:
            return MacPS3ControllerCGGamepadDPadUpButton;
        case MacPS3ControllerDPadDownButton:
            return MacPS3ControllerCGGamepadDPadDownButton;
        case MacPS3ControllerSquareButton:
            return MacPS3ControllerCGGamepadXButton;
        case MacPS3ControllerTriangleButton:
            return MacPS3ControllerCGGamepadYButton;
        case MacPS3ControllerCrossButton:
            return MacPS3ControllerCGGamepadAButton;
        case MacPS3ControllerCircleButton:
            return MacPS3ControllerCGGamepadBButton;
        case MacPS3ControllerLeftTriggerButton:
            return MacPS3ControllerCGGamepadLeftTriggerButton;
        case MacPS3ControllerLeftShoulderButton:
            return MacPS3ControllerCGGamepadLeftShoulderButton;
        case MacPS3ControllerRightTriggerButton:
            return MacPS3ControllerCGGamepadRightShouldButton;
        case MacPS3ControllerRightShoulderButton:
            return MacPS3ControllerCGGamepadRightShouldButton;
        default:
            return MacPS3ControllerCGGamepadOtherButton;
    }
}

@end
