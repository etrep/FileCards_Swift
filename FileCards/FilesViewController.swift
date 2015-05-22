//
//  ViewController.swift
//  FileCards
//
//  Created by Éric Trépanier on 2015-05-20.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

import Cocoa

class FilesViewController: NSViewController {
	
	@IBOutlet var tableView: NSTableView!
	
	var arrayController: NSArrayController! {
		didSet {
			tableView?.bind(NSContentBinding, toObject: arrayController, withKeyPath: "arrangedObjects", options: nil)
			tableView?.bind(NSSelectionIndexesBinding, toObject: arrayController, withKeyPath: "selectionIndexes", options: nil)
		}
	}
	
	private var files = [FileObject]()

    override var representedObject: AnyObject? {
        didSet {
			files = representedObject as! [FileObject]
        }
    }
	
	deinit {
		tableView?.unbind(NSContentBinding)
		tableView?.unbind(NSSelectionIndexesBinding)
	}
}
