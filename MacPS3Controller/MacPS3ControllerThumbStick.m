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
#import "MacPS3ControllerThumbStick.h"

static NSString* nameForThumbStickId(MacPS3ControllerThumbStickID thumbStickId) {
    switch (thumbStickId) {
        case MacPS3ControllerLeftThumbStick:
            return @"Left Thumb Stick";
            break;
        case MacPS3controllerRightThumbStick:
            return @"Right Thumb Stick";
            break;
    }
}

@interface MacPS3ControllerThumbStick () {
    DDHidElement *_xElement;
    DDHidElement *_yElement;
    MacPS3ControllerThumbStickID _thumbStickId;
}

@end

@implementation MacPS3ControllerThumbStick

- (instancetype)initWithXAxisElement:(IOHIDElementRef)xAxisElement YAxisElement:(IOHIDElementRef)yAxisElement andId:(MacPS3ControllerThumbStickID)thumbStickId {
    setupAxis(xAxisElement);
    _xElement = [[DDHidElement alloc] initWithHIDElement: xAxisElement];
    _xValue = 0;
    setupAxis(yAxisElement);
    _yElement = [[DDHidElement alloc] initWithHIDElement: yAxisElement];
    _yValue = 0;
    _thumbStickId = thumbStickId;
    _name = nameForThumbStickId(thumbStickId);
    return self;
}



- (BOOL)handleValue:(IOHIDValueRef)value forHidElement:(DDHidElement*)element {
    float analog = IOHIDValueGetScaledValue(value, kIOHIDValueScaleTypeCalibrated);
    BOOL processed = false;
    if ([_xElement.usage isEqual:element.usage]) {
        if (_xValue != analog) {
            _xValue = analog;
            processed = true;
        }
    } else if ([_yElement.usage isEqual:element.usage]) {
        // Flip y value so that up is positive which is more intuitive.
        float flipped = -analog;
        if (_yValue != flipped) {
            _yValue = flipped;
            processed = true;
        }
    }
    return processed;
}

- (MacPS3ControllerElementType)type {
    return MacPS3ControllerThumbStickElement;
}

static void setupAxis(IOHIDElementRef element) {
    const CFIndex axisMin = 0;
    const CFIndex axisMax = 256;
    const float deadZonePercent = .2f;

    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationSaturationMinKey), (__bridge CFTypeRef)@(axisMin));
    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationSaturationMaxKey), (__bridge CFTypeRef)@(axisMax));
    CFIndex mid = (axisMin + axisMax) / 2;
    CFIndex deadZone = (axisMax - axisMin) * deadZonePercent;
    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationDeadZoneMinKey), (__bridge CFTypeRef)@(mid - deadZone));
    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationDeadZoneMaxKey), (__bridge CFTypeRef)@(mid + deadZone));
}
@end
