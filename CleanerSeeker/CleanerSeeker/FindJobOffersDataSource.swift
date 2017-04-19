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

    let jobsSource: [JobOpportunity]

    override init() {
        self.jobsSource = Array<JobOpportunity>()
    }

    init(jobs: [JobOpportunity]) {
        self.jobsSource = jobs
    }

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return jobsSource.count
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {

        let card: UIView = {
            let view = UIView(frame: koloda.frame)
            view.backgroundColor = UIColor.gray

            return view

        }()

        let label = UILabel(frame: CGRect(x: card.bounds.width/2, y: card.bounds.height/2, width: card.bounds.width, height: 30))
        label.text = jobsSource[index].address

        card.addSubview(label)
        return card
    }

    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }

    func reset() {
        // TODO: reset the dataSource
    }
}
