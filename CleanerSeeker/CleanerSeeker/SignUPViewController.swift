//
//  SignUPViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-24.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class SignUPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "backToLogin" {
                let vc = segue.destination as! LoginViewController
            }
        }

}
