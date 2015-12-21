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

#import "DDHidElement.h"
#import "DDHidUsage.h"
#import "NSDictionary+DDHidExtras.h"
#include <IOKit/hid/IOHIDKeys.h>

@interface DDHidElement () {
    IOHIDElementRef _hidElement;
}

@end

@implementation DDHidElement

- (id) initWithHIDElement:(IOHIDElementRef)hidElement {
    _hidElement = (IOHIDElementRef)CFRetain(hidElement);
    unsigned usagePage = IOHIDElementGetUsagePage(_hidElement);
    unsigned usage = IOHIDElementGetUsage(_hidElement);
    mUsage = [[DDHidUsage alloc] initWithUsagePage: usagePage usageId: usage];
    return self;
}

- (void)dealloc {
    CFRelease(_hidElement);
}

- (NSString *) description;
{
    return [[self usage] usageNameWithIds];
}

- (IOHIDElementCookie) cookie;
{
    return IOHIDElementGetCookie(_hidElement);
}

- (DDHidUsage *) usage;
{
    return mUsage;
}

- (NSArray *) elements;
{
    return mElements;
}

- (NSString *) name;
{
    return (__bridge NSString *)(IOHIDElementGetName(_hidElement));
}

- (long) maxValue;
{
    return IOHIDElementGetPhysicalMax(_hidElement);
}

- (long) minValue;
{
    return IOHIDElementGetPhysicalMin(_hidElement);
}

- (NSComparisonResult) compareByUsage: (DDHidElement *) device;
{
    unsigned myUsagePage = [[self usage] usagePage];
    unsigned myUsageId = [[self usage] usageId];

    unsigned otherUsagePage = [[device usage] usagePage];
    unsigned otherUsageId = [[device usage] usageId];

    if (myUsagePage < otherUsagePage)
        return NSOrderedAscending;
    else if (myUsagePage > otherUsagePage)
        return NSOrderedDescending;
    
    if (myUsageId < otherUsageId)
        return NSOrderedAscending;
    else if (myUsageId > otherUsageId)
        return NSOrderedDescending;

    return NSOrderedSame;
}

@end
