//
//  JobSummaryVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-25.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class JobSummaryVC: BasicVC {
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var washsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hoursToWorkLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftSquareView: UIView!
    @IBOutlet weak var rightSquareView: UIView!
    @IBOutlet weak var baseView: UIView!
    private let bedsFormat = "Bedrooms: %d"
    private let washsFormat = "Washrooms: %d"
    var job: JobOpportunity!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Round corners for main container
        baseView.layer.cornerRadius = 4
        baseView.layer.masksToBounds = true

        self.topView.backgroundColor = Utilities.CSColors.darkBlue.color
        self.leftSquareView.backgroundColor = Utilities.CSColors.darkBlue.color
        self.rightSquareView.backgroundColor = Utilities.CSColors.darkBlue.color

        self.priceLabel.textColor = Utilities.CSColors.green.color
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fillFields(with: job)
    }

    private func fillFields(with job: JobOpportunity) {
        self.addresslabel.text = "\(job.address), \(job.zipcode)"
        self.bedsLabel.text = String(format: bedsFormat, job.numberBedrooms)
        self.washsLabel.text = String(format: washsFormat, job.numberWashrooms)
        self.dateLabel.text = Utilities.convertToDisplay(the: job.jobWorkDate)
        self.hoursToWorkLabel.text = Utilities.convertToHourAndMinutes(the: job.totalMinutesToWork)
        self.priceLabel.text = "$\(job.price)"
    }
}
