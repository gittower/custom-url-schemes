//
//  AppDelegate.swift
//  macOSCustomURLScheme
//
//  Created by Alexander Rinass on 23/08/16.
//  Copyright © 2016 fournova Software GmbH. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        CustomURLSchemeHandler.shared.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        CustomURLSchemeHandler.shared.unregister()
    }
}
