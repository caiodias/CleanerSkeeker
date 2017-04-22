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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func fillInfo(forJob: JobOpportunity) {
        self.avatar.image = forJob.spaceType == JobSpaceType.house.rawValue ? Utilities.defaultHouse : Utilities.defaultCondo
        self.numberOfBedsLabel.text = String(forJob.numberBedrooms)
        self.numberOfWashsLabel.text = String(forJob.numberWashrooms)
        self.dateTimeLabel.text = forJob.jobWorkDate.description
        self.cleanTimeLabel.text = convertMinutesToHourAndMinutesToDisplay(totalMinutes: forJob.totalMinutesToWork)
        self.addressLabel.text = forJob.address
        self.zipcodeAddress.text = forJob.zipcode
        self.paymentValueLabel.text = "$\(forJob.price)"
    }

    func convertMinutesToHourAndMinutesToDisplay(totalMinutes: Int) -> String {
        if totalMinutes > 60 {
            let hours = totalMinutes / 60
            let minutes = totalMinutes % 60

            return "\(hours):\(minutes)"
        } else {
            return "00:\(totalMinutes)"
        }
    }
}
