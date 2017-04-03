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
    let dataSource = FindJobOffersDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        kolodaView.dataSource = dataSource
        kolodaView.delegate = self

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
