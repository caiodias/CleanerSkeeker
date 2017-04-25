//
//  CSPrimary.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 24/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class CSPrimary: CSButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = Utilities.CSColors.green.color
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
