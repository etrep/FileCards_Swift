//
//  WindowDelegate.swift
//  FileCards
//
//  Created by Eric Trepanier on 2015-05-21.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController, NSWindowDelegate {
	
// MARK: - Properties
	
	@IBOutlet var arrayController: NSArrayController!
	@IBOutlet var transitionStylePopup: NSPopUpButton!

	var files = [FileObject]() // Can't be private because of KVC compliance

	private var splitViewController: NSSplitViewController? {
		return contentViewController as? NSSplitViewController
	}
	
	private var filesViewController: FilesViewController? {
		return (splitViewController?.splitViewItems as! [NSSplitViewItem]).first?.viewController as? FilesViewController
	}
	
	private var pageController: PageController? {
		return (splitViewController?.splitViewItems as! [NSSplitViewItem]).last?.viewController as? PageController
	}

// MARK: - Overrides
	
	func windowWillClose(notification: NSNotification) {
		cleanup()
	}
	
	override func windowDidLoad() {
		setupFiles()
		setupViews()
	}

// MARK: - Actions
	
	@IBAction func filesList(sender: NSButton) {
		if let tableSplitViewItem = splitViewController?.splitViewItems.first as? NSSplitViewItem {
			tableSplitViewItem.animator().collapsed = !tableSplitViewItem.collapsed
		}
	}
	
	@IBAction func navigateBack(sender: NSButton) {
		pageController?.navigateBack(sender)
	}
	
	@IBAction func navigateForward(sender: NSButton) {
		pageController?.navigateForward(sender)
	}
	
	@IBAction func takeTransitionStyleFrom(sender: NSButton) {
		if let transitionStyle = NSPageControllerTransitionStyle(rawValue: sender.selectedTag()) {
			pageController?.transitionStyle = transitionStyle
		}
	}
	
// MARK: - Private
	
	private func cleanup() {
		arrayController.unbind(NSContentArrayBinding)
	}
	
	private func setupFiles() {
		
		let fm = NSFileManager.defaultManager()
		let dirURL = fm.URLForDirectory(.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false, error: nil)
		
		// load all the file card URLs by enumerating through the user's Document folder
		let itr = fm.enumeratorAtURL(dirURL!, includingPropertiesForKeys: [NSURLLocalizedNameKey, NSURLEffectiveIconKey, NSURLIsDirectoryKey, NSURLTypeIdentifierKey], options: .SkipsHiddenFiles | .SkipsPackageDescendants | .SkipsSubdirectoryDescendants, errorHandler: nil)
		
		while let url = itr?.nextObject() as! NSURL? {
			var value: AnyObject?
			url.getResourceValue(&value, forKey: NSURLIsDirectoryKey, error: nil)
			if let isDirNum = value as? NSNumber {
				if isDirNum.boolValue {
					continue
				}
			}
			files.append(FileObject(url: url))
		}
		
		arrayController.bind(NSContentArrayBinding, toObject: self, withKeyPath: "files", options: nil)
	}
	
	private func setupViews() {
		
		for splitViewItem in splitViewController?.splitViewItems as! [NSSplitViewItem] {
			splitViewItem.viewController.representedObject = files
		}
		
		filesViewController?.arrayController = arrayController
		pageController?.arrayController = arrayController
		
		takeTransitionStyleFrom(transitionStylePopup)
	}
}
