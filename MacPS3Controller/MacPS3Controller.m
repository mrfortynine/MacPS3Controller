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

#import "MacPS3Controller.h"

#import <IOKit/hid/IOHIDLib.h>

#import "DDHidUsage.h"
#import "DDHidElement.h"
#import "MacPS3ControllerDirectionPad.h"
#import "MacPS3ControllerButton.h"

@interface MacPS3Controller () {
    IOHIDDeviceRef _device;
}
@end

@implementation MacPS3Controller

static NSMutableArray * _controllers = nil;



+(void)initialize {
    if (self != [MacPS3Controller class]) {
        return;
    }

    _controllers = [[NSMutableArray alloc] init];
    IOHIDManagerRef hidManager = IOHIDManagerCreate(kCFAllocatorDefault, 0);

    if (IOHIDManagerOpen(hidManager, kIOHIDOptionsTypeNone) != kIOReturnSuccess) {
        NSLog(@"Error opening HID manager");
        return;
    }

    IOHIDManagerRegisterDeviceMatchingCallback(hidManager, ControllerConnected, NULL);
    IOHIDManagerSetDeviceMatchingMultiple(hidManager,
        (__bridge CFArrayRef)@[
                               @{@(kIOHIDDeviceUsagePageKey): @(kHIDPage_GenericDesktop), @(kIOHIDDeviceUsageKey): @(kHIDUsage_GD_GamePad)},
                               @{@(kIOHIDDeviceUsagePageKey): @(kHIDPage_GenericDesktop), @(kIOHIDDeviceUsageKey): @(kHIDUsage_GD_MultiAxisController)},
                               @{@(kIOHIDDeviceUsagePageKey): @(kHIDPage_GenericDesktop), @(kIOHIDDeviceUsageKey): @(kHIDUsage_GD_Joystick)},
                            ]);
    NSString *mode = @"MacPS3Controller initial discovery";
    IOHIDManagerScheduleWithRunLoop(hidManager, CFRunLoopGetCurrent(), (__bridge CFStringRef)mode);
    while(CFRunLoopRunInMode((CFStringRef)mode, 0, TRUE) == kCFRunLoopRunHandledSource){}
    IOHIDManagerUnscheduleFromRunLoop(hidManager, CFRunLoopGetCurrent(), (__bridge CFStringRef)mode);

    IOHIDManagerScheduleWithRunLoop(hidManager, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
}

+(NSArray*)controllers {
    return _controllers;
}

- (instancetype)initWithDevice: (IOHIDDeviceRef) device {
    _leftDirectionPad = [self setUpLeftDirectionPad:device];
    _rightDirectionPad = [self setUpRightDirectionPad:device];
    _buttons = [self setUpButtons:device];
    IOHIDDeviceRegisterInputValueCallback(device, ControllerInput, (void *)CFBridgingRetain(self));
    return self;
}

- (MacPS3ControllerDirectionPad*)setUpLeftDirectionPad:(IOHIDDeviceRef)device {
    IOHIDElementRef xAxis = [self findAxisElement:kHIDUsage_GD_X onDevices:device];
    if (xAxis == nil) {
        return nil;
    }
    IOHIDElementRef yAxis = [self findAxisElement:kHIDUsage_GD_Y onDevices:device];
    if (yAxis == nil) {
        return nil;
    }

    return [[MacPS3ControllerDirectionPad alloc] initWithXAxisElement:xAxis YAxisElement:yAxis andName:@"Left Stick"];
}

- (MacPS3ControllerDirectionPad*)setUpRightDirectionPad:(IOHIDDeviceRef)device {
    IOHIDElementRef xAxis = [self findAxisElement:kHIDUsage_GD_Z onDevices:device];
    if (xAxis == nil) {
        return nil;
    }
    IOHIDElementRef yAxis = [self findAxisElement:kHIDUsage_GD_Rz onDevices:device];
    if (yAxis == nil) {
        return nil;
    }

    return [[MacPS3ControllerDirectionPad alloc] initWithXAxisElement:xAxis YAxisElement:yAxis andName:@"Right Stick"];
}

- (IOHIDElementRef)findAxisElement: (CFIndex)axisUsage onDevices: (IOHIDDeviceRef)device {
    NSDictionary *match = @{
        @(kIOHIDElementUsagePageKey): @(kHIDPage_GenericDesktop),
        @(kIOHIDElementUsageKey): @(axisUsage)
    };

    NSArray *elements = CFBridgingRelease(IOHIDDeviceCopyMatchingElements(device, (__bridge CFDictionaryRef)match, 0));
    if (elements.count > 0) {
        if (elements.count > 1) {
            NSLog(@"Error: Find multiple axises matching usage: %ld", axisUsage);
            return nil;
        } else {
            return (__bridge IOHIDElementRef)elements[0];
        }
    } else {
        NSLog(@"Error: Didn't find any axis matching usage: %ld", axisUsage);
        return nil;
    }

}

- (NSArray*)setUpButtons:(IOHIDDeviceRef)device {
    NSMutableArray* buttons = [NSMutableArray array];
    NSDictionary *match = @ {
        @(kIOHIDElementUsagePageKey): @(kHIDPage_Button)
    };

    NSArray* elements = CFBridgingRelease(IOHIDDeviceCopyMatchingElements(device, (__bridge CFDictionaryRef)match, 0));
    for (id object in elements) {
        IOHIDElementRef element = (__bridge IOHIDElementRef)object;
        if (IOHIDElementGetUsage(element) > 0) {
            [buttons addObject:[[MacPS3ControllerButton alloc] initWithElement:element]];
        }
    }
    return buttons;
}

static void ControllerConnected(void *context, IOReturn result, void *sender, IOHIDDeviceRef device) {
    if (result != kIOReturnSuccess) {
        NSLog(@"ControllerConnected is called with error code: %d", result);
        return;
    }
    MacPS3Controller * controller = [[MacPS3Controller alloc] initWithDevice:device];
    if (controller != nil) {
        [_controllers addObject:controller];
    }
}

static void ControllerInput(void *context, IOReturn result, void *sender, IOHIDValueRef value) {
    if (result != kIOReturnSuccess) {
        NSLog(@"ControllerInput is called with error code: %d", result);
        return;
    }

    MacPS3Controller *controller = (__bridge MacPS3Controller*)context;

    IOHIDElementRef rawElement = IOHIDValueGetElement(value);
    DDHidElement *element = [[DDHidElement alloc] initWithHIDElement:rawElement];
    if (element.usage.usagePage == 1 && element.usage.usageId == 1) {
        return;
    }

    if ([controller.leftDirectionPad handleValue:value forHidElement:element]) {
        return;
    }

    if ([controller.rightDirectionPad handleValue:value forHidElement:element]) {
        return;
    }

    for (id obj in controller.buttons) {
        MacPS3ControllerButton *button = (MacPS3ControllerButton*)obj;
        if ([button handleValue:value forHidElement:element]) {
            return;
        }
    }
}

@end


