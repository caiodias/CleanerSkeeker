//
//  SignUpFirstStepViewController.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 29/03/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class SignUpFirstStepViewController: BasicVC {
    @IBOutlet weak var scrollView: UIScrollView!
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

        self.baseScrollView = self.scrollView
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

    private func createUser(type: CSUserType) {
        if validateFields() {
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

            Utilities.showLoading()
            Facade.shared.registerUser(user: user, onSuccess: self.onSuccess, onFail: onFail)
        }
    }

    private func validateFields() -> Bool {
        //TODO: check each field. Please look the AddNewPostViewController validaiton
        return true
    }

    // MARK: - Registeration callbacks

    func onSuccess(_ response:Any) {
        Utilities.dismissLoading()
        guard let user = response as? CSUser else {
            print("Wrong response object has to be PFUser")
            return
        }

        let action = UIAlertAction(title: "Go to Login screen", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popToRootViewController(animated: true)
        }

        Utilities.displayAlert(title: "Registration", message: "Check your email '\(user.email!)' to confirm the registration.", okAction: action)
    }

    func onFail(error: Error) {
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
    }
}
