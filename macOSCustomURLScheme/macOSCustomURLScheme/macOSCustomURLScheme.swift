//
//  CustomURLSchemeHandler.swift
//  CustomURLSchemeHandler
//
//  Created by Alexander Rinass on 23/08/16.
//  Copyright © 2016 fournova Software GmbH. All rights reserved.
//

import Cocoa
import CoreServices

struct CustomURLSchemes {
    static let foo = "foo"
}

class CustomURLSchemeHandler: NSObject {

    static let shared = CustomURLSchemeHandler()

    func register() {
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(self.handleAppleEvent(event:replyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    func unregister() {
        NSAppleEventManager.shared().removeEventHandler(forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    func handleAppleEvent(event: NSAppleEventDescriptor, replyEvent: NSAppleEventDescriptor) {
        guard let appleEventDescription = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject)) else {
            return
        }

        guard let appleEventURLString = appleEventDescription.stringValue else {
            return
        }

        let appleEventURL = URL(string: appleEventURLString)

        print("Received Apple Event URL: \(appleEventURL)")

        let alert = NSAlert()
        alert.messageText = "Received Apple Event with URL: \(appleEventURL)"
        alert.runModal()
    }
}
