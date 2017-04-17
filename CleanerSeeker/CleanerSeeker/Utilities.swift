//
//  Utilities.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class Utilities {
    // swiftlint:disable force_cast
    static let programName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

    class func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }

    static func displayAlert(message: String, okAction: UIAlertAction) {
        self.displayAlert(title: "Error", message: message, okAction: okAction)
    }

    static func displayAlert(title: String, message: String, okAction: UIAlertAction) {
        if let currentWindow = UIApplication.shared.keyWindow {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(okAction)

            currentWindow.rootViewController!.present(alertController, animated: true, completion: nil)
        } else {
            print("Not possible to get the current window")
        }
    }
}
