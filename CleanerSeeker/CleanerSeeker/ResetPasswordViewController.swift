//
//  ResetPasswordViewController.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 03/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BasicVC {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disable resetBtn
        resetBtn.isEnabled = false
        
        // Do any additional setup after loading the view.
        email.addTarget(self, action: #selector(emailFieldDidChanged), for: .editingChanged)
        self.baseScrollView = self.scrollView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        if let userEmail = email.text {
            Utilities.showLoading()
            Facade.shared.resetPassword(email: userEmail, onSuccess: showSuccessAlert, onFail: showFailAlert)
        }
    }
    
    func emailFieldDidChanged(_ email: UITextField) {
        resetBtn.isEnabled = email.text != nil
    }
    
    private func showSuccessAlert(success:Any) {
        Utilities.dismissLoading()
        let action = UIAlertAction(title: "Return to Login screen", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
        Utilities.displayAlert(title: "Password Reset", message: "Check your email to proceed the progress.", okAction: action)
    }
    
    private func showFailAlert(error: Error) {
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
    }
}
