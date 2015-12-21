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

//! Project version number for MacPS3Controller.
FOUNDATION_EXPORT double MacPS3ControllerVersionNumber;

//! Project version string for MacPS3Controller.
FOUNDATION_EXPORT const unsigned char MacPS3ControllerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MacPS3Controller/PublicHeader.h>

#import <MacPS3Controller/MacPS3ControllerDirectionPad.h>
#import <MacPS3Controller/MacPS3ControllerButton.h>
#import <MacPS3Controller/MacPS3ControllerElement.h>

@interface MacPS3Controller : NSObject

@property (readonly) MacPS3ControllerDirectionPad *leftDirectionPad;
@property (readonly) MacPS3ControllerDirectionPad *rightDirectionPad;
@property (readonly) NSArray<MacPS3ControllerButton*> *buttons;

+ (NSArray<MacPS3Controller *> *)controllers;



@end


