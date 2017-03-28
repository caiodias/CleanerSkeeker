//
//  AplliedJobsHistoryTVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-03-28.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class AppliedJobsHistoryTVC: UITableViewController {
    let dataStore = [JobOpportunity]()
}

extension AppliedJobsHistoryTVC {

    // MARK: Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let job = dataStore[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)

        return cell
    }
}
