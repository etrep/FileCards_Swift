//
//  PageControllerDelegate.swift
//  FileCards
//
//  Created by Éric Trépanier on 2015-05-20.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

import Cocoa

class PageController: NSPageController {
	
	private let kFileCardIdentifier = "FileCard"
	private let kImageCardIdentifier = "ImageCard"
	private var kvoContext: UInt8 = 1
	
	var arrayController: NSArrayController? {
		didSet {
			arrayController?.addObserver(self, forKeyPath: "selectionIndexes", options: NSKeyValueObservingOptions.New, context: &kvoContext)
		}
	}
	
	override var representedObject: AnyObject? {
		didSet {
			arrangedObjects = representedObject as! [FileObject]
		}
	}
	
	deinit {
		arrayController?.removeObserver(self, forKeyPath: "selectionIndexes", context: &kvoContext)
	}
	
	override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
		if context == &kvoContext {
			if keyPath == "selectionIndexes" {
				let selectedIndex = (object as! NSArrayController).selectionIndexes.firstIndex
				if selectedIndex >= 0 && selectedIndex != self.selectedIndex {

					// The selection of the array controller changed. We want to animate to the new selection.
					// However, since we are manually performing the animation,
					// pageControllerDidEndLiveTransition() will not be called. We are required to
					// call the page controller's completeTransition() when the animation completes.
					//
					NSAnimationContext.runAnimationGroup({ context in
						self.animator().selectedIndex = selectedIndex
					}, completionHandler: {
						self.completeTransition()
					})
				}
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self // NSPageController's delegate outlet is not visible in the storyboard for some reason (bug?)
    }
}

// MARK: - NSPageControllerDelegate -

extension PageController: NSPageControllerDelegate {
	
	// Required method for BookUI mode of NSPageController
	// We have different cards for image files and everything else.
	// Therefore, we have different identifiers
	//
	func pageController(pageController: NSPageController, identifierForObject object: AnyObject!) -> String! {

		let fileObject = object as! FileObject
		if UTTypeConformsTo(fileObject.utiType!, kUTTypeImage) != 0 {
			return kImageCardIdentifier
		}
		return kFileCardIdentifier
	}
	
	// Required method for BookUI mode of NSPageController
	//
	func pageController(pageController: NSPageController, viewControllerForIdentifier identifier: String!) -> NSViewController! {
		return self.storyboard?.instantiateControllerWithIdentifier(identifier) as! NSViewController
	}
	
	// Optional delegate method. This method is used to inset the card a little bit from it's parent view
	//
	func pageController(pageController: NSPageController, frameForObject object: AnyObject!) -> NSRect {
		return NSInsetRect(view.bounds, 5, 5)
	}
	
	func pageControllerDidEndLiveTransition(pageController: NSPageController) {
		
		// Update the array controller selection
		arrayController?.setSelectionIndexes(NSIndexSet(index: pageController.selectedIndex))
		
		// tell page controller to complete the transition and display the updated file card
		pageController.completeTransition()
	}
}
