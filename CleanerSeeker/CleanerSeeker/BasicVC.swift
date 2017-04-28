//
//  ViewController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-01-16.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class BasicVC: UIViewController, UITextFieldDelegate {
    var baseScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        observeKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }

    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }

    // MARK: - Keybord observers

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func keyboardWillShow(notification: NSNotification) {
        guard self.baseScrollView != nil else {
            print("BasicVC scrollview not setted")
            return
        }

        guard let userInfo = notification.userInfo else {
            print("Not possible get userInfo")
            return
        }

        guard let keyboardFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            print("Not possible to convert to NSValue")
            return
        }

        let keyboardFrame = self.view.convert(keyboardFrameValue.cgRectValue, from: nil)
        var contentInset: UIEdgeInsets = self.baseScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.baseScrollView.contentInset = contentInset
    }

    func keyboardWillHide(notification: NSNotification) {
        self.baseScrollView.contentInset = UIEdgeInsets.zero
    }
}
