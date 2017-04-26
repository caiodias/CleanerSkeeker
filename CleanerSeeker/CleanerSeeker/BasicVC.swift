//
//  ViewController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-01-16.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class BasicVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let load = Bundle.main.loadNibNamed("LoadingScreen", owner: self, options: nil)?.first as? SpinnerView {
//
//            self.view.addSubview(load)
//            load.center = self.view.center
//
//        }

//        self.title = Utilities.programName

        observeKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    // MARK: - Keybord observers

    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -200, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }

    func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
