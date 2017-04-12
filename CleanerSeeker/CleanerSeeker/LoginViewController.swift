//
//  LoginScreenUI.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 29/03/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private enum ShowTabController: String {
        case Worker = "workerTabController"
        case JobPoster = "jobPosterTabController"
    }

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

    // MARK: Redirect user to right tab controller
    private func displayTabController(tabController: ShowTabController) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Not possible to get the appDelegate")
            return
        }

        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: tabController.rawValue)

        // Replace root controller
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }

    // MARK: login callbacks
    private func onLoginSuccess(object: Any) {
        print(object)

        if object is Worker {
            displayTabController(tabController: ShowTabController.Worker)
        } else {
            displayTabController(tabController: ShowTabController.JobPoster)
        }
    }

    private func onLoginFail(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: keyboard methods
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -200, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
