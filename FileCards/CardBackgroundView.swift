//
//  CardBackgroundView.swift
//  FileCards
//
//  Created by Éric Trépanier on 2015-05-20.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

import Cocoa

class CardBackgroundView: NSView {

    private let kRoundedRadius = CGFloat(5.0)
	
	override func awakeFromNib() {
		autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable;
	}

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let bezierPath = NSBezierPath(roundedRect: self.bounds, xRadius: kRoundedRadius, yRadius: kRoundedRadius)
        bezierPath.lineWidth = 1.0
        NSColor.whiteColor().set()
        bezierPath.fill()
    }
	
	override func menuForEvent(event: NSEvent) -> NSMenu? {
		return nil
	}
	
    override var opaque: Bool {
        get {
            return false
        }
    }
}
