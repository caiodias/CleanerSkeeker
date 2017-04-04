//
//  LoginScreenUI.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 29/03/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        observeKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: UIButton) {
        print("Try to login")

        Facade.shared.loginUser(login: userName.text!, password: password.text!, onSuccess: onLoginSuccess, onFail: onLoginFail)
    }

    @IBAction func signUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signup", sender: self)
    }

    private func onLoginSuccess(object: Any) {
        print(object)
    }

    private func onLoginFail(error: Error) {
        print(error.localizedDescription)
    }

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -200, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
