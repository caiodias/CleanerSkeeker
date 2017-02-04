//
//  ViewController.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-01-16.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Selector()
        
        Facade.shared.registerUser(user: user, onSuccess: onRegisterSuccess, onFail: onRegisterFail)
        
        self.title = Utilities.getProgamName()
        self.title = Utilities.programName        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onRegisterSuccess(obj: AnyObject) {
        // TODO:
        // show alert that the user was successful registered.
        let loggedUser = obj as! Selector
        
        guard let actualUser = obj as? Selector else {
            // TODO: handle this error scenario
            print("ERROR! PAY ATTENTION")
            return
        }
        
        print(actualUser.firstName)
    }
    
    func onRegisterFail(error: Error) {
        // TODO:
        // show alert that the user was successful registered.
    }
}

