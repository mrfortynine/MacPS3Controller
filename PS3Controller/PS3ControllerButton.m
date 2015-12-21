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
#import "PS3ControllerButton.h"

@interface PS3ControllerButton () {
    DDHidElement *_element;
    PS3ControllerButtonID _buttonId;
    CFIndex _state;
}

@end

@implementation PS3ControllerButton

- (instancetype)initWithElement:(IOHIDElementRef)element {
    _element = [[DDHidElement alloc] initWithHIDElement:element];
    _buttonId = _element.usage.usageId;
    _name = [PS3ControllerButton nameForId:_buttonId];
    return self;
}

- (BOOL)handleValue:(IOHIDValueRef)value forHidElement:(DDHidElement *)element {
    _state = IOHIDValueGetIntegerValue(value);
    BOOL processed = false;
    if ([_element.usage isEqual:element.usage]) {
        processed = true;
    }

    /*
    if (processed) {
        NSLog(@"button: %u, state: %ld", _element.usage.usageId, state);
    }
     */
    return processed;
}

+ (NSString*)nameForId:(PS3ControllerButtonID)buttonId {
    switch (buttonId) {
        case PS3ControllerPSButton:
            return @"PS Logo";
        case PS3ControllerSelectButton:
            return @"Select";
        case PS3ControllerStartButton:
            return @"Start";
        case PS3ControllerDPadLeftButton:
            return @"DPad Left";
        case PS3ControllerDPadRightButton:
            return @"DPad Right";
        case PS3ControllerDPadUpButton:
            return @"DPad Up";
        case PS3ControllerDPadDownButton:
            return @"DPad Down";
        case PS3ControllerSquareButton:
            return @"Square";
        case PS3ControllerTriangleButton:
            return @"Triangle";
        case PS3ControllerCircleButton:
            return @"Circle";
        case PS3ControllerCrossButton:
            return @"Cross";
        case PS3ControllerLeftStickButton:
            return @"Left Stick";
        case PS3ControllerRightStickButton:
            return @"Right Stick";
        case PS3ControllerLeftShoulderButton:
            return @"Left Shoulder";
        case PS3ControllerRightShoulderButton:
            return @"Right Shoulder";
        case PS3ControllerLeftTriggerButton:
            return @"Left Trigger";
        case PS3ControllerRightTriggerButton:
            return @"Right Trigger";
    }
}

+ (PS3ControllerGCGamepadButtonID)CGGamepadButtonIdForId:(PS3ControllerButtonID)buttonId {
    switch (buttonId) {
        case PS3ControllerDPadLeftButton:
            return PS3ControllerCGGamepadDPadLeftButton;
        case PS3ControllerDPadRightButton:
            return PS3ControllerCGGamepadDPadRightButton;
        case PS3ControllerDPadUpButton:
            return PS3ControllerCGGamepadDPadUpButton;
        case PS3ControllerDPadDownButton:
            return PS3ControllerCGGamepadDPadDownButton;
        case PS3ControllerSquareButton:
            return PS3ControllerCGGamepadXButton;
        case PS3ControllerTriangleButton:
            return PS3ControllerCGGamepadYButton;
        case PS3ControllerCrossButton:
            return PS3ControllerCGGamepadAButton;
        case PS3ControllerCircleButton:
            return PS3ControllerCGGamepadBButton;
        case PS3ControllerLeftTriggerButton:
            return PS3ControllerCGGamepadLeftTriggerButton;
        case PS3ControllerLeftShoulderButton:
            return PS3ControllerCGGamepadLeftShoulderButton;
        case PS3ControllerRightTriggerButton:
            return PS3ControllerCGGamepadRightShouldButton;
        case PS3ControllerRightShoulderButton:
            return PS3ControllerCGGamepadRightShouldButton;
        default:
            return PS3ControllerCGGamepadOtherButton;
    }
}

@end
