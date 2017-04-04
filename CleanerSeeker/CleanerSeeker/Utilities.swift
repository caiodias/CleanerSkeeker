//
//  Utilities.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-02-04.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation

class Utilities {
    static let programName = "Cleaner Seeker"

    class func classNameAsString(obj: Any) -> String {
        return String(describing: type(of: obj))
    }
}
