//
//  ProfileViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-25.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class ProfileViewController: BasicVC {

    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var addressStreet: UITextField!
    @IBOutlet weak var addressUnit: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var email: UITextField!

    lazy var spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.isHidden = true
        activity.center = CGPoint(x: self.avatar.bounds.width/2, y: self.avatar.bounds.height/2)
        return activity
    }()

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        //Populates fields with current user data.
        self.loadCurentUser()
        self.addAvatarTap()
        avatar.layer.cornerRadius = avatar.frame.width/2
        avatar.layer.masksToBounds = true
        avatar.addSubview(spinner)

        self.baseScrollView = self.scrollView
    }

    @IBAction func didTapOnImageChange(_ sender: Any) {
        imageTapped(sender as AnyObject)
    }

    // MARK: - Actions
    @IBAction func tapOnPasswordReset(_ sender: Any) {
        if let currentUser = CSUser.current() {
            Utilities.showLoading()
            Facade.shared.resetPassword(email: currentUser.email!, onSuccess: self.onSuccessReset, onFail: self.onFailReset)
        }
    }

    @IBAction func tapOnLogOut(_ sender: Any) {
        Utilities.showLoading()
        Facade.shared.logout(onSuccess: self.onSuccessLogout, onFail: self.onFailLogout)
    }

    @IBAction func tapOnSave(_ sender: Any) {
        if let currentUser = CSUser.current() {
            currentUser.firstName = firstName.text!
            currentUser.lastName = lastName.text!
            currentUser.phoneNumber = phone.text!
            currentUser.street = addressStreet.text!
            currentUser.unit = addressUnit.text!
            currentUser.city = city.text!
            currentUser.postalCode = province.text!

            Utilities.showLoading()
            Facade.shared.updateUser(user: currentUser, onSuccess: self.onSuccessUpdate, onFail: self.onFailUpdate)
        }
    }

    // MARK: - Callbacks
    func onSuccessLogout(_ user:Any) {
        Utilities.dismissLoading()

        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        let navigationController = UINavigationController.init(rootViewController: loginVC)
        self.present(navigationController, animated: true, completion: nil)
    }

    func onFailLogout(error: Error) {
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
    }

    func onSuccessUpdate(_ : Any) {
        Utilities.dismissLoading()
        Utilities.displayAlert(title: "Success", message: "Your profile was successfully updated")
    }

    func onFailUpdate(error: Error) {
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
    }

    func onSuccessReset(_ :Any) {
        Utilities.dismissLoading()
        Utilities.displayAlert(title: "Password reset", message: "Check your email to proceed the progress.")
    }

    func onFailReset(error: Error) {
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
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

            // Fetch user profile image from cache or download it using network
            Facade.shared.getUserProfileImage(image: currentUser.avatar, onSuccess: { (data) in

                if let data = data as? Data {
                    self.avatar.image = UIImage(data: data)
                }
                self.spinner.stopAnimating()

            }, onFail: { (error) in
                self.spinner.stopAnimating()
                Utilities.displayAlert(error)
            })
        }
    }

    fileprivate func addAvatarTap() {
        let tapGestureRecigniser = UITapGestureRecognizer.init(target: self, action: #selector(imageTapped(_:)))
        avatar.addGestureRecognizer(tapGestureRecigniser)
    }
}
