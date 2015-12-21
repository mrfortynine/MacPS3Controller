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
#import "MacPS3ControllerDirectionPad.h"

@interface MacPS3ControllerDirectionPad () {
    DDHidElement *_xElement;
    DDHidElement *_yElement;

    float _xValue;
    float _yValue;
}

@end

@implementation MacPS3ControllerDirectionPad

- (instancetype)initWithXAxisElement:(IOHIDElementRef)xAxisElement YAxisElement:(IOHIDElementRef)yAxisElement andName:(NSString*)name {
    setupAxis(xAxisElement);
    _xElement = [[DDHidElement alloc] initWithHIDElement: xAxisElement];
    _xValue = 0;
    setupAxis(yAxisElement);
    _yElement = [[DDHidElement alloc] initWithHIDElement: yAxisElement];
    _yValue = 0;
    _name = name;
    return self;
}

- (BOOL)handleValue:(IOHIDValueRef)value forHidElement:(DDHidElement*)element {
    float analog = IOHIDValueGetScaledValue(value, kIOHIDValueScaleTypeCalibrated);
    BOOL processed = false;
    if ([_xElement.usage isEqual:element.usage]) {
        _xValue = analog;
        processed = true;
    } else if ([_yElement.usage isEqual:element.usage]) {
        _yValue = analog;
        processed = true;
    }
    if (processed) {
        //NSLog(@"%@: x=%f, y=%f", self.name, _xValue, _yValue);
    }
    return processed;
}

- (MacPS3ControllerElementType)type {
    return MacPS3ControllerThumbStickElement;
}

static void setupAxis(IOHIDElementRef element) {
    const CFIndex axisMin = 0;
    const CFIndex axisMax = 0;
    const float deadZonePercent = .2f;

    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationSaturationMinKey), (__bridge CFTypeRef)@(axisMin));
    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationSaturationMaxKey), (__bridge CFTypeRef)@(axisMax));
    CFIndex mid = (axisMin + axisMax) / 2;
    CFIndex deadZone = (axisMax - axisMin) * deadZonePercent;
    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationDeadZoneMinKey), (__bridge CFTypeRef)@(mid - deadZone));
    IOHIDElementSetProperty(element, CFSTR(kIOHIDElementCalibrationDeadZoneMaxKey), (__bridge CFTypeRef)@(mid + deadZone));
}
@end
