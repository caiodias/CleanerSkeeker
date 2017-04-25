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
    var jobsSource = [JobOpportunity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        Facade.shared.getAllJobsOpportunitiesBy(jobStatus: JobStatus.active, onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Facade.shared.getAllJobsOpportunitiesBy(jobStatus: JobStatus.active, onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
    }

    func onFetchJobSuccess(objs: Any) {
        guard let jobs = objs as? [JobOpportunity] else {
            print("Not possible to convert the objs to Job Opoortunity List")
            return
        }

        self.jobsSource = jobs
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func onFetchJobFail(error: Error) {
        Utilities.displayAlert(error)
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
        let rawCell = Bundle.main.loadNibNamed("JobHistoryCell", owner: JobHistoryCell.self, options: nil)?.first

        guard let jobCell = rawCell as? JobHistoryCell else {
            print("Not possible convert the cell to JobHistory Cell")
            // swiftlint:disable force_cast
            return rawCell as! UITableViewCell
        }

        jobCell.fillElements(job: jobOpportuniry)

        return jobCell
    }
}
