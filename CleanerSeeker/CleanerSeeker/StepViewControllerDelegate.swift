//
//  StepViewControllerDelegate.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 01/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import Foundation
protocol StepViewControllerDelegate {
    func submitStep(_ data: Dictionary<String, Any>)
}
