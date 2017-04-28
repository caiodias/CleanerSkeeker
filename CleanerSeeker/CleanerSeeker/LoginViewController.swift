//
//  LoginScreenUI.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 29/03/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class LoginViewController: BasicVC {
    private enum ShowTabController: String {
        case Worker = "workerTabController"
        case JobPoster = "jobPosterTabController"
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.baseScrollView = self.scrollView
    }

    @IBAction func login(_ sender: UIButton) {
        self.handleTap()
        Utilities.showLoading()
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
        Utilities.dismissLoading()

        guard let user = object as? CSUser else {
            print("Not possible convert login object to user")
            return
        }

        if user.userType == CSUserType.Worker.rawValue {
            Facade.shared.updateCurrentUserLoccation()
            displayTabController(tabController: ShowTabController.Worker)
        } else {
            displayTabController(tabController: ShowTabController.JobPoster)
        }
    }

    private func onLoginFail(error: Error) {
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
    }
}
