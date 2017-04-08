//
//  ProfileViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-25.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile"{
            let vc = segue.destination as! ProfileViewController
        }
    }

    @IBAction func tapOnLogOut(_ sender: Any) {
        Facade.shared.logout(onSuccess: self.onSuccessLogout, onFail: self.onFailLogout)
    }

    func onSuccessLogout(_ user:Any) {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        self.present(loginVC, animated: true, completion: nil)
    }

    func onFailLogout(error: Error?) {
        //@TODO Add alert here?
        print(error ?? "Unknown error occure.")
    }
}
