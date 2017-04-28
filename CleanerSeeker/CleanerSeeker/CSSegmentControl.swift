//
//  CSSegmentControl.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-26.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class CSSegmentControl: UISegmentedControl {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = Utilities.CSColors.green.color.cgColor
//        self.layer.borderWidth = 1.0
        self.tintColor = Utilities.CSColors.green.color
    }
}
