//
//  AddNewPostViewController.swift
//  CleanerSeeker
//
//  Created by Arpita Patel on 2017-03-27.
//  Copyright © 2017 Caio Dias. All rights reserved.
//

import UIKit

class AddNewPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var typeOfSpace: UIPickerView!
    @IBOutlet weak var noOfBedroomPicker: UIPickerView!
    @IBOutlet weak var noOfWashroomsPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var addressTxtView: UITextField!
    @IBOutlet weak var zipcodeTxtView: UITextField!
    @IBOutlet weak var hoursToClean: UIDatePicker!

    let noOfTypes: [String] = ["House", "Condo"]
    let defaultBedAndWashrooms: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    var bedroomPrice = 7
    var washroomPrice = 5

    var space = ""
    var bed: Int = 0
    var washroom: Int = 0
    var date = ""
    var hours = ""
    var price: Double = 0.0
    var address = ""
    var zip = ""

    let datee = Date()
    let calenderr = Calendar.current
    let timee = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.typeOfSpace.delegate = self
        self.typeOfSpace.dataSource = self

        self.noOfBedroomPicker.delegate = self
        self.noOfBedroomPicker.dataSource = self

        self.noOfWashroomsPicker.delegate = self
        self.noOfWashroomsPicker.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if pickerView == typeOfSpace {
            return noOfTypes.count
        } else if pickerView == noOfBedroomPicker {
            return defaultBedAndWashrooms.count
        } else if pickerView == noOfWashroomsPicker {
            return defaultBedAndWashrooms.count
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typeOfSpace {
            return noOfTypes[row]
        } else if pickerView == noOfBedroomPicker {
            return String(defaultBedAndWashrooms[row])

        } else if pickerView == noOfWashroomsPicker {
            return String(defaultBedAndWashrooms[row])
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typeOfSpace {
            space = noOfTypes[row]
        } else if pickerView == noOfBedroomPicker {
            bed = defaultBedAndWashrooms[row]
        } else if pickerView == noOfWashroomsPicker {
            washroom = defaultBedAndWashrooms[row]
        }

    }

    @IBAction func createNewPost(_ sender: UIButton) {

        if bed == 0.0 {
            bedroomPrice = 7.0
        } else {
            bedroomPrice *= bed
        }

        if washroom == 0.0 {
            washroomPrice = 5.0
        } else {
            washroomPrice *= washroom
        }

        let d = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd-yyyy"
        date = dateformatter.string(from: d as Date)

        let d1 = Date()
        hoursToClean.datePickerMode = UIDatePickerMode.time
        let hr = DateFormatter()
        hr.dateFormat = "hh-mm"
        hours = hr.string(for: d1 as Date)!

        address = addressTxtView.text!
        zip = zipcodeTxtView.text!
        price = Double(bedroomPrice + washroomPrice)

        if let currentUser = CSUser.current() {

            let job = JobOpportunity()
            job.address = address
            job.spaceType =
            job.numberBedrooms = bed
            job.numberWashrooms = washroom
            job.price = price
            job.jobWorkDate = d
            job.hoursToWork = hours
            job.zipcode = zip

            Facade.shared.registerJobOpportunity(user: currentUser, job: job, onSuccess: onAddNewPostSuccess, onFail: onAddNewPostFail)
            job.ownerId = currentUser

            Facade.shared.registerJobOpportunity(job: job, onSuccess: { (success) in
                print("Success \(success)")
            }, onFail: { (error) in
                print("Success \(error)")
            })

        }

        print("Tyoe of Space is : \(space)")
        print("no of bed is : \(bed)")
        print("no of washroom is \(washroom)")
        print("Total price is : \(price)")
        print("Date is : \(date)")
        print("Hours to Clean: \(hours)")
        print("Address is : \(address)")
        print("Address is : \(zip)")
    }

    func resetPrice() {
        price = 0
    }

    private func onAddNewPostSuccess(error: Error) {
        let alert = UIAlertController(title: "Success", message: "New Post Insert successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "Congrulations", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }


    private func onAddNewPostFail(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Error in New post", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }


}
