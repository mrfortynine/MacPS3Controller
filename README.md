MacPS3Controller provides a simple API to support PlayStation 3 DualShock controller in your OS X apps. It borrows ideas from
[DDHidLib] (https://github.com/Daij-Djan/DDHidLib) and [CCController] (https://github.com/slembcke/CCController). In fact, on
potential improvement is to integrate this implementation into [CCController] (https://github.com/slembcke/CCController) to
add PS3 controller into the [CCController] (https://github.com/slembcke/CCController)'s supported controller roster, that is until Apple provides better API support to non-MFi controller.

###Use MacPS3Controller in Objective-C###
Please see [main.m](https://github.com/mrfortynine/MacPS3Controller/blob/master/MacPS3Controller/main.m) for sample code.

###Use MacPS3Controller in Swift###
- Create a bridging header in your swift project. Its content should look like:
```
#ifndef MacPS3Controller_Bridging_Header_h
#define MacPS3Controller_Bridging_Header_h

#import <MacPS3Controller/MacPS3Controller.h>

#endif /* MacPS3Controller_Bridging_Header_h */
```

- In your target build settings, add above header to `Objective-C Bridging Header` field. Note, the path should be relative to
your project directory.
- Using MacPS3Controller in your code. See [main.swift](https://github.com/mrfortynine/MacPS3Controller/blob/master/MacPS3ControllerSwiftTest/main.swift) for sample code.



