//
//  CSButton.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 24/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class CSButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.setTitleColor(Utilities.CSColors.green.color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)

    }
}
