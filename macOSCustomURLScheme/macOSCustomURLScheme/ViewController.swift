//
//  ViewController.swift
//  macOSCustomURLScheme
//
//  Created by Alexander Rinass on 23/08/16.
//  Copyright © 2016 fournova Software GmbH. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate  {

    @IBOutlet var schemeTextField: NSTextField?
    @IBOutlet var schemeHandlersPopUp: NSPopUpButton?
    
    var scheme: String?
    var defaultSchemeHandler: String?
    var schemeHandlers: Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scheme = CustomURLSchemes.foo
        self.schemeTextField?.stringValue = self.scheme!
        self.updateSchemeHandlers()
    }

    func updateSchemeHandlers() {
        if let scheme = self.scheme {
            self.defaultSchemeHandler = LaunchServices.defaultApplicationForURLScheme(scheme: scheme)
            self.schemeHandlers = LaunchServices.applicationsForURLScheme(scheme: scheme)
        } else {
            self.defaultSchemeHandler = nil
            self.schemeHandlers = []
        }

        if let schemeHandlersPopUp = self.schemeHandlersPopUp {
            schemeHandlersPopUp.removeAllItems()
            schemeHandlersPopUp.addItems(withTitles: self.schemeHandlers)

            if let defaultSchemeHandler = self.defaultSchemeHandler  {
                schemeHandlersPopUp.selectItem(withTitle: defaultSchemeHandler)
                schemeHandlersPopUp.isEnabled = true
            }

            if (schemeHandlersPopUp.itemTitles.isEmpty) {
                let title = NSLocalizedString("No handlers", comment: "")
                schemeHandlersPopUp.addItem(withTitle: title);
                schemeHandlersPopUp.selectItem(withTitle: title)
                schemeHandlersPopUp.isEnabled = false
            }
        }
    }

    override func controlTextDidChange(_ obj: Notification) {
        self.updateSchemeHandlers()
    }

    @IBAction func schemeHandlerSelectionDidChange(sender: AnyObject) {
        guard let schemeHandlersPopUp = self.schemeHandlersPopUp else {
            return
        }

        print(schemeHandlersPopUp.titleOfSelectedItem)
    }
}
