//
//  PostListViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-27.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class PostListViewController: UITableViewController {

    var jobList = ["Clean 1BHK basement", "Clean 2 washroom", "Clean whole house"]

<<<<<<< HEAD
   // @IBOutlet weak var AddBarButton: UIBarButtonItem!
=======
    @IBOutlet weak var addBarButton: UIBarButtonItem!
>>>>>>> a1788722332fd2fdd77ee205031a7f458d7b3d3a

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "post_list")
        self.navigationController?.isToolbarHidden = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "post_list")! as UITableViewCell

        cell.textLabel?.text = self.jobList[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewPost" {
            guard let vc = segue.destination as? AddNewPostViewController else {
                print("Not possible get the segue")
                return
            }
        }
    }

}
