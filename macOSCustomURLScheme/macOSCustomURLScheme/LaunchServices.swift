//
//  LaunchServices.swift
//  macOSCustomURLScheme
//
//  Created by Alexander Rinass on 23/08/16.
//  Copyright © 2016 fournova Software GmbH. All rights reserved.
//

import Foundation
import CoreServices

class LaunchServices {

    class func applicationsForURLScheme(scheme: String) -> Array<String> {
        if let applications = LSCopyAllHandlersForURLScheme(scheme as CFString) {
            return applications.takeUnretainedValue() as Array<AnyObject> as! Array<String>
        }

        return []
    }

    class func defaultApplicationForURLScheme(scheme: String) -> String? {
        if let defaultApplication = LSCopyDefaultHandlerForURLScheme(scheme as CFString) {
            return defaultApplication.takeUnretainedValue() as String
        }

        return nil
    }

    class func setDefaultApplicationForURLScheme(bundleIdentifier: String, scheme: String) -> Bool {
        let status = LSSetDefaultHandlerForURLScheme(scheme as CFString, bundleIdentifier as CFString)
        return (status == 0)
    }
}
