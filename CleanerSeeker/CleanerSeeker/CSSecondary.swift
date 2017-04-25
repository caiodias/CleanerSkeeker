//
//  CSSecondary.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 24/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class CSSecondary: CSButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = Utilities.CSColors.green.color.cgColor
        self.layer.borderWidth  = 1.0
        self.setTitleColor(Utilities.CSColors.green.color, for: .normal)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
