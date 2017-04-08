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
            createUser(type: .Worker)
        } else {
            createUser(type: .JobPoster)
        }
    }

    private func createUser(type: PFUserType) {

        let user = CSUser()
        user.email = self.email.text!
        user.username = self.email.text!
        user.password =  self.password.text!
        user.userType = type.rawValue
        user.firstName = self.fName.text!
        user.lastName = self.lName.text!
        user.phoneNumber = self.phone.text!
        user.street = self.addressStreet.text!
        user.unit = self.addressUnit.text!
        user.city = self.city.text!
        user.postalCode = self.postalCode.text!

        Facade.shared.registerUser(user: user, onSuccess: self.onSuccess, onFail: onFail)

    }

    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    // MARK: - Registeration callbacks
    func onSuccess(_ response:Any) {

        guard let user = response as? CSUser else {
            print("Wrong response object has to be PFUser")
            return
        }

        let email = user.email
        let alert = UIAlertController(title: "Registration", message: "Check your email '\(email)' to confirm the registration.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Go to Login screen", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func onFail(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
