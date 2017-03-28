//
//  JobHistoryCell.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-03-28.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class JobHistoryCell: UITableViewCell {
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    private let dateFormatter = DateFormatter()

    func fillElements(job: JobOpportunity) {
        self.dateLabel.text = dateFormatter.string(from: job.jobWorkDate)
        self.titleLabel.text = job.address
    }
}
