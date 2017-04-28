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
    @IBOutlet weak var buttonsStack: UIStackView!
    @IBOutlet weak var noJobsLabel: UILabel!
    var jobsSource = [JobOpportunity]()
    var jobSelected = JobOpportunity()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.kolodaView.delegate = self
        self.kolodaView.dataSource = self

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

    // MARK: Callbacks

    func onFetchJobSuccess(jobs: Any) {
        Utilities.dismissLoading()
        guard let jobs = jobs as? [JobOpportunity] else {
            print("Not possible to convert the jobs to JobOpportunity array")
            return
        }

        self.jobsSource = jobs
        DispatchQueue.main.async {
            self.kolodaView.reloadData()
        }
    }

    func onFetchJobFail(error: Error) {
        Utilities.dismissLoading()
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
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
        reset()
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        self.jobSelected = self.jobsSource[index]
        self.performSegue(withIdentifier: "jobDetails", sender: self)
    }

    func koloda(_ koloda: Koloda.KolodaView, didSwipeCardAt index: Int, in direction: Koloda.SwipeResultDirection) {
        print("Swipe Direction: \(direction)")
        let job = self.jobsSource[index]

        if direction == SwipeResultDirection.right {
            Facade.shared.apply(to: job, onSuccess: onApplySuccess, onFail: onApplyFail)
        }

        self.jobsSource.remove(at: index)
    }

    func onApplySuccess(obj: Any) {
        Utilities.displayAlert(title: "Applied", message: "Applied successfuly")
    }

    func onApplyFail(error: Error) {
        print("Fail on apply to job: " + error.localizedDescription)
        Utilities.displayAlert(error)
    }
}

extension FindJobOffersVC: KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        displayNoItems(label: jobsSource.isEmpty)
        return jobsSource.count
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let jobDetailsView = JobSummaryVC(nibName: "JobSummaryView", bundle: nil)
        jobDetailsView.job = jobsSource[index]

        return jobDetailsView.view
    }

    func reset() {
        Utilities.showLoading()
        Facade.shared.getJobsInRange(onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
    }

    func displayNoItems(label value: Bool) {
        self.buttonsStack.isHidden = value
        self.noJobsLabel.isHidden = !value
    }
}
