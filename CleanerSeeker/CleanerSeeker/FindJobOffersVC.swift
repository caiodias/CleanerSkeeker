//
//  FindJobOffersVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-03-27.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit
import Koloda

class FindJobOffersVC: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    var jobsSource = [JobOpportunity]()
    var jobSelected = JobOpportunity()

    override func viewDidLoad() {
        super.viewDidLoad()

        kolodaView.delegate = self
        kolodaView.dataSource = self

        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reset()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "jobDetails") {
            guard let detailsVC = segue.destination as? JobDetailsVC else {
                print("Not possible to convert the segue")
                return
            }

            detailsVC.jobToDisplay = self.jobSelected
        }
    }
}

extension FindJobOffersVC: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        reset()
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        self.jobSelected = self.jobsSource[index]

        self.performSegue(withIdentifier: "jobDetails", sender: self)
    }
}

extension FindJobOffersVC: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return jobsSource.count
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        var image = Utilities.defaultHouse

        if !self.jobsSource.isEmpty {
            if self.jobsSource[index].spaceType == JobSpaceType.house.rawValue {
                image = Utilities.defaultHouse
            } else {
                image = Utilities.defaultCondo
            }
        }

        return UIImageView(image: image)
    }

//    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
//    }

    func reset() {
        Facade.shared.getJobsInRange(onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)

        if let load = Bundle.main.loadNibNamed("LoadingScreen", owner: self, options: nil)?.first as? SpinnerView {
            self.view.addSubview(load)
            load.center = self.view.center
        }

    }
}
