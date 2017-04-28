//
//  JobDetailsVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-22.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class JobDetailsVC: BasicVC {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    @IBOutlet weak var numberOfWashsLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cleanTimeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipcodeAddress: UILabel!
    @IBOutlet weak var paymentValueLabel: UILabel!
    var jobToDisplay: JobOpportunity!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fillInfo(forJob: self.jobToDisplay)
    }

    private func fillInfo(forJob: JobOpportunity) {
        self.avatar.image = forJob.spaceType == JobSpaceType.house.rawValue ? Utilities.defaultHouse : Utilities.defaultCondo
        self.numberOfBedsLabel.text = String(forJob.numberBedrooms)
        self.numberOfWashsLabel.text = String(forJob.numberWashrooms)
        self.dateTimeLabel.text = Utilities.convertToDisplay(the: forJob.jobWorkDate)
        self.cleanTimeLabel.text = Utilities.convertToHourAndMinutes(the: forJob.totalMinutesToWork)
        self.addressLabel.text = forJob.address
        self.zipcodeAddress.text = forJob.zipcode
        self.paymentValueLabel.text = "$\(forJob.price)"
    }
}
