//
//  PostListVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-04-12.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class PostListVC: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    let jobsSource = [JobOpportunity]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension PostListVC: UITableViewDataSource {

    // MARK: Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let jobOpportuniry = jobsSource[indexPath.row]
        let rawCell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)

        guard let jobCell = rawCell as? JobHistoryCell else {
            print("Not possible convert the cell to JobHistory Cell")
            return rawCell
        }

        jobCell.fillElements(job: jobOpportuniry)

        return jobCell
    }
}
