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
    var spaceSelected: Int = JobSpaceType.none.rawValue
    var numberOfBedsSelected: Int = -1
    var numberOfWashroomsSelected: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        self.typeOfSpace.delegate = self
        self.typeOfSpace.dataSource = self

        self.noOfBedroomPicker.delegate = self
        self.noOfBedroomPicker.dataSource = self

        self.noOfWashroomsPicker.delegate = self
        self.noOfWashroomsPicker.dataSource = self

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
            spaceSelected = row
        } else if pickerView == noOfBedroomPicker {
            numberOfBedsSelected = defaultBedAndWashrooms[row]
        } else if pickerView == noOfWashroomsPicker {
            numberOfWashroomsSelected = defaultBedAndWashrooms[row]
        }

        refreshPrice()
    }

    @IBAction func createNewPost(_ sender: Any) {
        if validateFields() {
            let job = JobOpportunity()
            job.address = addressTxtView.text!.trim()
            job.zipcode = zipcodeTxtView.text!.trim()

            let row = self.typeOfSpace.selectedRow(inComponent: 0)
            switch row {
            case 0:
                job.spaceType = JobSpaceType.house.rawValue
            default:
                job.spaceType = JobSpaceType.building.rawValue
            }

            job.numberBedrooms = numberOfBedsSelected
            job.numberWashrooms = numberOfWashroomsSelected
            let hours = NSCalendar.current.component(.hour, from: hoursToClean.date)
            let minutes = NSCalendar.current.component(.minute, from: hoursToClean.date)
            let serviceTotalTime = (hours * 60) + minutes
            job.totalMinutesToWork = serviceTotalTime

            job.jobWorkDate = self.datePicker.date

            Facade.shared.registerJobOpportunity(job: job, onSuccess: onRegisterSuccess, onFail: onRegisterFail)

           Utilities.showLoading()

        } else {
            print("error")
        }
    }

    @IBAction func hoursToWorkValueChanged(_ sender: Any) {
        refreshPrice()
    }

    func refreshPrice() {
        let hours = NSCalendar.current.component(.hour, from: hoursToClean.date)
        let minutes = NSCalendar.current.component(.minute, from: hoursToClean.date)
        let serviceTotalTime = (hours * 60) + minutes
        var labelPriceValue = "$0.00"

        if serviceTotalTime > 0 {
            if numberOfWashroomsSelected >= 0 && numberOfBedsSelected >= 0 {
                let totalPrice = JobOpportunity.calculatePrice(numberOfBeds: numberOfBedsSelected, numberOfWashs: numberOfWashroomsSelected, totalMinutesOfWork: serviceTotalTime)
                labelPriceValue = "$\(totalPrice)"
            }
        }

        self.totalPriceLabel.text = labelPriceValue
    }

    func validateFields() -> Bool {
        let alertTitle = "Did you forgot?"
        guard self.addressTxtView.text != nil else {
            Utilities.displayAlert(title: alertTitle, message: "Address field must be filled.")
            return false
        }

        guard Utilities.validate(string: self.addressTxtView.text!) else {
            Utilities.displayAlert(title: alertTitle, message: "Address field must be filled.")
            return false
        }

        guard self.zipcodeTxtView.text != nil else {
            Utilities.displayAlert(title: alertTitle, message: "Zipcode field must be filled.")
            return false
        }

        guard Utilities.validate(string: self.zipcodeTxtView.text!) else {
            Utilities.displayAlert(title: alertTitle, message: "Zipcode field must be filled.")
            return false
        }

        let hours = NSCalendar.current.component(.hour, from: hoursToClean.date)
        let minutes = NSCalendar.current.component(.minute, from: hoursToClean.date)

        if hours == 0 && minutes == 0 {
            Utilities.displayAlert(title: alertTitle, message: "You must specify how many time will be the work.")
        }

        return true
    }

    // MARK: async methods callback

    private func onRegisterSuccess(obj: Any) {
        Utilities.dismissLoading()
        _ = navigationController?.popViewController(animated: true)
    }

    private func onRegisterFail(error: Error) {
        print(error.localizedDescription)
        Utilities.dismissLoading()
        Utilities.displayAlert(error)
    }
}
