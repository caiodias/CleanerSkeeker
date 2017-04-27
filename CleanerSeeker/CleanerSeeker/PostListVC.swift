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
    @IBOutlet weak var segmentControl: CSSegmentControl!
    var jobsSource = [JobOpportunity]()
    var jobSelected: JobOpportunity!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

        filterList(according: self.segmentControl.selectedSegmentIndex)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        filterList(according: self.segmentControl.selectedSegmentIndex)
    }

    @IBAction func filterJobsValueChanged(_ sender: CSSegmentControl) {
        filterList(according: sender.selectedSegmentIndex)
    }

    private func filterList(according segmentIndex: Int) {
        var status = JobStatus.none
        switch segmentIndex {
        case 1:
            status = JobStatus.applied
        case 2:
            status = JobStatus.done
        default:
            status = JobStatus.active
        }

        Facade.shared.getAllJobsOpportunitiesBy(jobStatus: status, onSuccess: onFetchJobSuccess, onFail: onFetchJobFail)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetails") {
            guard let detailsVC = segue.destination as? JobDetailsVC else {
                print("Not possible to convert the segue")
                return
            }

            detailsVC.jobToDisplay = self.jobSelected
        }
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

extension PostListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.jobSelected = self.jobsSource[indexPath.row]
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
}
