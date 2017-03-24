//
//  LoginScreenUI.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-23.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: UIButton) {

    }
    @IBAction func signUp(_ sender: UIButton) {

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signup"{
            let vc = segue.destination as! SignUPViewController
        }
    }
}
