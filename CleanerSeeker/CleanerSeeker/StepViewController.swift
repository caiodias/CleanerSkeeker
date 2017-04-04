//
//  StepViewController.swift
//  CleanerSeeker
//
//  Created by Orest Hazda on 01/04/17.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class StepViewController: UIViewController {

    var delegate: StepViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func maybeSubmitStep() {
        let data = Dictionary<String, Any>()
        delegate?.submitStep(data)
    }

}
