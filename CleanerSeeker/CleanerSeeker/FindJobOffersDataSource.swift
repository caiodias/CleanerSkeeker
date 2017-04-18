//
//  FindJobOffersDataSource.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-03-27.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit
import Koloda

class FindJobOffersDataSource: NSObject, KolodaViewDataSource {
    fileprivate var jobsSource = [JobOpportunity]()
    private let defaultHouse = UIImage(named: "default-home")
    private let defaultCondo = UIImage(named: "default-condo")

    override init() {
        super.init()
        Facade.shared.getJobs(onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
    }

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
        // TODO: reset the dataSource
    }

    // MARK: Callbacks

    func onFetchJobSuccess(jobs: Any) {
        guard let jobs = jobs as? [JobOpportunity] else {
            print("Not possible to convert the jobs to JobOpportunity array")
            return
        }

        self.jobsSource = jobs
    }

    func onFetchJobFail(error: Error) {
        print("Error on fetch jobs. " + error.localizedDescription)
    }
}
