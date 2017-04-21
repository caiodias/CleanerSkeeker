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
    let defaultHouse = UIImage(named: "default-home")
    let defaultCondo = UIImage(named: "default-condo")
    var jobsSource = [JobOpportunity]()

    override func viewDidLoad() {
        super.viewDidLoad()

        kolodaView.delegate = self
        kolodaView.dataSource = self

        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Facade.shared.getJobsInRange(onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
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

    // MARK: Callbacks

    func onFetchJobSuccess(jobs: Any) {
        guard let jobs = jobs as? [JobOpportunity] else {
            print("Not possible to convert the jobs to JobOpportunity array")
            return
        }

        print("Jobs in range found")
        self.jobsSource = jobs
        DispatchQueue.main.async {
            self.kolodaView.reloadData()
        }
    }

    func onFetchJobFail(error: Error) {
        print("Error on fetch jobs. " + error.localizedDescription)
    }
}

extension FindJobOffersVC: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        reset()
    }

    func koloda(koloda: KolodaView, didSelectCardAt index: Int) {
        // TODO: Call job detail
    }
}

extension FindJobOffersVC: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return jobsSource.count
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        var image = self.defaultHouse

        if !self.jobsSource.isEmpty {
            if self.jobsSource[index].spaceType == JobSpaceType.house.rawValue {
                image = self.defaultHouse
            } else {
                image = self.defaultCondo
            }
        }

        return UIImageView(image: image)
    }

    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }

    func reset() {
        Facade.shared.getJobsInRange(onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
    }
}
