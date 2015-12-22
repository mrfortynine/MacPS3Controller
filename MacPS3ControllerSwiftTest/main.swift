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

import Foundation

let controllers = MacPS3Controller.controllers()
NSLog("Found \(controllers.count) controllers")

func activateController(controller: MacPS3Controller) {
    controller.valueChangeHandler = { controller, element in
        switch element.type {
        case .Button:
            if let button = element as? MacPS3ControllerButton {
                NSLog("\(button.name), %@", (button.state != 0) ? "Pressed" : "Released")
            }
            break
        case .ThumbStick:
            if let stick = element as? MacPS3ControllerThumbStick {
                NSLog("\(stick.name), x = \(stick.xValue), y = \(stick.yValue)");
            }
            break
        }
    }

    var observer: NSObjectProtocol?
    observer = NSNotificationCenter.defaultCenter().addObserverForName(MacPS3ControllerDidDisconnectNotification, object: nil, queue: nil) { notification in
        if notification.object === controller {
            NSLog("Controller disconnectd")
            if let o = observer {
                NSNotificationCenter.defaultCenter().removeObserver(o)
            }
        }
    }
}

for controller in controllers {
    activateController(controller)
}

NSNotificationCenter.defaultCenter().addObserverForName(MacPS3ControllerDidConnectNotification, object: nil, queue: nil) { notification in
    guard let controller = notification.object as? MacPS3Controller else {
        return
    }
    NSLog("Controller connected.")
    activateController(controller)
}

CFRunLoopRun();




