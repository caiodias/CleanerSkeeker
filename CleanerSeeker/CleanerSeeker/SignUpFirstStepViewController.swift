//
//  SignUpFirstStepViewController.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 29/03/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class SignUpFirstStepViewController: UIViewController {
    @IBOutlet weak var fName: UITextField!

    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var addressStreet: UITextField!
    @IBOutlet weak var addressUnit: UITextField!

    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var isCleaner: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        observeKeyboardNotifications()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBackToLogin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func createProfile(_ sender: Any) {
        print("Try to create user")

        //Create user type based on switch
        if isCleaner.isOn {
            createWorker()
        } else {
            createJobPoster()
        }
    }

    private func createWorker() {
        let user = Worker()
        user.firstName = self.fName.text!
        user.lastName = self.lName.text!
        user.address = String(format: "%@ %@ %@ %@", addressStreet.text!, addressUnit.text!, city.text!, postalCode.text!)
        let password = self.password.text!
        let email = self.email.text!

        let success = { success in
            print(success)
        }

        Facade.shared.registerUser(user: user, password: password, email: email, onSuccess: success, onFail: success)
    }

    private func createJobPoster() {
        let user = JobPoster()
        user.firstName = self.fName.text!
        user.lastName = self.lName.text!
        user.address = String(format: "%@ %@ %@ %@", addressStreet.text!, addressUnit.text!, city.text!, postalCode.text!)
        let password = self.password.text!
        let email = self.email.text!

        let success = { success in
            print(success)
        }

        Facade.shared.registerUser(user: user, password: password, email: email, onSuccess: success, onFail: success)
    }

    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

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
