//
//  ResetPasswordViewController.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 03/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var resetBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Disable resetBtn
        resetBtn.isEnabled = false

        // Do any additional setup after loading the view.
        email.addTarget(self, action: #selector(emailFieldDidChanged), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetPassword(_ sender: UIButton) {
        if let userEmail = email.text {
            Facade.shared.resetPassword(email: userEmail, onSuccess: { (success) in
                self.showSuccessAlert(success: success)
            }, onFail: { (error) in
                self.showFailAlert(error: error)
            })
        }
    }

    func emailFieldDidChanged(_ email: UITextField) {
        if email.text != nil {
           resetBtn.isEnabled = true
        } else {
            resetBtn.isEnabled = false
        }

    }

    private func showSuccessAlert(success:Any) {
        print("Success \(success)")
        let alert = UIAlertController(title: "Password reset", message: "Check your email to proceed the progress.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Return to login", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    private func showFailAlert(error: Error) {
        print("Error \(error)")
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
