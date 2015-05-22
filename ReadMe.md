# FileCards

The language is English.

## Description:
A Swift rewrite of an Apple example that demonstrates the use of NSPageController.

### Summary:
"File Cards" are displayed for the contents of the user's Documents folder.
You can swipe, click the arrow buttons or click on the entry in the table to switch between cards.

### AppDelegate.swift:
Implements the NSApplicationDelegate method that causes the app to terminate when the last window is closed.

### CardBackgroundView.swift:
Draws the rounded edge background of the file cards.

### FileObject:
Simple wrapper around NSURL to make binding to file properties in IB easier.

### FilesViewController.swift:
An NSViewController subclass that shows how to programatically bind its tableView outlet to a shared arrayController's content and selectionIndexes properties.

### PageController.swift:
An NSPageController subclass that also implements the NSPageControllerDelegate methods. 
There are 4 interesting advanced techniques shown in this file:

1. How to use KVO to observe changes to the shared arrayController.selected index property.
2. How to programmatically change the pageController.selectedIndex in response to the above.
3. The use of more than 1 identifier so that we can have 2 card styles.
4. Use of an optional NSPageControllerDelegate to control the layout of the card inside its parent view.

### WindowController.swift:
An NSWindowController subclass that provides the bulk of the application's logic.
There are 2 interesting advanced techniques shown in this file:

1. How to programmatically bind an arrayController to an array of FileObject instances.
2. How to inject the array and its bound arrayController into our child view controllers.

### Main.storyboard:
The application's main storyboard file that defines the application's main menu, the main window  controller and its associated view controllers.

## Build Requirements:
Xcode 6.3, OS X 10.10

## Runtime Requirements:
OS X 10.10 or later

## Changes From Previous Versions:
- 1.0 - First version.
- 1.1 - First public version.
- 2.0 - First Swift version.

===========================================================================
Copyright (C) 2012-2014 Apple Inc. All rights reserved.
