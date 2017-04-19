//
//  FindJobOffersVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-03-27.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit
import Koloda

class FindJobOffersVC: BasicVC {
    @IBOutlet weak var kolodaView: KolodaView!
    var dataSource = FindJobOffersDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        kolodaView.delegate = self

        // Fetch job oportunities and set data source
        Facade.shared.getJobs(onSuccess: { jobs in
            if let arrayOfJobs = jobs as? [JobOpportunity] {
                self.dataSource = FindJobOffersDataSource(jobs: arrayOfJobs)
                self.kolodaView.dataSource = self.dataSource
            }

        }, onFail: { (error) in
            Utilities.displayAlert(error)
        })

        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }

    // MARK: IBActions
    @IBAction func leftButtonTapped() {
        self.kolodaView.swipe(SwipeResultDirection.left)
    }

    @IBAction func rightButtonTapped() {
        self.kolodaView.swipe(SwipeResultDirection.right)
    }

    @IBAction func undoButtonTapped() {
        self.kolodaView.revertAction()
    }
}

extension FindJobOffersVC: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        self.dataSource.reset()
    }

    func koloda(koloda: KolodaView, didSelectCardAt index: Int) {
        // TODO: Call job detail
    }
}
