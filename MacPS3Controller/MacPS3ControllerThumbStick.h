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

typedef NS_ENUM(NSInteger, MacPS3ControllerThumbStickID) {
    MacPS3ControllerThumbStickIDLeft,
    MacPS3controllerThumbStickIDRight
};


@interface MacPS3ControllerThumbStick : NSObject<MacPS3ControllerElement>

@property (readonly) NSString *name;
@property (readonly) MacPS3ControllerElementType type;
@property (readonly) MacPS3ControllerThumbStickID thumbStickId;
@property (readonly) float xValue;
@property (readonly) float yValue;

- (instancetype)initWithXAxisElement:(IOHIDElementRef)xAxisElement YAxisElement:(IOHIDElementRef)yAxisElement andId:(MacPS3ControllerThumbStickID)thumbStickId;

@end

