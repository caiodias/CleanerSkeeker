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
    fileprivate var jobsSource: [UIImage] = {
        var array: [UIImage] = []

        for index in 0..<5 {
            array.append(UIImage(named: "cards_\(index + 1)")!)
        }

        return array
    }()

    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return jobsSource.count
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: jobsSource[index])
    }

    func koloda(koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }

    func reset() {
        // TODO: reset the dataSource
    }
}
