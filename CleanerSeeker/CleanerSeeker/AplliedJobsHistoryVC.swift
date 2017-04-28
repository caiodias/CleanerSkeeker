//
//  AplliedJobsHistoryTVC.swift
//  CleanerSeeker
//
//  Created by Caio Dias on 2017-03-28.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class AplliedJobsHistoryVC: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var segmentControl: CSSegmentControl!
    let segueId = "workerShowJobDetails"
    var jobsSource = [JobOpportunity]()
    var jobSelected: JobOpportunity!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        filterJobList()
    }

    @IBAction func filterJobsValueChanged(_ sender: CSSegmentControl) {
        filterJobList()
    }

    private func filterJobList() {
        var status = JobStatus.none
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            status = JobStatus.applied
        case 1:
            status = JobStatus.done
        default:
            status = JobStatus.applied
        }

        Facade.shared.getAllJobsOpportunitiesBy(jobStatus: status, onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
    }

    private func onFetchJobSuccess(objs: Any) {
        guard let jobs = objs as? [JobOpportunity] else {
            print("Not possible to convert the objs to Job Opoortunity List")
            return
        }

        self.jobsSource = jobs

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    private func onFetchJobFail(error: Error) {
        Utilities.displayAlert(error)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == self.segueId) {
            guard let detailsVC = segue.destination as? JobDetailsVC else {
                print("Not possible to convert the segue")
                return
            }

            detailsVC.jobToDisplay = self.jobSelected
        }
    }
}

extension AplliedJobsHistoryVC: UITableViewDataSource {

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

extension AplliedJobsHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.jobSelected = self.jobsSource[indexPath.row]
        self.performSegue(withIdentifier: self.segueId, sender: self)
    }
}
