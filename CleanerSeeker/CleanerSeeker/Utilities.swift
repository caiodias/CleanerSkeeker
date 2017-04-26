//
//  Utilities.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit
import Foundation

class Utilities {
    // swiftlint:disable force_cast
    static let programName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
    static let defaultHouse = UIImage(named: "default-home")
    static let defaultCondo = UIImage(named: "default-condo")
    static private let loadingScreen = LoadingScreenVC(nibName: "LoadingScreen", bundle: nil)

    enum CSColors: UInt32 {
        case green
        case darkBlue
        case gray

        var color: UIColor {
            switch self {
            case .green:
                return UIColor(red: 79/255, green: 192/255, blue: 141/255, alpha: 1.0)
            case .darkBlue:
                return UIColor(red: 51/255, green: 71/255, blue: 93/255, alpha: 1.0)
            case .gray:
                return UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 1.0)
            }
        }

    }

    private static let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

    static func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }

    static func displayAlert(_ error: Error) {
        self.displayAlert(title: "Error", message: error.localizedDescription, okAction: okAction)
    }

    static func displayAlert(error message: String) {
        self.displayAlert(title: "Error", message: message, okAction: okAction)
    }

    static func displayAlert(error message: String, andDoAction: UIAlertAction) {
        self.displayAlert(title: "Error", message: message, okAction: andDoAction)
    }

    static func displayAlert(title: String, message: String) {
        self.displayAlert(title: title, message: message, okAction: okAction)
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

    static func convertToDisplay(the date: Date) -> String {
        let calendar = NSCalendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)

        let hours = calendar.component(.hour, from: date)
        let mins = calendar.component(.minute, from: date)

        return "\(month)/\(day)/\(year) \(hours):\(mins)"
    }

    static func convertToHourAndMinutes(the totalMinutes: Int) -> String {
        var hours = 0
        var mins = 0

        if totalMinutes > 59 {
            hours = totalMinutes / 60
            mins = totalMinutes % 60
        } else {
            mins = totalMinutes
        }

        let minsFormatted = String(format: "%02d", mins)
        return "\(hours):\(minsFormatted)"
    }

    static func showLoading() {
        if let currentWindow = UIApplication.shared.keyWindow {
            loadingScreen.view.frame = currentWindow.frame
            currentWindow.addSubview(loadingScreen.view)
        }
    }

    static func dismissLoading() {
        DispatchQueue.main.async {
            loadingScreen.view.removeFromSuperview()
        }
    }

    static func validate(string value: String) -> Bool {
        if !value.isEmpty { // if not empty
            let trimmedString = value.trim()
            return !trimmedString.isEmpty // if after trim is not empty is a valid string
        }

        return false
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
}
