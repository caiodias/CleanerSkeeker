//
//  ProfileViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-25.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var addressStreet: UITextField!
    @IBOutlet weak var addressUnit: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var email: UITextField!

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        //Populates fields with current user data.
        self.loadCurentUser()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    @IBAction func tapOnPasswordReset(_ sender: Any) {
        if let currentUser = CSUser.current() {
            Facade.shared.resetPassword(email: currentUser.email!, onSuccess: self.onSuccessReset, onFail: self.onFailReset)
        }
    }

    @IBAction func tapOnLogOut(_ sender: Any) {
        Facade.shared.logout(onSuccess: self.onSuccessLogout, onFail: self.onFailLogout)
    }

    @IBAction func tapOnSave(_ sender: Any) {
        // @TODO Call facade update user here
        if let currentUser = CSUser.current() {

            currentUser.firstName = firstName.text!
            currentUser.lastName = lastName.text!
            currentUser.phoneNumber = phone.text!
            currentUser.street = addressStreet.text!
            currentUser.unit = addressUnit.text!
            currentUser.city = city.text!
            currentUser.postalCode = province.text!

            Facade.shared.updateUser(user: currentUser, onSuccess: self.onSuccessUpdate, onFail: self.onFailUpdate)
        }

    }

    // MARK: - Callbacks
    func onSuccessLogout(_ user:Any) {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        self.present(loginVC, animated: true, completion: nil)
    }

    func onFailLogout(error: Error?) {
        //@TODO Add alert here?
        print(error ?? "Unknown error occure.")
    }

    func onSuccessUpdate(_:Any) {
        presentAlert(title: "Success", message: "Your profile was successfully updated", actionButtonText: "OK")
    }

    func onFailUpdate(error: Error) {
        presentAlert(title: "Error", message: error.localizedDescription, actionButtonText: "Try again")
    }

    func onSuccessReset(_:Any) {
        presentAlert(title: "Password reset", message: "Check your email to proceed the progress.", actionButtonText: "OK")
    }

    func onFailReset(error: Error) {
        presentAlert(title: "Error", message: error.localizedDescription, actionButtonText: "Try again")
    }

    // MARK: - Private functions
    fileprivate func loadCurentUser() {
        if let currentUser = CSUser.current() {
            firstName.text = currentUser.firstName
            lastName.text = currentUser.lastName
            phone.text = currentUser.phoneNumber
            addressStreet.text = currentUser.street
            addressUnit.text = currentUser.unit
            city.text = currentUser.city
            province.text = currentUser.postalCode
            email.text = currentUser.email
        }
    }

    // @TODO Make it gloabally accesible mb other screens also need this helper
    fileprivate func presentAlert(title: String, message: String, actionButtonText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionButtonText, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
