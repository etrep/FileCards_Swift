//
//  FileObject.swift
//  FileCards
//
//  Created by Éric Trépanier on 2015-05-20.
//  Copyright (c) 2015 Apple Inc. All rights reserved.
//

import Cocoa

class FileObject: NSObject {
    
    init(url: NSURL) {
        self.url = url
		super.init()
    }
    
    let url: NSURL
    
    var name: String? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLNameKey, error: nil)
            return value as? String
        }
    }
    
    var localizedName: String? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLLocalizedNameKey, error: nil)
            return value as? String
        }
    }
    
    var dateOfCreation: NSDate? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLCreationDateKey, error: nil)
            return value as? NSDate
        }
    }
    
    var dateOfLastModification: NSDate? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLContentModificationDateKey, error: nil)
            return value as? NSDate
        }
    }
    
    var icon: NSImage? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLEffectiveIconKey, error: nil)
            return value as? NSImage
        }
    }
    
    var sizeInBytes: NSNumber? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLFileSizeKey, error: nil)
            return value as? NSNumber
        }
    }
    
    var utiType: String? {
        get {
            var value: AnyObject?
            url.getResourceValue(&value, forKey: NSURLTypeIdentifierKey, error: nil)
            return value as? String
        }
    }
}

// MARK: - Printable -

extension FileObject: Printable {
	
	override var description: String {
		return "\(self.dynamicType): \(url.path)"
	}
}
