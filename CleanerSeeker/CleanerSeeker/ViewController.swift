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
        
        Facade.shared.registerUser()
        
        Facade.shared.listUser()
        
        self.title = Utilities.getProgamName()
        self.title = Utilities.programName        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

