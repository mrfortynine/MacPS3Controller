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
#import <MacPS3Controller/MacPS3Controller.h>

void activateController(MacPS3Controller *controller) {
    controller.valueChangeHandler = ^(MacPS3Controller *controller, id<MacPS3ControllerElement> element) {
        switch(element.type) {
            case MacPS3ControllerButtonElement:
            {
                MacPS3ControllerButton *button = (MacPS3ControllerButton*)element;
                NSLog(@"%@, %@", button.name, (button.state ? @"Pressed" : @"Released"));
                break;
            }
            case MacPS3ControllerThumbStickElement:
            {
                MacPS3ControllerThumbStick *stick = (MacPS3ControllerThumbStick*)element;
                NSLog(@"%@, x = %f, y = %f", stick.name, stick.xValue, stick.yValue);
                break;
            }
        }
    };

    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:MacPS3ControllerDidDisconnectNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"Controller disconnected");
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<MacPS3Controller*> *controllers = [MacPS3Controller controllers];
        NSLog(@"Found %lu controllers", (unsigned long)controllers.count);

        for (MacPS3Controller *controller in controllers) {
            activateController(controller);
        }

        [[NSNotificationCenter defaultCenter] addObserverForName:MacPS3ControllerDidConnectNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull notification) {
            NSLog(@"Controller connected");
            activateController(notification.object);
        }];
    }
    CFRunLoopRun();
    return 0;
}
