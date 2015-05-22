//
//  AppDelegate.swift
//  FileCards
//
//  Created by Éric Trépanier on 2015-05-20.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}
}
