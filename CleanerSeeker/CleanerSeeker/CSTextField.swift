//
//  CSTextField.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 24/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class CSTextField: UITextField {
    let padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = Utilities.CSColors.green.color.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 3.0

        self.borderStyle = .none
        self.font = UIFont.systemFont(ofSize: 17.0)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
